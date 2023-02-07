	
DROP PROCEDURE IF EXISTS proc_Salary;
DELIMITER $$
create procedure proc_Salary()
begin
	WITH temp AS (
    SELECT first_name, 
	ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) AS experience, 
           salary, 
           CASE 
               WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) >= 9 THEN 12000
               WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) > 6 THEN 8000
               WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) > 4 THEN 6000
               ELSE 5000
           END AS bonus
    FROM employees
)
SELECT first_name, experience, salary, bonus, salary + bonus AS total_salary
FROM temp;
end;
$$
call proc_Salary()


DROP PROCEDURE IF EXISTS pro_Search_Name;
DELIMITER $$
CREATE PROCEDURE pro_Search_Name(Firstname varchar(20))
begin
	select  employee_id, concat(first_name,' ',last_name) as Fullname,
		email, phone_number, hire_date, job_id, salary, manager_id, department_id 
    from 
		employees
    where
		first_name = Firstname;
end;$$
call pro_Search_Name('David')
delimiter $$