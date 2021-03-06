USE [perpetuumsa]
GO

PRINT N'Relic EntityDefault for server unit creation';

INSERT INTO [dbo].[entitydefaults]
           ([definitionname]
           ,[quantity]
           ,[attributeflags]
           ,[categoryflags]
           ,[options]
           ,[note]
           ,[enabled]
           ,[volume]
           ,[mass]
           ,[hidden]
           ,[health]
           ,[descriptiontoken]
           ,[purchasable]
           ,[tiertype]
           ,[tierlevel])
     VALUES
           ('def_relic'
           ,1
           ,1024
           ,0 --TODO is this ok?
           ,NULL
           ,'Relic'
           ,1
           ,1
           ,1
           ,0
           ,100
           ,NULL
           ,0
           ,NULL
           ,NULL)
GO

PRINT N'Relic Definition - Add absurd masking';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_relic' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 99999999);
GO


PRINT N'Relics - Initial config and settings 2019-01-19';

PRINT N'Dropping all Relic-related tables - This should be the first Relic Patch';
DROP TABLE IF EXISTS dbo.relicloot;
DROP TABLE IF EXISTS dbo.relicspawninfo;
DROP TABLE IF EXISTS dbo.relictypes;
DROP TABLE IF EXISTS dbo.reliczoneconfig;

PRINT N'Create all the Relic tables';
CREATE TABLE dbo.relictypes(
id INT NOT NULL IDENTITY PRIMARY KEY,
name VARCHAR(128) NOT NULL,
raceid INT NULL,
level INT NULL,
ep INT NULL
);

CREATE TABLE dbo.relicloot(
id INT NOT NULL IDENTITY PRIMARY KEY,
definition INT NOT NULL,
minquantity INT NOT NULL,
maxquantity INT NOT NULL,
chance DECIMAL(9,6) NOT NULL,
relictypeid INT NOT NULL,
packed BIT NOT NULL
);

CREATE TABLE dbo.relicspawninfo(
id INT NOT NULL IDENTITY PRIMARY KEY,
relictypeid INT NOT NULL,
zoneid INT NOT NULL,
rate INT NOT NULL,
x INT NULL,
y INT NULL
);

CREATE TABLE dbo.reliczoneconfig(
id INT NOT NULL IDENTITY PRIMARY KEY,
zoneid INT NOT NULL,
maxspawn INT NOT NULL,
respawnrate INT NOT NULL
);

PRINT N'Set the Relic Zone Configurations';
--Relic Zone Configurations: 6 per zone, respawn at 3 hours (+/- 1hr - server-set random range)
INSERT INTO dbo.reliczoneconfig 
	([zoneid], [maxspawn], [respawnrate]) 
SELECT 
     zones.id, 6, 10800
FROM 
     dbo.zones
WHERE 
     zones.active=1 and zones.enabled=1

PRINT N'Explicitly set some zones to "off" w/ maxspawn=0';
--Set some zones to have no natural spawning relics (will disable RelicManagers on these zones)
UPDATE dbo.reliczoneconfig SET
	maxspawn = 0
WHERE zoneid in (16, 45, 50, 51);

--Any zone omitted or with a maxspawn<=0 will NOT have a RelicManager assigned on server boot (this is a good thing)

PRINT N'Create the initial set of Relic-types and their associated EP reward values';
--Create different relic types
INSERT INTO [dbo].[relictypes]
           ([name],[raceid],[level],[ep])
     VALUES
           ('relic_level1_neutral_alpha1',0, 1, 5),
		   ('relic_level2_neutral_alpha1',0, 2, 10),
		   ('relic_level3_neutral_alpha1',0, 3, 15),
		   ('relic_level1_neutral_alpha2',0, 1, 15),
		   ('relic_level2_neutral_alpha2',0, 2, 20),
		   ('relic_level3_neutral_alpha2',0, 3, 25),
		   ('relic_level1_neutral_beta1',0, 1, 25),
		   ('relic_level2_neutral_beta1',0, 2, 35),
		   ('relic_level3_neutral_beta1',0, 3, 45),
		   ('relic_level1_neutral_beta2',0, 1, 45),
		   ('relic_level2_neutral_beta2',0, 2, 55),
		   ('relic_level3_neutral_beta2',0, 3, 65),
           ('relic_level1_indy_alpha1',4, 1, 5),
		   ('relic_level2_indy_alpha1',4, 2, 10),
		   ('relic_level3_indy_alpha1',4, 3, 15),
		   ('relic_level1_indy_alpha2',4, 1, 15),
		   ('relic_level2_indy_alpha2',4, 2, 20),
		   ('relic_level3_indy_alpha2',4, 3, 25),
		   ('relic_level1_indy_beta1',4, 1, 25),
		   ('relic_level2_indy_beta1',4, 2, 35),
		   ('relic_level3_indy_beta1',4, 3, 45),
		   ('relic_level1_indy_beta2',4, 1, 45),
		   ('relic_level2_indy_beta2',4, 2, 55),
		   ('relic_level3_indy_beta2',4, 3, 65),
		   ('relic_level1_numiqol_alpha1',2, 1, 5),
		   ('relic_level2_numiqol_alpha1',2, 2, 10),
		   ('relic_level3_numiqol_alpha1',2, 3, 15),
		   ('relic_level1_numiqol_alpha2',2, 1, 15),
		   ('relic_level2_numiqol_alpha2',2, 2, 20),
		   ('relic_level3_numiqol_alpha2',2, 3, 25),
		   ('relic_level1_numiqol_beta1',2, 1, 25),
		   ('relic_level2_numiqol_beta1',2, 2, 35),
		   ('relic_level3_numiqol_beta1',2, 3, 45),
		   ('relic_level1_numiqol_beta2',2, 1, 45),
		   ('relic_level2_numiqol_beta2',2, 2, 55),
		   ('relic_level3_numiqol_beta2',2, 3, 65),
           ('relic_level1_thelodica_alpha1',3, 1, 5),
		   ('relic_level2_thelodica_alpha1',3, 2, 10),
		   ('relic_level3_thelodica_alpha1',3, 3, 15),
		   ('relic_level1_thelodica_alpha2',3, 1, 15),
		   ('relic_level2_thelodica_alpha2',3, 2, 20),
		   ('relic_level3_thelodica_alpha2',3, 3, 25),
		   ('relic_level1_thelodica_beta1',3, 1, 25),
		   ('relic_level2_thelodica_beta1',3, 2, 35),
		   ('relic_level3_thelodica_beta1',3, 3, 45),
		   ('relic_level1_thelodica_beta2',3, 1, 45),
		   ('relic_level2_thelodica_beta2',3, 2, 55),
		   ('relic_level3_thelodica_beta2',3, 3, 65),
           ('relic_level1_pelistal_alpha1',1, 1, 5),
		   ('relic_level2_pelistal_alpha1',1, 2, 10),
		   ('relic_level3_pelistal_alpha1',1, 3, 15),
		   ('relic_level1_pelistal_alpha2',1, 1, 15),
		   ('relic_level2_pelistal_alpha2',1, 2, 20),
		   ('relic_level3_pelistal_alpha2',1, 3, 25),
		   ('relic_level1_pelistal_beta1',1, 1, 25),
		   ('relic_level2_pelistal_beta1',1, 2, 35),
		   ('relic_level3_pelistal_beta1',1, 3, 45),
		   ('relic_level1_pelistal_beta2',1, 1, 45),
		   ('relic_level2_pelistal_beta2',1, 2, 55),
		   ('relic_level3_pelistal_beta2',1, 3, 65);


DECLARE @commonPlasma int;
DECLARE @numiqolPlasma int;
DECLARE @thelodicaPlasma int;
DECLARE @pelistalPlasma int;

DECLARE @commonKernel int;
DECLARE @hitechKernel int;
DECLARE @industrialKernel int;
DECLARE @numiqolKernel int;
DECLARE @thelodicaKernel int;
DECLARE @pelistalKernel int;


SET @commonPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_common_reactor_plasma');
SET @numiqolPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_nuimqol_reactor_plasma');
SET @thelodicaPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_thelodica_reactor_plasma');
SET @pelistalPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_pelistal_reactor_plasma');

SET @commonKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_common');
SET @hitechKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_hitech');
SET @industrialKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_industrial');
SET @numiqolKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_nuimqol');
SET @thelodicaKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_thelodica');
SET @pelistalKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_pelistal');

DECLARE @commonBasicFrag int;
DECLARE @commonAdvFrag int;
DECLARE @commonExpFrag int;

DECLARE @nuimqolBasicFrag int;
DECLARE @nuimqolAdvFrag int;
DECLARE @nuimqolExpFrag int;

DECLARE @pelistalBasicFrag int;
DECLARE @pelistalAdvFrag int;
DECLARE @pelistalExpFrag int;

DECLARE @thelodicaBasicFrag int;
DECLARE @thelodicaAdvFrag int;
DECLARE @thelodicaExpFrag int;


SET @commonBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_common_basic');
SET @commonAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_common_advanced');
SET @commonExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_common_expert');

SET @nuimqolBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_nuimqol_basic');
SET @nuimqolAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_nuimqol_advanced');
SET @nuimqolExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_nuimqol_expert');

SET @pelistalBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_pelistal_basic');
SET @pelistalAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_pelistal_advanced');
SET @pelistalExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_pelistal_expert');

SET @thelodicaBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_thelodica_basic');
SET @thelodicaAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_thelodica_advanced');
SET @thelodicaExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_thelodica_expert');




PRINT N'Create a reasonable initial set of loots for each Relic type'; -- To be supported with future DB tool development
--Insert loots for each type
INSERT INTO [dbo].[relicloot]
           ([definition],[minquantity],[maxquantity],[chance],[relictypeid],[packed])
VALUES
			--Neutral types
			--Kernel - common 75%
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
           (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonKernel,1519,1856,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonKernel,3038,3713,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonKernel,2194,2681,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonKernel,4388,5363,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   --Kernel - hitech 25%
           (@hitechKernel,150,183,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
           (@hitechKernel,225,275,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@hitechKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@hitechKernel,225,275,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@hitechKernel,338,413,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@hitechKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@hitechKernel,338,413,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@hitechKernel,506,619,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@hitechKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@hitechKernel,488,596,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@hitechKernel,731,894,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@hitechKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   --Plasma - common
           (@commonPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
           (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   	-- Frags Common
           (@commonBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
		   (@commonAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
		   (@commonExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),

           (@commonBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),

		   (@commonBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),

		   (@commonBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),

		   (@commonBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),

		   (@commonBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),

		   (@commonBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),

		   (@commonBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),

		   (@commonBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),

		   (@commonBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),

		   (@commonBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),

		   (@commonBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   (@commonAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   (@commonExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   

		   	--Indy types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   --Kernel - Indy 50%
           (@industrialKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
           (@industrialKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@industrialKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@industrialKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@industrialKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@industrialKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@industrialKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@industrialKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@industrialKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@industrialKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@industrialKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@industrialKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   --Plasma - common
           (@commonPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
           (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   	-- Frags Common
           (@commonBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
		   (@commonAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
		   (@commonExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),

           (@commonBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),

		   (@commonBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),

		   (@commonBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),

		   (@commonBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),

		   (@commonBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),

		   (@commonBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),

		   (@commonBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),

		   (@commonBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),

		   (@commonBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),

		   (@commonBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),

		   (@commonBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   (@commonAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   (@commonExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),

			--Numiqol types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   --Kernel - Numiqol 50%
           (@numiqolKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
           (@numiqolKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@numiqolKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@numiqolKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@numiqolKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@numiqolKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@numiqolKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@numiqolKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@numiqolKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@numiqolKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@numiqolKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@numiqolKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   --Plasma - numiqol
           (@numiqolPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
           (@numiqolPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@numiqolPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@numiqolPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@numiqolPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@numiqolPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@numiqolPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@numiqolPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@numiqolPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@numiqolPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@numiqolPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@numiqolPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   		   	-- Frags Common
           (@nuimqolBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
		   (@nuimqolAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
		   (@nuimqolExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),

           (@nuimqolBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@nuimqolAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@nuimqolExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),

		   (@nuimqolBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@nuimqolAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@nuimqolExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),

		   (@nuimqolBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@nuimqolAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@nuimqolExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),

		   (@nuimqolBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@nuimqolAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@nuimqolExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),

		   (@nuimqolBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@nuimqolAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@nuimqolExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),

		   (@nuimqolBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@nuimqolAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@nuimqolExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),

		   (@nuimqolBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@nuimqolAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@nuimqolExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),

		   (@nuimqolBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@nuimqolAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@nuimqolExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),

		   (@nuimqolBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@nuimqolAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@nuimqolExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),

		   (@nuimqolBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@nuimqolAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@nuimqolExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),

		   (@nuimqolBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   (@nuimqolAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   (@nuimqolExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),

			--Thelodica types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   --Kernel - thelodica 50%
           (@thelodicaKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
           (@thelodicaKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   --Plasma - thelodica
           (@thelodicaPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
           (@thelodicaPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   		   	-- Frags Common
           (@thelodicaBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
		   (@thelodicaAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
		   (@thelodicaExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),

           (@thelodicaBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),

		   (@thelodicaBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),

		   (@thelodicaBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),

		   (@thelodicaBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),

		   (@thelodicaBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),

		   (@thelodicaBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),

		   (@thelodicaBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),

		   (@thelodicaBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),

		   (@thelodicaBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),

		   (@thelodicaBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),

		   (@thelodicaBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   (@thelodicaAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   (@thelodicaExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),

			--Pelistal types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   --Kernel - pelistal 50%
           (@pelistalKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
           (@pelistalKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   --Plasma - pelistal
           (@pelistalPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
           (@pelistalPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   	-- Frags pelistal
           (@pelistalBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
		   (@pelistalAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
		   (@pelistalExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),

           (@pelistalBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),

		   (@pelistalBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),

		   (@pelistalBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),

		   (@pelistalBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),

		   (@pelistalBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),

		   (@pelistalBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),

		   (@pelistalBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),

		   (@pelistalBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),

		   (@pelistalBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),

		   (@pelistalBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),

		   (@pelistalBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   (@pelistalAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   (@pelistalExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0);
GO




DECLARE @newVirginia int;
DECLARE @hersh int;
DECLARE @domhalarn int;
DECLARE @hokk int;
DECLARE @hoop int;
DECLARE @kent int;
DECLARE @alsbale int;
DECLARE @nova int;

SET @newVirginia = (SELECT TOP 1 id FROM zones WHERE note='new virginia');
SET @hersh = (SELECT TOP 1 id FROM zones WHERE note='hershfield');
SET @domhalarn = (SELECT TOP 1 id FROM zones WHERE note='domhalarn');
SET @hokk = (SELECT TOP 1 id FROM zones WHERE note='hokkogaros');
SET @hoop = (SELECT TOP 1 id FROM zones WHERE note='norhoop');
SET @kent = (SELECT TOP 1 id FROM zones WHERE note='kentagura');
SET @alsbale = (SELECT TOP 1 id FROM zones WHERE note='alsbale');
SET @nova = (SELECT TOP 1 id FROM zones WHERE note='novastrov');

PRINT N'Assign spawnrates for each type to each zone';
INSERT INTO [dbo].[relicspawninfo]
           ([relictypeid],[zoneid],[rate],[x],[y])
VALUES
			--NV alpha1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),@newVirginia,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),@newVirginia,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),@newVirginia,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),@newVirginia,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),@newVirginia,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),@newVirginia,10,NULL,NULL),
		   --hersh A2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),@hersh,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),@hersh,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),@hersh,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),@hersh,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),@hersh,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),@hersh,10,NULL,NULL),
		   --Domharlarn - numiqol B1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),@domhalarn,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),@domhalarn,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),@domhalarn,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),@domhalarn,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),@domhalarn,120,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),@domhalarn,80,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),@domhalarn,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),@domhalarn,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),@domhalarn,10,NULL,NULL),
		   --Hokkogaros - thelodica B1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),@hokk,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),@hokk,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),@hokk,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),@hokk,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),@hokk,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),@hokk,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),@hokk,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),@hokk,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),@hokk,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),@hokk,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),@hokk,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),@hokk,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),@hokk,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),@hokk,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),@hokk,10,NULL,NULL),
		   --Norhoop - pelistal B1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),@hoop,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),@hoop,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),@hoop,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),@hoop,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),@hoop,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),@hoop,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),@hoop,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),@hoop,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),@hoop,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),@hoop,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),@hoop,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),@hoop,40,NULL,NULL),

		   --Novastrov - numiqol B2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),@nova,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),@nova,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),@nova,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),@nova,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),@nova,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),@nova,120,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),@nova,80,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),@nova,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),@nova,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),@nova,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),@nova,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),@nova,10,NULL,NULL),
		   --Kentagura - thelodica B2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),@kent,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),@kent,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),@kent,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),@kent,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),@kent,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),@kent,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),@kent,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),@kent,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),@kent,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),@kent,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),@kent,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),@kent,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),@kent,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),@kent,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),@kent,10,NULL,NULL),
		   --Alsbale - pelistal B2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),@alsbale,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),@alsbale,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),@alsbale,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),@alsbale,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),@alsbale,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),@alsbale,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),@alsbale,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),@alsbale,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),@alsbale,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),@alsbale,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),@alsbale,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),@alsbale,40,NULL,NULL);

GO
--Also note where a zone does not have any relictypes to select from, that zone will also have a null RelicManager to safely prevent issues server-side



--Let's see what happened!
SELECT * from reliczoneconfig;
SELECT * from relicspawninfo;
SELECT * from relictypes;
SELECT * from relicloot;
--wow cool

PRINT N'DONE! Init-ing relic tables';
