Select Count(first_name) from employees
Group by first_name, last_name;

select count(Distinct emp_no) from salaries
where to_date>='2022-03-18';

SELECT count(Distinct title) from titles;

SELECT ROUND(AVG(salary),2) as srednia, ROUND(STDDEV_SAMP(salary),2) as odchylenie from salaries
WHERE to_date>='2022-03-18';