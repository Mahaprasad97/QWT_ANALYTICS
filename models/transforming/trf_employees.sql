{{ config(materialized="table", transient=false, schema=env_var('DBT_TRANSFORMSCHEMA','transforming_dev')) }}

/* Logic commeted on 10/02/2025 and recursive logic added below
select
e1.EmpID ,
e1.LastName ,
e1.FirstName ,
e1.Title ,
e1.HireDate ,	
e1.Office ,
e1.Extension ,	
IFF(e2.FirstName IS NULL,e1.FirstName,e2.FirstName) AS MangerName,
IFF(e2.Title IS NULL,e1.Title,e2.Title) AS ManagerTitle,
e1.YearSalary,
o.Address,
o.City,
o.Country 
from {{ ref("stg_employees") }} as e1
left join {{ ref("stg_employees") }} as e2 
on e1.ReportsTo=e2.EmpID
left join {{ ref("stg_office") }} as o
on e1.Office=o.id 
*/

with recursive managers 
      (indent, office_id, employee_id, employee_name, employee_title, manager_id, manager_name, manager_title) 
    as
    (
 
        select '*' as indent, 
                    office as office_id,
                    empid as employee_id, 
                    firstname as employee_name,
                    title as employee_title, 
                    empid as manager_id, 
                    firstname as manager_name,
                    title as manager_title
          from {{ ref("stg_employees") }} where title = 'President'
 
        union all
 
        select mgr.indent || '*',
            emp.office as office_id,
            emp.empid as employee_id , 
            emp.firstname as employee_name,
            emp.title as employee_title, 
            mgr.employee_id as manager_id, 
            mgr.employee_name as manager_name,
            mgr.employee_title as manager_title
          from {{ ref("stg_employees") }} as emp inner join managers as mgr
            on emp.reportsto = mgr.employee_id
      ),
 
      offices(office_id, office_city, office_country)
      as
      (
      select id as officeid, city, country from {{ ref("stg_office") }}
      )
select indent, employee_id, employee_name, employee_title , 
manager_id, manager_name, manager_title, ofc.office_city, ofc.office_country
from managers as mgr inner join offices as ofc on ofc.office_id = mgr.office_id


