//Cypher script to create the timeseries with 20000 steps in a 300Hz 
WITH range(1, 20000) AS freq
FOREACH(f in freq | CREATE (:Fs300 {id:f*0.003333333}))
        
MATCH (fs:Fs300)
WITH fs
ORDER BY fs.id
WITH collect(fs) as fss
FOREACH(i in RANGE(0, length(fss)-2) | 
    FOREACH(fs1 in [fss[i]] | 
        FOREACH(fs2 in [fss[i+1]] | 
            CREATE UNIQUE (fs1)-[:NEXT]->(fs2))))

//TODO
//Create indexes on the signal model
//Create constraints on the record model