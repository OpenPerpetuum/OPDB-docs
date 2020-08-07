USE [perpetuumsa]
GO
--------------------------------------------------------------------------
-- NPC PBS DEFINITIONS
-- Inserts entitydefaults for: robot components and npc defs of npc-pbs
-- Insert aggregatevalues for stats and npc modifier/bonuses
-- Insert robottemplates and relations
-- Loot TODO @ville
-- Date: 2020/08/07
--------------------------------------------------------------------------

DECLARE @compDesc VARCHAR(MAX);
DECLARE @npcDesc VARCHAR(MAX);

SET @compDesc = 'def_npcpbs_component_desc';
SET @npcDesc = 'def_npc_pbs_desc';

DROP TABLE IF EXISTS #ENTITYDEFS;
CREATE TABLE #ENTITYDEFS
(
	def INT,
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	genxyOptStr varchar(max),
	description varchar(max),
);
INSERT INTO #ENTITYDEFS (def, defName, attrFlags, catFlags, cargoVolume, massOfModule, genxyOptStr, description) VALUES
--Robot component definitions
(5883,'def_npcpbs_turret_head', 1024, 336, 2, 1000, '#height=f0.10  #slotFlags=48,8,8,8,8,8,8,8', @compDesc),
(5884,'def_npcpbs_turret_chassis', 1024, 592, 2, 1000, '#slotFlags=4693,693  #height=f2.50  #decay=n500', @compDesc),
(5885,'def_npcpbs_turret_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5886,'def_npcpbs_reactor_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5887,'def_npcpbs_e_transmitter_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5888,'def_npcpbs_e_transfer_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5889,'def_npcpbs_e_battery_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5890,'def_npcpbs_facility_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5891,'def_npcpbs_facility_upgrade_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5892,'def_npcpbs_mining_tower_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5893,'def_npcpbs_repair_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5894,'def_npcpbs_eff_booster_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5895,'def_npcpbs_eff_emitter_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5896,'def_npcpbs_control_tower_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5897,'def_npcpbs_base_small_leg', 1024, 848, 2, 1000, '#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5898,'def_npcpbs_base_medium_leg', 1024, 848, 2, 1000,'#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5899,'def_npcpbs_base_large_leg', 1024, 848, 2, 1000, '#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5900,'def_npcpbs_invis_head', 1024, 336, 2, 1000, '#height=f0.10  #slotFlags=48,8,8,8,8,8,8,8', @compDesc),
(5901,'def_npcpbs_invis_chassis', 1024, 592, 2, 1000,  '#height=f1.00', @compDesc),
--NPC defs
(5902,'def_npc_pbs_turret_laser_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5903,'def_npc_pbs_turret_em_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5904,'def_npc_pbs_turret_missile_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5905,'def_npc_pbs_turret_ew_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5906,'def_npc_pbs_reactor_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5907,'def_npc_pbs_e_emitter_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5908,'def_npc_pbs_e_transfer_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5909,'def_npc_pbs_e_battery_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5910,'def_npc_pbs_facility_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5911,'def_npc_pbs_facility_upgrade_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5912,'def_npc_pbs_miner_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5913,'def_npc_pbs_energy_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5914,'def_npc_pbs_repair_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5915,'def_npc_pbs_eff_booster_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5916,'def_npc_pbs_eff_emitter_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5917,'def_npc_pbs_control_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5918,'def_npc_pbs_base_small_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5919,'def_npc_pbs_base_medium_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5920,'def_npc_pbs_base_large_rank1', 1024, 911, 0, 0, NULL, @npcDesc);


DROP TABLE IF EXISTS #TEMPLATES;
CREATE TABLE #TEMPLATES
(
	tempName varchar(100),
	botName varchar(100),
	headName varchar(100),
	chassisName varchar(100),
	legName varchar(100),
	inventoryName varchar(100),
	loadOut VARCHAR(MAX)
);
INSERT INTO #TEMPLATES (tempName, botName, headName, chassisName, legName, inventoryName, loadOut) VALUES
('def_npc_pbs_turret_laser_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i12ff|slot=i1|ammoDefinition=i1439|ammoQuantity=i19]|m1=[|definition=i12ff|slot=i2|ammoDefinition=i1439|ammoQuantity=i19]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_em_temlate', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i1301|slot=i1|ammoDefinition=i1438|ammoQuantity=i14]|m1=[|definition=i1301|slot=i2|ammoDefinition=i1438|ammoQuantity=i14]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_missile_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i1300|slot=i1|ammoDefinition=i143a|ammoQuantity=i14]|m1=[|definition=i1300|slot=i2|ammoDefinition=i143a|ammoQuantity=i14]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_ew_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i1370|slot=i1]|m1=[|definition=i1371|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i1371|slot=i4]|m4=[|definition=i1372|slot=i5]]#chassisModules=[|m0=[|definition=i136f|slot=i1]|m1=[|definition=i136f|slot=i2]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_reactor_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_reactor_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_emitter_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_transmitter_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_transfer_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_transfer_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_battery_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_battery_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_facility_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_facility_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_facility_upgrade_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_facility_upgrade_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_miner_tower_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_mining_tower_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_repair_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_repair_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_eff_booster_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_eff_booster_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_eff_emitter_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_eff_emitter_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_control_tower_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_control_tower_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_small_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_small_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_medium_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_medium_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_large_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_large_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]');

DROP TABLE IF EXISTS #TEMPRELATIONS;
CREATE TABLE #TEMPRELATIONS
(
	defName varchar(100),
	tempName varchar(100),
	epKill INT,
);
INSERT INTO #TEMPRELATIONS (defName, tempName, epKill) VALUES
('def_npc_pbs_turret_laser_rank1', 'def_npc_pbs_turret_laser_template', 10),
('def_npc_pbs_turret_em_rank1', 'def_npc_pbs_turret_em_temlate', 10),
('def_npc_pbs_turret_missile_rank1', 'def_npc_pbs_turret_missile_template', 10),
('def_npc_pbs_turret_ew_rank1', 'def_npc_pbs_turret_ew_template', 10),
('def_npc_pbs_reactor_rank1', 'def_npc_pbs_reactor_template', 20),
('def_npc_pbs_e_emitter_rank1', 'def_npc_pbs_e_emitter_template', 10),
('def_npc_pbs_e_transfer_rank1', 'def_npc_pbs_e_transfer_template', 10),
('def_npc_pbs_e_battery_rank1', 'def_npc_pbs_e_battery_template', 10),
('def_npc_pbs_facility_rank1', 'def_npc_pbs_facility_template', 10),
('def_npc_pbs_facility_upgrade_rank1', 'def_npc_pbs_facility_upgrade_template', 10),
('def_npc_pbs_miner_tower_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_energy_tower_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_control_tower_rank1', 'def_npc_pbs_control_tower_template', 20),
('def_npc_pbs_base_small_rank1', 'def_npc_pbs_base_small_template', 50),
('def_npc_pbs_base_medium_rank1', 'def_npc_pbs_base_medium_template', 100),
('def_npc_pbs_base_large_rank1', 'def_npc_pbs_base_large_template', 150);



DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);

INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npcpbs_turret_head', 'cpu_max', 5000),
('def_npcpbs_turret_head', 'locked_targets_max', 100),
('def_npcpbs_turret_head', 'locking_range', 100),
('def_npcpbs_turret_head', 'locking_time', 5000),
('def_npcpbs_turret_head', 'sensor_strength', 200),
('def_npcpbs_turret_head', 'detection_strength', 125),
('def_npcpbs_turret_head', 'stealth_strength', 100),
('def_npcpbs_turret_head', 'blob_level_low', 300),
('def_npcpbs_turret_head', 'blob_level_high', 500),
('def_npcpbs_turret_chassis', 'ammo_reload_time', 10000),
('def_npcpbs_turret_chassis', 'armor_max', 75000),
('def_npcpbs_turret_chassis', 'core_max', 30000),
('def_npcpbs_turret_chassis', 'core_recharge_time', 300),
('def_npcpbs_turret_chassis', 'powergrid_max', 5000),
('def_npcpbs_turret_chassis', 'resist_chemical', 150),
('def_npcpbs_turret_chassis', 'resist_explosive', 150),
('def_npcpbs_turret_chassis', 'resist_kinetic', 150),
('def_npcpbs_turret_chassis', 'resist_thermal', 150),
('def_npcpbs_turret_chassis', 'signature_radius', 30),
('def_npcpbs_turret_chassis', 'missile_miss', 1),
('def_npcpbs_turret_chassis', 'reactor_radiation', 1),
('def_npcpbs_turret_leg', 'speed_max', 0),
('def_npcpbs_turret_leg', 'slope', 6),
--
('def_npcpbs_reactor_leg', 'armor_max', 100000),
('def_npcpbs_reactor_leg', 'resist_chemical', 150),
('def_npcpbs_reactor_leg', 'resist_explosive', 150),
('def_npcpbs_reactor_leg', 'resist_kinetic', 150),
('def_npcpbs_reactor_leg', 'resist_thermal', 150),
('def_npcpbs_reactor_leg', 'signature_radius', 30),
--
('def_npcpbs_e_transmitter_leg', 'armor_max', 50000),
('def_npcpbs_e_transmitter_leg', 'resist_chemical', 150),
('def_npcpbs_e_transmitter_leg', 'resist_explosive', 150),
('def_npcpbs_e_transmitter_leg', 'resist_kinetic', 150),
('def_npcpbs_e_transmitter_leg', 'resist_thermal', 150),
('def_npcpbs_e_transmitter_leg', 'signature_radius', 20),
--
('def_npcpbs_e_transfer_leg', 'armor_max', 50000),
('def_npcpbs_e_transfer_leg', 'resist_chemical', 150),
('def_npcpbs_e_transfer_leg', 'resist_explosive', 150),
('def_npcpbs_e_transfer_leg', 'resist_kinetic', 150),
('def_npcpbs_e_transfer_leg', 'resist_thermal', 150),
('def_npcpbs_e_transfer_leg', 'signature_radius', 20),
--
('def_npcpbs_e_battery_leg', 'armor_max', 75000),
('def_npcpbs_e_battery_leg', 'resist_chemical', 150),
('def_npcpbs_e_battery_leg', 'resist_explosive', 150),
('def_npcpbs_e_battery_leg', 'resist_kinetic', 150),
('def_npcpbs_e_battery_leg', 'resist_thermal', 150),
('def_npcpbs_e_battery_leg', 'signature_radius', 25),
--
('def_npcpbs_facility_leg', 'armor_max', 10000),
('def_npcpbs_facility_leg', 'resist_chemical', 150),
('def_npcpbs_facility_leg', 'resist_explosive', 150),
('def_npcpbs_facility_leg', 'resist_kinetic', 150),
('def_npcpbs_facility_leg', 'resist_thermal', 150),
('def_npcpbs_facility_leg', 'signature_radius', 35),
--
('def_npcpbs_facility_upgrade_leg', 'armor_max', 25000),
('def_npcpbs_facility_upgrade_leg', 'resist_chemical', 150),
('def_npcpbs_facility_upgrade_leg', 'resist_explosive', 150),
('def_npcpbs_facility_upgrade_leg', 'resist_kinetic', 150),
('def_npcpbs_facility_upgrade_leg', 'resist_thermal', 150),
('def_npcpbs_facility_upgrade_leg', 'signature_radius', 20),
--
('def_npcpbs_mining_tower_leg', 'armor_max', 75000),
('def_npcpbs_mining_tower_leg', 'resist_chemical', 150),
('def_npcpbs_mining_tower_leg', 'resist_explosive', 150),
('def_npcpbs_mining_tower_leg', 'resist_kinetic', 150),
('def_npcpbs_mining_tower_leg', 'resist_thermal', 150),
('def_npcpbs_mining_tower_leg', 'signature_radius', 30),
--
('def_npcpbs_repair_leg', 'armor_max', 50000),
('def_npcpbs_repair_leg', 'resist_chemical', 150),
('def_npcpbs_repair_leg', 'resist_explosive', 150),
('def_npcpbs_repair_leg', 'resist_kinetic', 150),
('def_npcpbs_repair_leg', 'resist_thermal', 150),
('def_npcpbs_repair_leg', 'signature_radius', 20),
--
('def_npcpbs_eff_booster_leg', 'armor_max', 25000),
('def_npcpbs_eff_booster_leg', 'resist_chemical', 150),
('def_npcpbs_eff_booster_leg', 'resist_explosive', 150),
('def_npcpbs_eff_booster_leg', 'resist_kinetic', 150),
('def_npcpbs_eff_booster_leg', 'resist_thermal', 150),
('def_npcpbs_eff_booster_leg', 'signature_radius', 20),
--
('def_npcpbs_eff_emitter_leg', 'armor_max', 25000),
('def_npcpbs_eff_emitter_leg', 'resist_chemical', 150),
('def_npcpbs_eff_emitter_leg', 'resist_explosive', 150),
('def_npcpbs_eff_emitter_leg', 'resist_kinetic', 150),
('def_npcpbs_eff_emitter_leg', 'resist_thermal', 150),
('def_npcpbs_eff_emitter_leg', 'signature_radius', 20),
--
('def_npcpbs_control_tower_leg', 'armor_max', 50000),
('def_npcpbs_control_tower_leg', 'resist_chemical', 150),
('def_npcpbs_control_tower_leg', 'resist_explosive', 150),
('def_npcpbs_control_tower_leg', 'resist_kinetic', 150),
('def_npcpbs_control_tower_leg', 'resist_thermal', 150),
('def_npcpbs_control_tower_leg', 'signature_radius', 30),
--
('def_npcpbs_base_small_leg', 'armor_max', 100000),
('def_npcpbs_base_small_leg', 'resist_chemical', 150),
('def_npcpbs_base_small_leg', 'resist_explosive', 150),
('def_npcpbs_base_small_leg', 'resist_kinetic', 150),
('def_npcpbs_base_small_leg', 'resist_thermal', 150),
('def_npcpbs_base_small_leg', 'signature_radius', 30),
--
('def_npcpbs_base_medium_leg', 'armor_max', 125000),
('def_npcpbs_base_medium_leg', 'resist_chemical', 150),
('def_npcpbs_base_medium_leg', 'resist_explosive', 150),
('def_npcpbs_base_medium_leg', 'resist_kinetic', 150),
('def_npcpbs_base_medium_leg', 'resist_thermal', 150),
('def_npcpbs_base_medium_leg', 'signature_radius', 35),
--
('def_npcpbs_base_large_leg', 'armor_max', 150000),
('def_npcpbs_base_large_leg', 'resist_chemical', 150),
('def_npcpbs_base_large_leg', 'resist_explosive', 150),
('def_npcpbs_base_large_leg', 'resist_kinetic', 150),
('def_npcpbs_base_large_leg', 'resist_thermal', 150),
('def_npcpbs_base_large_leg', 'signature_radius', 45),

--common to all non-turret npcs
('def_npcpbs_invis_head', 'cpu_max', 1000),
('def_npcpbs_invis_head', 'locked_targets_max', 0),
('def_npcpbs_invis_head', 'locking_range', 1),
('def_npcpbs_invis_head', 'locking_time', 10000),
('def_npcpbs_invis_head', 'sensor_strength', 200),
('def_npcpbs_invis_head', 'detection_strength', 125),
('def_npcpbs_invis_head', 'stealth_strength', 100),
('def_npcpbs_invis_head', 'blob_level_low', 300),
('def_npcpbs_invis_head', 'blob_level_high', 500),
('def_npcpbs_invis_head', 'ammo_reload_time', 10000),
('def_npcpbs_invis_head', 'core_max', 3000),
('def_npcpbs_invis_head', 'core_recharge_time', 1800),
('def_npcpbs_invis_head', 'powergrid_max', 1000),
('def_npcpbs_invis_head', 'missile_miss', 1),
('def_npcpbs_invis_head', 'reactor_radiation', 1),
('def_npcpbs_invis_head', 'speed_max', 0),
('def_npcpbs_invis_head', 'slope', 6),
--
('def_npc_pbs_turret_laser_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_laser_rank1', 'damage_modifier', 1.05),
('def_npc_pbs_turret_laser_rank1', 'falloff_modifier', 1.05),
('def_npc_pbs_turret_laser_rank1', 'locking_range_modifier', 0.95),
('def_npc_pbs_turret_laser_rank1', 'locking_time_modifier', 1.1),
('def_npc_pbs_turret_laser_rank1', 'missile_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_laser_rank1', 'optimal_range_modifier', 1.05),
('def_npc_pbs_turret_laser_rank1', 'resist_chemical', 75),
('def_npc_pbs_turret_laser_rank1', 'resist_explosive', 0),
('def_npc_pbs_turret_laser_rank1', 'resist_kinetic', 75),
('def_npc_pbs_turret_laser_rank1', 'resist_thermal', 75),
('def_npc_pbs_turret_laser_rank1', 'turret_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_laser_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_em_rank1', 'damage_modifier', 1.05),
('def_npc_pbs_turret_em_rank1', 'falloff_modifier', 1.05),
('def_npc_pbs_turret_em_rank1', 'locking_range_modifier', 0.95),
('def_npc_pbs_turret_em_rank1', 'locking_time_modifier', 1.1),
('def_npc_pbs_turret_em_rank1', 'missile_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_em_rank1', 'optimal_range_modifier', 1.05),
('def_npc_pbs_turret_em_rank1', 'resist_chemical', 75),
('def_npc_pbs_turret_em_rank1', 'resist_explosive', 75),
('def_npc_pbs_turret_em_rank1', 'resist_kinetic', 75),
('def_npc_pbs_turret_em_rank1', 'resist_thermal', 0),
('def_npc_pbs_turret_em_rank1', 'turret_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_em_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_missile_rank1', 'damage_modifier', 1.05),
('def_npc_pbs_turret_missile_rank1', 'falloff_modifier', 1.05),
('def_npc_pbs_turret_missile_rank1', 'locking_range_modifier', 0.95),
('def_npc_pbs_turret_missile_rank1', 'locking_time_modifier', 1.1),
('def_npc_pbs_turret_missile_rank1', 'missile_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_missile_rank1', 'optimal_range_modifier', 1.05),
('def_npc_pbs_turret_missile_rank1', 'resist_chemical', 75),
('def_npc_pbs_turret_missile_rank1', 'resist_explosive', 75),
('def_npc_pbs_turret_missile_rank1', 'resist_kinetic', 0),
('def_npc_pbs_turret_missile_rank1', 'resist_thermal', 75),
('def_npc_pbs_turret_missile_rank1', 'turret_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_missile_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_ew_rank1', 'damage_modifier', 1.05),
('def_npc_pbs_turret_ew_rank1', 'falloff_modifier', 1.05),
('def_npc_pbs_turret_ew_rank1', 'locking_range_modifier', 0.95),
('def_npc_pbs_turret_ew_rank1', 'locking_time_modifier', 1.1),
('def_npc_pbs_turret_ew_rank1', 'missile_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_ew_rank1', 'optimal_range_modifier', 1.05),
('def_npc_pbs_turret_ew_rank1', 'resist_chemical', 0),
('def_npc_pbs_turret_ew_rank1', 'resist_explosive', 75),
('def_npc_pbs_turret_ew_rank1', 'resist_kinetic', 75),
('def_npc_pbs_turret_ew_rank1', 'resist_thermal', 75),
('def_npc_pbs_turret_ew_rank1', 'turret_cycle_time_modifier', 1.25),
('def_npc_pbs_turret_ew_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_reactor_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_reactor_rank1', 'resist_chemical', 75),
('def_npc_pbs_reactor_rank1', 'resist_explosive', 75),
('def_npc_pbs_reactor_rank1', 'resist_kinetic', 75),
('def_npc_pbs_reactor_rank1', 'resist_thermal', 75),
('def_npc_pbs_reactor_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_emitter_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_emitter_rank1', 'resist_chemical', 75),
('def_npc_pbs_e_emitter_rank1', 'resist_explosive', 75),
('def_npc_pbs_e_emitter_rank1', 'resist_kinetic', 75),
('def_npc_pbs_e_emitter_rank1', 'resist_thermal', 75),
('def_npc_pbs_e_emitter_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_transfer_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_transfer_rank1', 'resist_chemical', 75),
('def_npc_pbs_e_transfer_rank1', 'resist_explosive', 75),
('def_npc_pbs_e_transfer_rank1', 'resist_kinetic', 75),
('def_npc_pbs_e_transfer_rank1', 'resist_thermal', 75),
('def_npc_pbs_e_transfer_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_battery_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_battery_rank1', 'resist_chemical', 75),
('def_npc_pbs_e_battery_rank1', 'resist_explosive', 75),
('def_npc_pbs_e_battery_rank1', 'resist_kinetic', 75),
('def_npc_pbs_e_battery_rank1', 'resist_thermal', 75),
('def_npc_pbs_e_battery_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_facility_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_facility_rank1', 'resist_chemical', 75),
('def_npc_pbs_facility_rank1', 'resist_explosive', 75),
('def_npc_pbs_facility_rank1', 'resist_kinetic', 75),
('def_npc_pbs_facility_rank1', 'resist_thermal', 75),
('def_npc_pbs_facility_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_facility_upgrade_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_facility_upgrade_rank1', 'resist_chemical', 75),
('def_npc_pbs_facility_upgrade_rank1', 'resist_explosive', 75),
('def_npc_pbs_facility_upgrade_rank1', 'resist_kinetic', 75),
('def_npc_pbs_facility_upgrade_rank1', 'resist_thermal', 75),
('def_npc_pbs_facility_upgrade_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_miner_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_miner_tower_rank1', 'resist_chemical', 75),
('def_npc_pbs_miner_tower_rank1', 'resist_explosive', 75),
('def_npc_pbs_miner_tower_rank1', 'resist_kinetic', 75),
('def_npc_pbs_miner_tower_rank1', 'resist_thermal', 75),
('def_npc_pbs_miner_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_energy_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_energy_tower_rank1', 'resist_chemical', 75),
('def_npc_pbs_energy_tower_rank1', 'resist_explosive', 75),
('def_npc_pbs_energy_tower_rank1', 'resist_kinetic', 75),
('def_npc_pbs_energy_tower_rank1', 'resist_thermal', 75),
('def_npc_pbs_energy_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_repair_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_repair_rank1', 'resist_chemical', 75),
('def_npc_pbs_repair_rank1', 'resist_explosive', 75),
('def_npc_pbs_repair_rank1', 'resist_kinetic', 75),
('def_npc_pbs_repair_rank1', 'resist_thermal', 75),
('def_npc_pbs_repair_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_eff_booster_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_eff_booster_rank1', 'resist_chemical', 75),
('def_npc_pbs_eff_booster_rank1', 'resist_explosive', 75),
('def_npc_pbs_eff_booster_rank1', 'resist_kinetic', 75),
('def_npc_pbs_eff_booster_rank1', 'resist_thermal', 75),
('def_npc_pbs_eff_booster_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_eff_emitter_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_eff_emitter_rank1', 'resist_chemical', 75),
('def_npc_pbs_eff_emitter_rank1', 'resist_explosive', 75),
('def_npc_pbs_eff_emitter_rank1', 'resist_kinetic', 75),
('def_npc_pbs_eff_emitter_rank1', 'resist_thermal', 75),
('def_npc_pbs_eff_emitter_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_control_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_control_tower_rank1', 'resist_chemical', 75),
('def_npc_pbs_control_tower_rank1', 'resist_explosive', 75),
('def_npc_pbs_control_tower_rank1', 'resist_kinetic', 75),
('def_npc_pbs_control_tower_rank1', 'resist_thermal', 75),
('def_npc_pbs_control_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_small_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_small_rank1', 'resist_chemical', 75),
('def_npc_pbs_base_small_rank1', 'resist_explosive', 75),
('def_npc_pbs_base_small_rank1', 'resist_kinetic', 75),
('def_npc_pbs_base_small_rank1', 'resist_thermal', 75),
('def_npc_pbs_base_small_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_medium_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_medium_rank1', 'resist_chemical', 75),
('def_npc_pbs_base_medium_rank1', 'resist_explosive', 75),
('def_npc_pbs_base_medium_rank1', 'resist_kinetic', 75),
('def_npc_pbs_base_medium_rank1', 'resist_thermal', 75),
('def_npc_pbs_base_medium_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_large_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_large_rank1', 'resist_chemical', 75),
('def_npc_pbs_base_large_rank1', 'resist_explosive', 75),
('def_npc_pbs_base_large_rank1', 'resist_kinetic', 75),
('def_npc_pbs_base_large_rank1', 'resist_thermal', 75),
('def_npc_pbs_base_large_rank1', 'received_repaired_modifier', 1.1);


SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for NPC PBS definitions';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #ENTITYDEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=NULL,
		tierlevel=NULL,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, 1, attrFlags, catFlags, genxyOptStr, 'NPC PBS components and bot definitions', 1 ,cargoVolume, massOfModule, 0, 100, description, 0, NULL, NULL);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;


PRINT N'DELETE OLD STATS (0 results if 1st run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #STATS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue
FROM #STATS;


DELETE FROM robottemplaterelation WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TEMPRELATIONS));
DELETE FROM robottemplates WHERE name in (SELECT tempName FROM #TEMPLATES);

INSERT INTO robottemplates (name, description, note)
SELECT t.tempName,
	'#robot=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.botName))+
	'#head=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.headName))+
	'#chassis=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.chassisName))+
	'#leg=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.legName))+
	'#container=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.inventoryName))+
	t.loadOut,
	'NPC PBS TEMPLATE'
 FROM #TEMPLATES as t;


INSERT INTO robottemplaterelation ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.defName),
	(SELECT TOP 1 id FROM robottemplates WHERE name=t.tempName),
	0, 0, NULL, NULL, t.epKill, 'Relate: '+t.defName+ '<->'+t.tempName
FROM #TEMPRELATIONS AS t;


DROP TABLE IF EXISTS #TEMPRELATIONS;
DROP TABLE IF EXISTS #TEMPLATES;
DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEFS;

GO
