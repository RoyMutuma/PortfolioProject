-- SQL Murder Mystery from https://mystery.knightlab.com/#experienced

-- Find murders committed in SQL CIty on 15th Jan 2018 using the Crime_Scene_Report table

Select * 
	from crime_scene_report
	where type = 'murder' 
	and date = 20180115
	and city = 'SQL City'


-- Find withness who lives at the house on "Northwestern Dr" from the Peron table

Select * 
	from person
	where address_street_name = 'Northwestern Dr'
	order by address_number desc

-- Find the first witnesses interview from Interview table

select * 
	from interview
	where person_id = 14887
    
    
-- Find people with gold membership and member number starting with "48Z" from the Get_Fit_Now table

select *
	From get_fit_now_member
	where membership_status = 'gold'
	and id like '%48Z%'
    
    
-- Find information of person with plate_number including "H42W" from drivers_license table

select * 
	from drivers_license
	where plate_number like '%H42W%'
    
    
-- Identify the three potential suspects from the Person table

select *
	from person 
	where license_id in (183379, 423327, 664760)
    

-- Find withness who lives on "FRanklin Ave" from the Peron table

select *
	from person
	where address_street_name = 'Franklin Ave'
	and name like '%Annabel%'
    
    
-- Find the witnesses report in Interview table

select *
	from interview
	where person_id = 16371
    

-- Find the time that the second withness was at the gym on January 9th Get_Fit_Now_Check_In table

select *
	from get_fit_now_member
	where person_id = 16371
    
    
select *
	from get_fit_now_check_in
	where membership_id = 90081


-- Find individual who were at the gym at around the same time as the second witness using Get_Fit_Now_Check_In table

select *
	from get_fit_now_check_in
	where check_in_date = 20180109
	and check_out_time > 1600
	and check_in_time < 1700
    
    

-- Find the three potentials information from Get_Fit_Now_Member table

select * 
	from Get_Fit_Now_Member
	where id in ('48Z7A','48Z55')
    
    
-- Jeremy Bowers is a the common potential murderer from the two witnesses. Confirm using solution table.




    
    










    





