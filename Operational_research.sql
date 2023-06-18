CREATE SCHEMA pilot_programme;
USE pilot_programme;
-- Total number of breache offenders
SELECT COUNT(*) FROM all_breaches_df;
-- Total number of pilot tagged offenders
SELECT * FROM pilot_tag_df;
-- What are the distinct tag types
SELECT 
	DISTINCT tag_type
FROM pilot_tag_df
;
-- What are the unique ethnic groups
SELECT 
	DISTINCT ethnic_group
FROM pilot_tag_df
;
-- Merging the two tables
SELECT
	a.offender_name,
    p.dob,
    YEAR(CURDATE()) - EXTRACT(YEAR FROM p.dob) AS age,
    p.sex,
    p.ethnic_group,
    p.tag_type,
    p.original_offence
FROM all_breaches_df a
	LEFT JOIN pilot_tag_df p ON a.offender_id = p.offender_id
;
WITH temp AS
(SELECT
	a.offender_name,
    p.dob,
    YEAR(CURDATE()) - EXTRACT(YEAR FROM p.dob) AS age,
    p.sex,
    p.ethnic_group,
    p.tag_type,
    p.original_offence
FROM all_breaches_df a
	LEFT JOIN pilot_tag_df p ON a.offender_id = p.offender_id
)
SELECT
	COUNT(*)
FROM temp
;
-- Who are the tagged offenders that breached the pilot programme
SELECT
    a.offender_name,
    p.dob,
    YEAR(CURDATE()) - EXTRACT(year FROM p.dob) AS age,
    p.sex,
    p.ethnic_group,
    p.original_offence,
    a.breach_date,
    CASE WHEN p.tag_type IN ('alchohol', 'location', 'curfew')
       THEN 'tagged_offender'
        ELSE  'regular'
	END AS `status`
FROM all_breaches_df a
		LEFT JOIN pilot_tag_df p ON a.offender_id = p.offender_id
;
WITH temp AS
(SELECT
    a.offender_name,
    p.dob,
	YEAR(CURDATE()) - EXTRACT(YEAR FROM p.dob) AS age,
    p.sex,
    p.ethnic_group,
    p.original_offence,
    CASE WHEN p.tag_type IN ('alchohol', 'location', 'curfew')
        THEN 'tagged_offender'
        ELSE  'regular'
	END AS `status`
FROM all_breaches_df a
		LEFT JOIN pilot_tag_df p ON a.offENDer_id = p.offENDer_id
)
/*
SELECT
	sex,
	AVG(age) AS mean,
    COUNT(*) AS n
FROM temp
	WHERE `status` = 'tagged_offender'
		GROUP BY sex
*/
-- Tagged offENDers grouped based on their previous offences
/*
SELECT
	original_offence,
    COUNT(*) AS offender_count
FROM temp
	WHERE `status` = 'tagged_offender'
		GROUP BY 1
        ORDER BY 2 desc
;
*/
-- Tagged offenders grouped into ethnic groups
/*
SELECT
	ethnic_group,
    COUNT(*)AS offender_count
FROM temp
	WHERE `status` = 'tagged_offENDer'
		GROUP BY 1
        ORDER BY 2 desc
;
*/
-- Tagged offenders grouped into sex
/*
SELECT
	sex,
    COUNT(*)AS offENDer_count
FROM temp
	WHERE `status` = 'tagged_offENDer'
	GROUP BY 1
;
*/
/*
SELECT 
	* 
FROM temp
	WHERE `status` = 'tagged_offENDer'
;
*/
-- Count of offenders FROM the pilot program
/*
SELECT 
	`status`,
    COUNT(*)AS offENDer_count
FROM temp
	GROUP BY 1
;
*/
