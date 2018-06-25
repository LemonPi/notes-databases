10.
INSERT INTO hilight 
SELECT DISTINCT s.starid FROM stars AS s, planets AS p, moons AS m
WHERE s.starid >= 20000 
AND p.starid = s.starid
AND p.planetid = m.planetid
AND m.orbitdistance >= 3000;


11.
INSERT INTO hilight 
SELECT DISTINCT s.starid FROM stars AS s, planets AS p,
	(SELECT MAX(orbitdistance) AS mo FROM planets)
	WHERE p.starid = s.starid
	AND p.orbitdistance >= mo;

12.
SELECT s.name AS starname, 
((s.class+7)*s.intensity)*1000000 AS startemp, 
p.name AS planetname, 
((s.class+7)*s.intensity)*1000000 - 50*p.orbitdistance AS planettemp
FROM stars AS s LEFT OUTER JOIN planets AS p ON s.starid = p.starid
WHERE s.starid > 500 AND s.starid < 600;


13.
CREATE VIEW numbers AS 
SELECT 3 AS three, intensity, x
FROM stars
ORDER BY x;

14.
CREATE TABLE colors (
	color INTEGER,
	description TEXT
);
INSERT INTO colors (color, description)
SELECT DISTINCT class, "some description" from stars ORDER BY class;

15.
CREATE TABLE quotes (
	id INTEGER PRIMARY KEY,
	quote TEXT NOT NULL
);
INSERT INTO quotes (id, quote) VALUES 
	(0, "Hello"),
	(1, "World"),
	(2, "Does this work?");

16.
CREATE TABLE alter_test
 (id INTEGER PRIMARY KEY,
  data TEXT NOT NULL);
INSERT INTO alter_test (data) VALUES ('Foo');
INSERT INTO alter_test (data) VALUES ('Bar');
INSERT INTO alter_test (data) VALUES ('Baz');
ALTER TABLE alter_test RENAME TO my_table;
ALTER TABLE my_table ADD COLUMN moredata TEXT;
UPDATE my_table SET moredata = "some data" WHERE id = 0;

17.
DELETE FROM hilight;
INSERT INTO hilight
SELECT starid FROM
(SELECT stars.starid AS starid, COUNT(moons.moonid) + COUNT(planets.planetid) AS orbitals
FROM stars LEFT OUTER JOIN planets ON stars.starid = planets.starid LEFT OUTER JOIN moons ON planets.planetid = moons.planetid
GROUP BY stars.starid 
ORDER BY orbitals DESC, starid
LIMIT 1);

18.
SELECT planets.starid AS starid FROM planets
INTERSECT SELECT planets.starid*3 FROM planets
EXCEPT SELECT planets.starid*2 FROM planets;

19.
DROP TRIGGER starcreate;
CREATE TRIGGER starcreate AFTER INSERT ON stars
BEGIN
DELETE FROM hilight;
INSERT INTO hilight SELECT NEW.starid;
END

20.
ALTER TABLE gateway RENAME TO gateways;