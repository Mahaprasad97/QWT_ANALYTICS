{{config(materialized = 'table',transient = false)}}


select 
Office as id,
OfficeAddress as Address,	
OfficePostalCode as PostalCode,	
OfficeCity	as City,
OfficeStateProvince	as StateProvince,
OfficePhone	as Phone,
OfficeFax as Fax,
OfficeCountry as Country
from {{source('raw_qwt','RAW_OFFICE')}}