{{config(materialized = 'table',transient = false)}}


--it creates a transient table at snow. to create permanent table, use transient=false.
select 
EmpID ,
LastName ,
FirstName ,
Title ,
HireDate ,	
Office ,
IFF(Extension='-','NA',Extension) AS Extension ,	
ReportsTo ,
YearSalary 
 from {{source('raw_qwt','RAW_EMPLOYEES')}}