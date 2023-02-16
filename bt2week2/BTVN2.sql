
	

-- tạo ra 2 trigger ,2 cái event trên csdl quản lý nhân sự --
-- tạo 1 event trong đó set time để day 16/02 lúc 18h30 thì thưcj hiện chèn dữ liệu vào cho bản employee --

-- cau 2--
delimiter $$
CREATE EVENT IF NOT EXISTS event_test
on schedule at current_timestamp + interval 1 day
DO
BEGIN
	INSERT INTO employees(first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
    VALUES ('Chuong', 'Ha', 'Minhchuong@gmail.com', '0914374444', '2021-08-27', '3', '4000', '100', '9') ;
    END $$

    
-- CAU 1 --
-- tao trigger thong bao loi khi nhap ten country da co san --
drop trigger if exists trigg_country_insert
delimiter $$
create trigger trigg_country_insert
	before insert
	ON countries
    for each row
    BEGIN
		if exists ((select * from countries where country_name = new.country_name)) THEN
        signal sqlstate '45000'
        set MESSAGE_TEXT = 'COUNTRY NAME HAS BEEN EXISTED';
        end if;
	end$$
delimiter $$

-- tao trigger thong bao loi khi xoa nhan vien co nam lam viec < 10 years - 30 years  --
 drop trigger if exists trigg_delete_employee
delimiter $$
create trigger trigg_delete_employee
	before delete
	ON employees
    for each row
    BEGIN
		if (timestampdiff(year, old.hire_date, now()) > 10 and timestampdiff(year, old.hire_date, now()) < 30) THEN
			signal sqlstate '45000'
			set MESSAGE_TEXT = 'day la nhan vien thuong nien';
		end if;
	end$$
delimiter $$

-- TAO EVENT tai gio nay ngay mai them 1 quoc gia   --
delimiter $$
CREATE EVENT IF NOT EXISTS event_insert_country
on schedule at current_timestamp + interval 1 day
DO
BEGIN
	INSERT INTO countries(country_id, country_name, region_id)
    VALUES ('MR', 'ALATISS MEMORY', '3') ;
    END $$

-- tao event xoa nhan vien co luong thap nhat --
delimiter $$
CREATE EVENT event_delete_employee
on schedule at current_timestamp + interval 1 day
do
begin
	DELETE FROM employees where salary < 3000 ;
    end $$
    



    






    

     
	  



