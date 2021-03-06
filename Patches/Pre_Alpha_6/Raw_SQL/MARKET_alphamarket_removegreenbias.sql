USE [perpetuumsa]
GO
--For some few items, adjust buy and sell prices of orders on markets 
--For all Markets, children of Outposts and Terminals on Zones NV and Hersh

SELECT eid INTO #RELEVANTMARKETS FROM entities 
WHERE entities.definition=(SELECT TOP 1 definition from entitydefaults where definitionname='def_public_market')
AND entities.parent IN (SELECT eid FROM entities WHERE eid IN
(SELECT eid FROM zoneentities WHERE zoneID in (SELECT id FROM zones WHERE note in ('new virginia', 'hershfield'))) 
AND definition IN (SELECT definition FROM entitydefaults WHERE definitionname in ('def_public_docking_base_pelistal', 'def_public_docking_base_pelistal_outpost_pve')));

--The relevant marketeids
SELECT * FROM #RELEVANTMARKETS


DECLARE @def int;
DECLARE @sellprice float;

PRINT N'def_ammo_artifact_scan_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_artifact_scan_b');
SET @sellprice = 1000;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_artifact_scan_c';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_artifact_scan_c');
SET @sellprice = 2000;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_longrange_missile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_longrange_missile_a');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_longrange_missile_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_longrange_missile_b');
SET @sellprice = 113;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_longrange_missile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_longrange_missile_d');
SET @sellprice = 131.2;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_medium_lasercrystal_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_medium_lasercrystal_b');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_medium_projectile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_medium_projectile_a');
SET @sellprice = 85.1;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_medium_projectile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_medium_projectile_d');
SET @sellprice = 91.7;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_mining_epriton';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_epriton');
SET @sellprice = 25;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_mining_silgium';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_silgium');
SET @sellprice = 24;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_mining_stermonit';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_stermonit');
SET @sellprice = 24;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_mining_titan';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_stermonit');
SET @sellprice = 20;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_missile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_a');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_missile_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_b');
SET @sellprice = 113;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_missile_c';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_c');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_missile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_d');
SET @sellprice = 131.2;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_a');
SET @sellprice = 55.8;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_b');
SET @sellprice = 56.5;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_c';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_c');
SET @sellprice = 55.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_d');
SET @sellprice = 65.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_small_lasercrystal_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_small_lasercrystal_b');
SET @sellprice = 55.8;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_small_projectile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_small_projectile_a');
SET @sellprice = 42.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_small_projectile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_small_projectile_d');
SET @sellprice = 45.8;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_castel_bot';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_castel_bot');
SET @sellprice = 584925;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_common_reactor_plasma';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_common_reactor_plasma');
SET @sellprice = 225;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_pelistal_reactor_plasma';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_pelistal_reactor_plasma');
SET @sellprice = 250;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;


PRINT N'def_standard_damage_mod_missile';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_damage_mod_missile');
SET @sellprice = 146850;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_gang_assist_core_management_module';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_gang_assist_core_management_module');
SET @sellprice = 260700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_gang_assist_siege_module';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_gang_assist_siege_module');
SET @sellprice = 248250;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_medium_energy_neutralizer';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_medium_energy_neutralizer');
SET @sellprice = 293700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_medium_shield_generator';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_medium_shield_generator');
SET @sellprice = 521400;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_missile_launcher';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_missile_launcher');
SET @sellprice = 125400;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_rocket_launcher';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_rocket_launcher');
SET @sellprice = 62700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_shield_hardener';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_shield_hardener');
SET @sellprice = 294525;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_small_energy_neutralizer';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_small_energy_neutralizer');
SET @sellprice = 146850;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_small_shield_generator';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_small_shield_generator');
SET @sellprice = 260700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_thermal_kers';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_thermal_kers');
SET @sellprice = 293700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_thrm_armor_hardener';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_thrm_armor_hardener');
SET @sellprice = 161700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_waspish_bot';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_waspish_bot');
SET @sellprice = 1843875;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;


DROP TABLE #RELEVANTMARKETS;
GO