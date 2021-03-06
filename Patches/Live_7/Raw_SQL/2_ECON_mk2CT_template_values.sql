USE [perpetuumsa]
GO

---[ECONOMY REQUEST]  MK2 CT Base values---
--Base MK2 CT pt values set to 10% of vanilla
--A = low (50->5)
--B = mid (100->10)
--C = hi (150->15)

UPDATE
    [dynamiccalibrationtemplates]
SET
    [dynamiccalibrationtemplates].materialefficiency = CASE 
		WHEN defs.definitionname like '%_mk2_A_%' THEN 5
		WHEN defs.definitionname like '%_mk2_B_%' THEN 10
		WHEN defs.definitionname like '%_mk2_C_%' THEN 15
		ELSE 5 END,
    [dynamiccalibrationtemplates].timeefficiency = CASE 
		WHEN defs.definitionname like '%_mk2_A_%' THEN 5
		WHEN defs.definitionname like '%_mk2_B_%' THEN 10
		WHEN defs.definitionname like '%_mk2_C_%' THEN 15
		ELSE 5 END
FROM
    [dynamiccalibrationtemplates] AS mk2CTs
    INNER JOIN entitydefaults AS defs
        ON mk2CTs.definition = defs.definition

GO