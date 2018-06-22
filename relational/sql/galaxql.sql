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