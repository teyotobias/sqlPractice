/*  Gamifying Mastering SQL https://mystery.knightlab.com/ */

SELECT *
FROM crime_scene_report
WHERE date = '20180115' AND city = 'SQL City' AND type = 'murder';

-- date	type	description	city
-- 20180115	murder	Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".	SQL City

SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC;

-- Witness 1:
-- id	name	license_id	address_number	address_street_name	ssn
-- 14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave';

-- Witness 2:
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

SELECT *
FROM interview
WHERE person_id = 14887;

-- Witness 1 Interview:
SELECT *
FROM interview
WHERE person_id = 14887;

-- person_id	transcript
-- 14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

-- Witness 2 Interview:
SELECT *
FROM interview
WHERE person_id = 16371;

-- person_id	transcript
-- 16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

-- Investigating first witness story:
SELECT *
FROM get_fit_now_member
WHERE membership_status = 'gold' AND id LIKE '48Z%';

-- 48Z7A	28819	Joe Germuska	20160305	gold
-- 48Z55	67318	Jeremy Bowers	20160101	gold

SELECT *
FROM get_fit_now_check_in
WHERE check_in_date = '20180109';

-- membership_id	check_in_date	check_in_time	check_out_time
-- 48Z7A	20180109	1600	1730
-- 48Z55	20180109	1530	1700


SELECT *
FROM person
WHERE id = '16371'

-- id	name	license_id	address_number	address_street_name	ssn
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

SELECT *
FROM get_fit_now_member
WHERE person_id = '16371';

-- id	person_id	name	membership_start_date	membership_status
-- 90081	16371	Annabel Miller	20160208	gold


SELECT *
FROM person
WHERE license_id = 183779 or license_id = 423327 OR license_id = 664760;



-- id	name	license_id	address_number	address_street_name	ssn
-- 51739	Tushar Chandra	664760	312	Phi St	137882671
-- 67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279
-- 78193	Maxine Whitely	183779	110	Fisk Rd	137882671

-- The witnesses were talking about this man:

-- id	name	license_id	address_number	address_street_name	ssn
-- 67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279

SELECT *
FROM interview
WHERE person_id = 67318;
person_id	transcript

-- 67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

-- WITH THIS INFORMATION, we know that Jeremy Bowers was the murderer. But who hired him?

SELECT *
FROM drivers_license
WHERE gender = 'female' AND car_make = 'Tesla' AND car_model = 'Model S' AND hair_color = 'red'
AND height BETWEEN 65 and 67;

-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 202298	68	66	green	red	female	500123	Tesla	Model S
-- 291182	65	66	blue	red	female	08CM64	Tesla	Model S
-- 918773	48	65	black	red	female	917UU3	Tesla	Model S

SELECT *, COUNT(*)
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert' AND date LIKE '201712%'
GROUP BY person_id
ORDER BY person_id

-- person_id	event_id	event_name	date	COUNT(*)
-- 24556	1143	SQL Symphony Concert	20171224	3
-- 99716	1143	SQL Symphony Concert	20171229	3

SELECT *
FROM person
WHERE id = 99716;

-- id	name	license_id	address_number	address_street_name	ssn
-- 99716	Miranda Priestly	202298	1883	Golden Ave	987756388


-- NOW, we can safely assume that MIRANDA PRIESTLY ordered the murder. Now let's check our answer.
-- From before, we knew that Jeremy Bowers carried it out.
