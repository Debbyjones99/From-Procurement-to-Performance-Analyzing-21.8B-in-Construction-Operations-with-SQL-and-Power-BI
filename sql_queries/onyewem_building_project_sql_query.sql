/* 1.PROJECT PERFORMANCE, DELAYS & OPERATIONAL HEALTH */

/* QUESTION: 1.Calculate total operational cost per project and compare it 
 against project budget to identify projects exceeding budget thresholds 
 
 MY FINDNDS
 
 Finding: Budget variance analysis revealed that 41 projects were over budget, 7 projects
  were in a critical budget stage, and 2 projects were at risk of exceeding their budgets,
   highlighting widespread cost management concerns across the portfolio. 
 */

with project_cost as (
	select 
		t.project_id ,
		sum(t.total_transaction_cost ) as project_cost
	from operations_fact t
	group by project_id 
),
budget_status as (
select 
	pc.project_id,
	pc.project_cost ,
	pd.budget,
	pc.project_cost - pd.budget as variance,
	round(((pc.project_cost - pd.budget ::decimal)/pd.budget )*100, 2) as variance_pct,
	case  
		when project_cost > budget then 'Over budget'
		when project_cost >= budget * 0.9 then 'Critical'
		when project_cost >= budget * 0.8 then 'At risk'
		else 'Healthy'
	end as budget_status
from project_cost pc
join project_dim pd 
on pc.project_id = pd.project_id 
)
select 
	budget_status ,
	count(budget_status ) budget_count 
from budget_status 
group by budget_status ;


/* 2. Generate a project operational health score using:
•	budget utilization
•	average delivery delay
•	utilization efficiency
•	cost control/ cost variance

MY FINDINGS
Finding: The project health assessment identified 41 projects in a critical condition 
and 9 projects at risk, driven by poor budget performance, delivery delays, low utilization
 efficiency, and unfavorable cost variance. These results suggest that a significant portion
 of the project portfolio requires immediate operational and financial intervention to improve overall project performance.
*/

with project_cost as (
	select 
		t.project_id ,
		sum(t.total_transaction_cost ) as project_cost
	from operations_fact t
	group by project_id 
),
budget_utilization as (
	select 
		pc.project_id,
		round(((pc.project_cost::decimal/pd.budget)*100),2) as budget_utilization
	from project_cost pc
	join project_dim pd 
	on pc.project_id = pd.project_id
),
avg_delivery_delay as (
	 select 
		t.project_id ,
		round(avg(t.delivery_delay_days ),1) as avg_delivery_delay
	from operations_fact t
	group by t.project_id
),
utilization_efficiency as (
	select 
		project_id,
		round(count(case 
			when utilization_flag = 'Optimal' then 1
		end)::decimal/ count(*) *100,2) as utilization_efficiency
	from operations_fact t 
	group by project_id 
),
cost_control as (
select
	pc.project_id ,
	round(((pc.project_cost - pd.budget) ::decimal / pd.budget ) *100,2) as cost_variance
from project_cost pc
join project_dim pd  
on pd.project_id  = pc.project_id 
),
project_performance_health as (
	select
		bu.project_id,
		case 
			when budget_utilization <=80 then 25
			when budget_utilization <=100 then 15 
			else 0
		end as budget_score,
		case 
			when avg_delivery_delay <=10 then 25
			when avg_delivery_delay <= 30 then 15
			else 0
		end as delivery_score,
		case 
			when utilization_efficiency >=90 then 25
			when utilization_efficiency >=70 then 15
			else 0
		end utilization_score,
		case 
			when cost_variance <=0 then 25
			when cost_variance <=10 then 15
			else 0
		end cost_control_risk
	from budget_utilization bu
	join avg_delivery_delay ad
	on bu.project_id = ad.project_id
	join utilization_efficiency ue
	on bu.project_id = ue.project_id 
	join cost_control cc
	on cc.project_id = bu.project_id 
),
health_score as (
select
	project_id ,
	utilization_score + delivery_score + budget_score  + cost_control_risk as health_score
from project_performance_health 
),
health_risk as (select 
	project_id,
	health_score,
	case 
		when health_score >= 80 then 'Healthy'
		when health_score >= 50 then 'At Risk'
		else 'Critical'
	end as health_risk	
from health_score
)
select 
	health_risk,
	count(project_id )
from health_risk 
group by health_risk 
/* 3. Calculate month-over-month operational spending growth per project using window functions.
 
 MY FINDINGS 
 Finding: The month-over-month spending analysis showed inconsistent growth patterns across projects,
  suggesting that operational costs were driven by project-specific activities rather than a uniform spending trend.
 * */

with transaction_cost as (
select
	t.project_id ,
	date_trunc('month', po_date) as Order_date,
	sum(t.total_transaction_cost ) as transaction_cost
from operations_fact t   
group by project_id, order_date	
),
previous_transaction_cost as (
	select 
		project_id ,
		order_date,
		transaction_cost ,
		lag(transaction_cost ) over (partition by project_id order by order_date) as previous_transaction_cost
	from transaction_cost 
)
select 
	project_id ,
	order_date,
	transaction_cost ,
	coalesce(previous_transaction_cost, 0) as previous_transaction_cost ,
	coalesce(ROUND(
    ((transaction_cost - previous_transaction_cost)::DECIMAL
    / NULLIF(previous_transaction_cost, 0)) * 100,
    2
), 0) AS mom_spending_growth
from previous_transaction_cost ;

/*4.
Identify locations with the highest operational inefficiencies based on:
•	delays
•	fuel consumption
•	equipment cost
•	transportation cost


Finding: Based on delays, fuel consumption, equipment costs, and transportation costs, 
Lagos emerged as the most operationally inefficient location and was classified as critical,
 while Abuja was identified as at risk. Kano, Ogun, and Port Harcourt were classified as efficient,
  reflecting stronger operational performance and cost management.
*/

with operation_costs as (
	select 
		pd.location,
		round(avg(t.delivery_delay_days ), 2) as avg_delays,
		round(avg(t.fuel_cost), 2) as fuel_consumption,
		ROUND(avg(t.equipment_cost),2) as equipment_cost,
		round(AVG(t.transportation_cost),2) as transportation_cost
	from project_dim pd 
	join operations_fact t 
	on pd.project_id = t.project_id 
	group by "location"
),
operation_cost_rank as (
	select 
		*,
		rank() over(order by avg_delays desc) as delay_rank,
		rank() over(order by fuel_consumption  desc) as fuel_consumption_rank,
		rank() over(order by equipment_cost  desc) as equipment_cost_rank,
		rank() over(order by transportation_cost desc) as transportation_cost_rank 
	from operation_costs 
),
operations_inefficiency as (
	select
		"location",
		delay_rank,
		fuel_consumption_rank,
		equipment_cost_rank,
		transportation_cost_rank , 
		delay_rank + fuel_consumption_rank + equipment_cost_rank + transportation_cost_rank as operations_inefficiency
	from operation_cost_rank 
)
select 
	*,
	case 
		when operations_inefficiency <= 6 then 'critical'
		when operations_inefficiency <= 10 then 'At Risk'
		else 'Efficient'
	end as efficiency_beanchmank
from operations_inefficiency;


/*Question 5.Rank suppliers by average delivery delay and identify suppliers contributing most to operational disruptions.
 
 Finding: Supplier performance analysis based on average delivery delay identified several suppliers as critical
  contributors to operational disruptions. These suppliers recorded the highest delivery delays and were classified
   as Critical Suppliers, indicating a greater likelihood of causing procurement bottlenecks and project delays. 
 * */

with avg_delivery_dayley as (
	select 
		supplier_id, 
		round(avg(t.delivery_delay_days), 2) avg_delivery_delay
	from operations_fact t 
group by supplier_id 
),
delay_rank as (
	select 
		supplier_id,
		avg_delivery_delay,
		rank() over (order by avg_delivery_delay desc) as delay_rank,
		ntile(4) over (order by avg_delivery_delay desc) supplier_quartile
	from avg_delivery_dayley 
),
operation_workflow as (
select
	supplier_id,
	avg_delivery_delay ,
	delay_rank ,
	supplier_quartile,
	case
		when supplier_quartile =1 then 'Critical Supplier'
		when supplier_quartile = 2 then 'High Risk Dupplier'
		when supplier_quartile = 3 then 'Moderaten Risk Supplier'
		else 'Reliable Supplier'
	end as operations_workflow
from delay_rank
)
SELECT *
FROM operation_workflow
WHERE operations_workflow = 'Critical Supplier'
ORDER BY avg_delivery_delay DESC;
;

/*6.
Create a supplier risk classification using:
•	supplier rating
•	average delivery delay
•	total operational spend
Classify suppliers into:
•	Low Risk
•	Medium Risk
•	High Risk

nding: Supplier risk classification identified 36 High Risk suppliers, 51 Medium Risk suppliers,
 and 13 Low Risk suppliers. The results indicate that a significant portion of the supplier base poses 
 moderate to high operational risk, primarily driven by delivery delays and lower supplier ratings.
*/

with supplier_performance as (
	select
		sd.supplier_id,
		avg(sd.rating) avg_rating,
		round(avg(t.delivery_delay_days), 2) as avg_delivery_delay
	from supplier_dim sd 
	join operations_fact t 
	on sd.supplier_id = t.supplier_id 
	group 
	by sd.supplier_id 
),
supplier_quatille as (
select 
	*,
	ntile(3) over(order by avg_rating asc) avg_rating_quatile,
	ntile(3) over(order by avg_delivery_delay desc) avg_delay_quatile
from supplier_performance  
),
risk_score as (
select 
	supplier_id ,
	avg_rating ,
	avg_delivery_delay ,
	avg_rating_quatile,
	avg_delay_quatile,
	avg_delay_quatile + avg_rating_quatile  risk_score
from supplier_quatille 
),
risk_classification as (
	select 
	supplier_id ,
	avg_rating ,
	avg_delivery_delay ,
	risk_score,
	case 
		when risk_score >= 5 then 'High Risk'
		when risk_score >= 3 then 'Medium Risk'
		else 'Low Risk'
	end as Risk_Classification
from risk_score
)
select 
	risk_classification ,
	count(supplier_id )
from risk_classification
group by risk_classification 
;

/* 7.
Identify material categories with:
•	high delivery delays
•	high operational spend
•	high consumption volume

Finding: Material category analysis revealed that Plumbing was the most critical category,
 exhibiting high delivery delays, operational spend, and consumption volume. Finishing, Mechanical, 
 Electrical, and Safety were classified as moderate-risk categories, while Structural materials remained
  stable and posed the lowest operational concern.
*/

with material_category as (
	select 
		md.material_category,
		round(avg(delivery_delay_days), 2) avg_delivery_delay,
		sum(t.material_cost ) total_spend	,
		sum(t.quantity) total_consumption
	from material_dim md 
	join operations_fact t 
	on md.material_id = t.material_id 
	group by md.material_category 
),
materials_quatile as (
	select 
		*,
		ntile(3) over(order by avg_delivery_delay asc ) as delay_quatile,
		ntile(3) over(order by total_spend desc ) as spend_quatile,
		ntile(3) over(order by total_consumption desc ) as consumption_quatile
	from  material_category
),
material_score as (
	select
		*,
		delay_quatile + spend_quatile + consumption_quatile as material_score
	from materials_quatile 
)
select 
	*,
	case 
		when material_score >= 8 then 'Critical Material Category'
		when material_score >= 5 then 'Moderate  Material Category'
		else 'Stable Material Category'
	end as Material_Category
from material_score 
/*“These are the material categories consuming the most resources and creating the most operational pressure.”*/;

/* 8.
Identify suppliers heavily relied upon for critical material categories

Finding: Analysis of supplier contributions across material categories revealed a highly diversified 
supplier network. No supplier accounted for more than 2% of total category volume, indicating low supplier 
dependency and reduced concentration risk within the procurement process.
*/

with supplier_categoery_qty as (
	select
		md.material_category ,
		t.supplier_id ,
		sum(quantity) as supplier_qty
	from operations_fact t 
	join material_dim md 
	on md.material_id = t.material_id 
	group by md.material_category ,
		t.supplier_id
),
category_total_qty as (
	select
		md.material_category,
		sum(t.quantity) as total_qty
	from operations_fact t 
		join material_dim md 
		on md.material_id = t.material_id 
	group by material_category 
),
supplier_category_share as (
	select
		sc.supplier_id ,
		sc.material_category ,
		sc.supplier_qty,
		tc.total_qty ,
		round(sc.supplier_qty ::decimal/tc.total_qty *100,2) percent_by_category
	from supplier_categoery_qty sc
	join category_total_qty tc
	on sc.material_category = tc.material_category 
)
select
	*,
	rank() over(partition by material_category order by  percent_by_category desc) supplier_rank_in_category
from supplier_category_share ;


/* 9. Identify underutilized workers assigned to active projects based on transaction activity and utilization patterns.

 * Finding: Worker utilization analysis on active projects revealed varying levels of underutilized activity across
 *  the workforce. Worker 40217 recorded the highest number of underutilized transactions (15), while several others 
 * recorded 13–12 underutilized activities. These findings suggest potential inefficiencies in workforce allocation and
 *  opportunities to improve labor utilization across active projects.
 * */


with untilized_workers as (
	select 
		t.worker_id,
		count(t.transaction_id) no_of_undertilized_workers
	from operations_fact t 
	join project_dim pd 
	on pd.project_id = t.project_id 
	where pd.project_status = 'Active' and utilization_flag = 'Underutilized'
	group by t.worker_id
)
select 
	*,
	row_number() over(order by no_of_undertilized_workers desc) as untilised_ranking
from untilized_workers

/*10. Compare contractor-based labor cost against full-time labor cost across projects.
 
 Finding: Analysis of labor costs across 50 projects showed that contractor labor was the primary
  cost driver in 26 projects, while permanent employees accounted for higher labor costs in 24 projects.
   The near-even distribution indicates that the organization maintains a mixed workforce model, relying 
   on both contract and permanent labor depending on project demands. Projects with substantially higher contractor 
   costs may warrant further review to assess potential opportunities for workforce optimization and cost control.*/


with contract_labour_cost as (
select 
	t.project_id,
	sum(t.labor_cost) as contract_labour_cost
from operations_fact t 
join workers_dim wd 
on wd.worker_id  = t.worker_id 
where employment_type = 'Contract'
group by t.project_id 
),
permanent_labor_cost as (
select 
	t.project_id,
	sum(t.labor_cost) as Permanent_labor_cost
from operations_fact t 
join workers_dim wd 
on wd.worker_id  = t.worker_id 
where employment_type = 'Permanent'
group by t.project_id 
)
select 
	coalesce(cl.project_id, 0) as project_id,
	coalesce(cl.contract_labour_cost, 0) contract_labour_cost,
	coalesce(pl.permanent_labor_cost,0) permanent_labor_cost,
	coalesce(cl.contract_labour_cost,0) -coalesce(pl.permanent_labor_cost) employment_status_cost_difference,
	case
		when coalesce(cl.contract_labour_cost, 0) > coalesce(pl.permanent_labor_cost,0) then 'Contract_cost_higher'
		when coalesce(cl.contract_labour_cost, 0) < coalesce(pl.permanent_labor_cost,0) then 'Permenent_cost_higher'
	else 'Equal_cost'
	end Labor_cost_driver
from contract_labour_cost cl 
 full outer join permanent_labor_cost pl
 on cl.project_id = pl.project_id ;

/*11.
Find the top 3 operational cost-driving trades using ranking functions.

Finding: Carpenters, Masons, and Welders were the top three workforce trades by operational cost, 
contributing approximately ₦3.70 billion, ₦3.56 billion, and ₦3.07 billion respectively to total project operations.
*/

with total_operational_cost as(
	select
		wd.trade,
		SUM(t.total_transaction_cost) total_operational_cost
	from operations_fact t 
	join workers_dim wd 
	on t.worker_id = wd.worker_id 
	group by wd.trade
),
trade_rank as (
	select 
		trade,
		total_operational_cost,
		rank() over(order by total_operational_cost desc) as trade_rank
	from total_operational_cost
)
select
	*
from trade_rank 
where trade_rank <=3

/*12.
Identify workers whose daily rates exceed the average for their:
•	trade •	skill level */

/*Finding: Daily rate benchmarking identified workers whose compensation exceeded both trade-specific
 *  and skill-level averages. High-rate workers were observed across all major trades, particularly among Masons,
 *  Electricians, Plumbers, and Carpenters. Several workers earned more than ₦9,000 per day compared to trade averages
 *  ranging between ₦5,500 and ₦6,600, indicating a concentration of premium-skilled labor within the workforce.*/
WITH worker_details AS (
    SELECT
        worker_id,
        trade,
        skill_level,
        daily_rate
    FROM workers_dim
),
trade_avg AS (
    SELECT
        trade,
        ROUND(AVG(daily_rate), 0) AS avg_trade_rate
    FROM workers_dim
    GROUP BY trade
),
skill_avg AS (
    SELECT
        skill_level,
        ROUND(AVG(daily_rate), 0) AS avg_skill_rate
    FROM workers_dim
    GROUP BY skill_level
)
SELECT
    wd.worker_id,
    wd.trade,
    wd.skill_level,
    wd.daily_rate,
    ta.avg_trade_rate,
    sa.avg_skill_rate
FROM worker_details wd
JOIN trade_avg ta
    ON wd.trade = ta.trade
JOIN skill_avg sa
    ON wd.skill_level = sa.skill_level
WHERE wd.daily_rate > ta.avg_trade_rate
  AND wd.daily_rate > sa.avg_skill_rate;


/*13.
Identify projects with abnormal fuel costs relative to equipment usage days.

Finding: Fuel cost efficiency was evaluated by comparing fuel cost per equipment usage day
 across projects. No projects exceeded the abnormality threshold of 150% above the portfolio average,
  indicating relatively consistent fuel consumption patterns across all projects. This suggests fuel costs 
  were generally proportional to equipment utilization and did not exhibit significant outlier behavior.*/


with fuel_cost_per_day as (
	select
		t.project_id,
		round(sum(fuel_cost)::decimal/nullif(sum(equipment_usage_days),0), 2) as fuel_cost_per_day
	from operations_fact t 
	group by project_id
),
avg_fuel_cost as (
	select 
		avg(fuel_cost_per_day) as Avg_fuel_cost
	from fuel_cost_per_day 
)
select 
	fc.project_id,
	fc.fuel_cost_per_day,
	af.avg_fuel_cost,
	case 
		when fuel_cost_per_day > avg_fuel_cost * 1.5 then 'Abnormal fuel cost'
		else 'normal fuel cost'
	end fuel_status
from fuel_cost_per_day fc
cross join avg_fuel_cost af;



/*14.
Detect operational transactions with unusually high:
•	fuel costs
•	equipment costs
•	transportation costs
compared to project averages.
*/

with operational_cost as (
	select 
		t.project_id,
		sum(t.fuel_cost ) as fuel_cost,
		sum(t.equipment_cost ) as equipment_cost,
		sum(t.total_transaction_cost ) as transportation_cost
	from operations_fact t 
	group by project_id 
),
avg_cost as (
	select 
		round(avg(fuel_cost ), 2) as avg_fuel_cost,
		round(avg(equipment_cost ), 2) as avg_equipment_cost,
		round(avg(transportation_cost ),2) as avg_transportation_cost
	from operational_cost
)
select
	oc.project_id,
	oc.fuel_cost,
	avg_fuel_cost,
	case 
		when oc.fuel_cost > ac.avg_fuel_cost then 'Unsual High Operational cost'
		when oc.fuel_cost = ac.avg_fuel_cost then 'Moderate Operational cost'
		else 'low Operational cost'
	end as operation_fuel_cost_status,
	case 
		when oc.equipment_cost > ac.avg_equipment_cost then 'Unsual High Operational cost'
		when oc.equipment_cost  = ac.avg_equipment_cost then 'Moderate Operational cost'
		else 'low Operational cost'
	end as operation_equipment_cost_status,
	case 
		when oc.transportation_cost > ac.avg_transportation_cost then 'Unsual High Operational cost'
		when oc.transportation_cost  = ac.avg_transportation_cost then 'Moderate Operational cost'
		else 'low Operational cost'
	end as operation_fuel_cost_status	
from operational_cost oc
cross join avg_cost ac;

/*14.
Detect operational transactions with unusually high:
•	fuel costs
•	equipment costs
•	transportation costs
compared to project averages.

Operational transactions were compared against their respective project averages. 
Transactions whose fuel, equipment, or transportation costs exceeded 150% of the project’s
 average cost were flagged as unusually high, helping identify potential overspending, inefficiencies, or exceptional operational activities.
*/
with project_avg_cost as (
    select
        project_id,
        avg(fuel_cost) as avg_fuel_cost,
        avg(equipment_cost) as avg_equipment_cost,
        avg(transportation_cost) as avg_transportation_cost
    from operations_fact
    group by project_id
)
select
    t.transaction_id,
    t.project_id,
    t.fuel_cost,
    p.avg_fuel_cost,
    case
        when t.fuel_cost > p.avg_fuel_cost * 1.5
        then 'Unusually High'
        else 'Normal'
    end as fuel_status,
    t.transaction_id ,
      t.project_id,
    t.transportation_cost,
    p.avg_transportation_cost,
    case
        when t.equipment_cost> p.avg_equipment_cost  * 1.5
        then 'Unusually High'
        else 'Normal'
    end as equipment_status,
     t.transaction_id,
    t.project_id,
    t.transportation_cost,
    p.avg_transportation_cost,
    case
        when t.transportation_cost > p.avg_transportation_cost * 1.5
        then 'Unusually High'
        else 'Normal'
    end as transportation_status
from operations_fact t
join project_avg_cost p
    on t.project_id = p.project_id;

