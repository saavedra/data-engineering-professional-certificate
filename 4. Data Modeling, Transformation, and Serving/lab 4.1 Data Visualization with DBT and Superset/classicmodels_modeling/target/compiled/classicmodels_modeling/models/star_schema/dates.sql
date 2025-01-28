
    
with base_dates as (
    
    with date_spine as
(

    





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
    
    

    )

    select *
    from unioned
    where generated_number <= 1095
    order by generated_number



),

all_periods as (

    select (
        

    cast('2003-01-01' as timestamp) + ((interval '1 day') * ((row_number() over (order by 1) - 1)))


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= cast('2005-12-31' as timestamp)

)

select * from filtered



)
select
    cast(d.date_day as timestamp) as date_day
from
    date_spine d


),
dates_with_prior_year_dates as (

    select
        cast(d.date_day as date) as date_day,
        cast(

    d.date_day + ((interval '1 year') * (-1))

 as date) as prior_year_date_day,
        cast(

    d.date_day + ((interval '1 day') * (-364))

 as date) as prior_year_over_year_date_day
    from
    	base_dates d

)
select
    d.date_day,
    cast(

    d.date_day + ((interval '1 day') * (-1))

 as date) as prior_date_day,
    cast(

    d.date_day + ((interval '1 day') * (1))

 as date) as next_date_day,
    d.prior_year_date_day as prior_year_date_day,
    d.prior_year_over_year_date_day,
    -- Monday(1) to Sunday (7)
        cast(date_part('isodow', d.date_day) as integer) as day_of_week,

    to_char(d.date_day, 'FMDay') as day_of_week_name,
    to_char(d.date_day, 'FMDy') as day_of_week_name_short,
    date_part('day', d.date_day) as day_of_month,
    date_part('doy', d.date_day) as day_of_year,

    -- Sunday as week start date
cast(

    date_trunc('week', 

    d.date_day + ((interval '1 day') * (1))

) + ((interval '1 day') * (-1))

 as date) as week_start_date,
    cast(

    -- Sunday as week start date
cast(

    date_trunc('week', 

    d.date_day + ((interval '1 day') * (1))

) + ((interval '1 day') * (-1))

 as date) + ((interval '1 day') * (6))

 as date) as week_end_date,
    -- Sunday as week start date
cast(

    date_trunc('week', 

    d.prior_year_over_year_date_day + ((interval '1 day') * (1))

) + ((interval '1 day') * (-1))

 as date) as prior_year_week_start_date,
    cast(

    -- Sunday as week start date
cast(

    date_trunc('week', 

    d.prior_year_over_year_date_day + ((interval '1 day') * (1))

) + ((interval '1 day') * (-1))

 as date) + ((interval '1 day') * (6))

 as date) as prior_year_week_end_date,
    
cast(to_char(d.date_day, 'WW') as integer) as week_of_year,

    cast(date_trunc('week', d.date_day) as date) as iso_week_start_date,
    cast(

    cast(date_trunc('week', d.date_day) as date) + ((interval '1 day') * (6))

 as date) as iso_week_end_date,
    cast(date_trunc('week', d.prior_year_over_year_date_day) as date) as prior_year_iso_week_start_date,
    cast(

    cast(date_trunc('week', d.prior_year_over_year_date_day) as date) + ((interval '1 day') * (6))

 as date) as prior_year_iso_week_end_date,
    -- postgresql week is isoweek, the first week of a year containing January 4 of that year.
cast(date_part('week', d.date_day) as integer) as iso_week_of_year,

    
cast(to_char(d.prior_year_over_year_date_day, 'WW') as integer) as prior_year_week_of_year,
    -- postgresql week is isoweek, the first week of a year containing January 4 of that year.
cast(date_part('week', d.prior_year_over_year_date_day) as integer) as prior_year_iso_week_of_year,

    cast(date_part('month', d.date_day) as integer) as month_of_year,
    to_char(d.date_day, 'FMMonth')  as month_name,
    to_char(d.date_day, 'FMMon')  as month_name_short,

    cast(date_trunc('month', d.date_day) as date) as month_start_date,
    cast(cast(
        

    

    date_trunc('month', d.date_day) + ((interval '1 month') * (1))

 + ((interval '1 day') * (-1))


        as date) as date) as month_end_date,

    cast(date_trunc('month', d.prior_year_date_day) as date) as prior_year_month_start_date,
    cast(cast(
        

    

    date_trunc('month', d.prior_year_date_day) + ((interval '1 month') * (1))

 + ((interval '1 day') * (-1))


        as date) as date) as prior_year_month_end_date,

    cast(date_part('quarter', d.date_day) as integer) as quarter_of_year,
    cast(date_trunc('quarter', d.date_day) as date) as quarter_start_date,
    
    cast(

    

    date_trunc('quarter', d.date_day) + ((interval '1 month') * (3))

 + ((interval '1 day') * (-1))

 as date) as quarter_end_date,

    cast(date_part('year', d.date_day) as integer) as year_number,
    cast(date_trunc('year', d.date_day) as date) as year_start_date,
    cast(cast(
        

    

    date_trunc('year', d.date_day) + ((interval '1 year') * (1))

 + ((interval '1 day') * (-1))


        as date) as date) as year_end_date
from
    dates_with_prior_year_dates d
order by 1

