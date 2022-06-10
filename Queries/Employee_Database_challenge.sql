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
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- mentorship_eligibilty 1
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

-- -- mentorship_eligibilty 2
-- SELECT DISTINCT ON (t.emp_no) ede.emp_no, ede.first_name, ede.last_name, ede.birth_date,
-- 	ede.from_date, ede.to_date,
-- 	t.title
-- --INTO mentorship_eligibilty
-- 	FROM (SELECT DISTINCT ON (de.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
-- 		de.from_date, de.to_date
-- 		FROM employees AS e
-- 		LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
-- 	WHERE de.to_date = '9999-01-01' AND
-- 		(birth_date BETWEEN '1965-01-01' AND '1965-12-31')
-- 	ORDER BY de.emp_no) AS ede
-- 		LEFT JOIN titles AS t ON ede.emp_no = t.emp_no
-- ORDER BY t.emp_no;

-- -- mentorship_eligibilty 3
-- SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
-- 	de.from_date, de.to_date,
-- 	t.title
-- --INTO mentorship_eligibilty
-- FROM employees AS e
-- 	LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
-- 		LEFT JOIN titles AS t ON e.emp_no = t.emp_no
-- WHERE de.to_date = '9999-01-01' AND
-- 	(birth_date BETWEEN '1965-01-01' AND '1965-12-31')
-- ORDER BY emp_no;


-- SELECT * FROM dept_emp
-- WHERE emp_no = 10291;

-- SELECT * FROM titles
-- WHERE emp_no = 10291 OR emp_no = 10476 OR emp_no = 10762 OR emp_no = 12643;
