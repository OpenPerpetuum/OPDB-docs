USE [perpetuumsa]
GO

PRINT N'Scarab Production Cost increase';
DECLARE @costModifier float;
SET @costModifier = 1.5;

--Original Scarab production table (mk1/pr)
--componentdefinition/componentamount/definitionname
--169	6250			def_titanium
--178	750				def_plasteosine
--186	1500			def_alligior
--189	3000			def_espitium
--1981	60				def_robotshard_common_advanced
--1982	40				def_robotshard_common_expert
--2910	12500			def_unimetal
--4605	1500			def_axicol


DECLARE @defScarab int;
DECLARE @defScarabProto int;

SET @defScarab = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_scarab_bot');
SET @defScarabProto = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_scarab_bot_pr');


UPDATE components
SET componentamount = componentamount*@costModifier
WHERE definition in (@defScarab, @defScarabProto);

GO


