-- retirement_titles
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles as t ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- unique_titles
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- retiring_titles
SELECT COUNT(emp_no) AS count, title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- mentorship_eligibilty 1965
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
	LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
		LEFT JOIN titles AS t ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01' AND
	(birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

--DROP TABLE mentorship_eligibilty_1962_65;
-- mentorship_eligibilty 1962-65
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	t.title
INTO mentorship_eligibilty_1962_65
FROM employees AS e
	LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
		LEFT JOIN titles AS t ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01' AND
	(birth_date BETWEEN '1962-01-01' AND '1965-12-31')
ORDER BY emp_no;

-- mentorship_eligibilty_1962_65_titles
SELECT COUNT(emp_no) AS count, title
--INTO mentorship_eligibilty_1962_65_titles
FROM mentorship_eligibilty_1962_65
GROUP BY title
ORDER BY count DESC;
