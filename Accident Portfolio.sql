use [Accident Portfolio]
go

select * from dbo.Accidents



-- Total Casualties
select 
	count(Accident_Index) as Total_Accidents,
	sum(Number_of_casualties) as Total_Casualties
from dbo.Accidents


-- Total Casualties in 2021
select 
	count(Accident_Index) as Total_Accidents_in_2021,
	sum(Number_of_casualties) as Total_Casualties_in_2021
from dbo.Accidents
where year([Accident Date]) = 2021


-- Total Casualties in 2022
create view [2022_Casualties] as (
select 
	count(Accident_Index) as Total_Accidents_in_2022,
	sum(Number_of_casualties) as Total_Casualties_in_2022
from dbo.Accidents
where year([Accident Date]) = 2022
)



-- Total Casualties by Accidents Severity
-- Fatal
select
	count(Accident_Index) as Count_Accidents,
	sum(Number_of_Casualties) as Total_Casualties
from dbo.Accidents
where year([Accident Date]) = 2022
group by Accident_Severity
having Accident_Severity = 'Fatal'

-- Serious
select
	count(Accident_Index) as Count_Accidents,
	sum(Number_of_Casualties) as Total_Casualties
from dbo.Accidents
where year([Accident Date]) = 2022
group by Accident_Severity
having Accident_Severity = 'Serious'

-- Slight
select
	count(Accident_Index) as Count_Accidents,
	sum(Number_of_Casualties) as Total_Casualties
from dbo.Accidents
where year([Accident Date]) = 2022
group by Accident_Severity
having Accident_Severity = 'Slight'



-- Total Casualties by Vehicles
select
	Vehicle_Type, 
	sum(Number_of_Casualties) as Total_Casualties_by_Vehicle
from dbo.Accidents
where year([Accident Date]) = 2022
group by Vehicle_Type



-- Total Casualties by Year, Month
select
	year([Accident Date]) as Year,
	month([Accident Date]) as Month,
	sum(Number_of_Casualties) as Total_Casualties
from dbo.Accidents
group by year([Accident Date]), month([Accident Date])
order by 1, 2



-- Casualties Percentage in urban / rural 2022
with area as (
	select 
		Urban_or_Rural_Area,
		sum(Number_of_Casualties) as Total_Casualties_in_area
	from dbo.Accidents
	where year([Accident Date]) = 2022
	group by Urban_or_Rural_Area
)
select *, Total_Casualties_in_area / (select Total_Casualties_in_2022 from [2022_Casualties]) * 100 as PCT_Casualties
from area



-- Total Casualties by Light conditions 2022
with Light_conditions as (
	select
		Light_Conditions,
		sum(Number_of_Casualties) as Total_Casualties_by_Light_conditions
	from Accidents
	where year([Accident Date]) = 2022
	group by Light_Conditions
)
select *, Total_Casualties_by_Light_conditions / (select Total_Casualties_in_2022 from [2022_Casualties]) * 100 as PCT_Casualties
from Light_conditions



-- Total Casualties by Road Type
with Road_Type as (
	select
		Road_Type,
		sum(Number_of_Casualties) as Total_Casualties
	from Accidents
	where year([Accident Date]) = 2022
	group by Road_Type
)
select *, Total_Casualties / (select Total_Casualties_in_2022 from [2022_Casualties]) * 100 as PCT_Casualties
from Road_Type