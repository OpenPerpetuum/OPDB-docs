USE [perpetuumsa]
GO
--------------------------------
--Fix Boost subscription check procedure utc->local
--Date: 2019/05/19
--REVISION: 2019/06/30 - bug fix on not checking accountID!
--------------------------------

IF OBJECT_ID('opp.getExtensionSubscription', 'P') IS NOT NULL
	DROP PROCEDURE [opp].[getExtensionSubscription];
GO

CREATE procedure [opp].[getExtensionSubscription]
	@accountID int
as

select top 1
	starttime,
	endtime,
	multiplierBonus
from dbo.extensionsubscription
where startTime < getdate() and endtime > getdate() and @accountID=accountid
order by endtime desc;

GO