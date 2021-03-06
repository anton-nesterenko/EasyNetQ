/****** Object:  StoredProcedure [dbo].[uspGetNextBatchOfMessages]    Script Date: 11/25/2011 16:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspMarkWorkItemForPurge]
 @ID INT = 0, @purgeDate datetime = NULL

AS
/******************************************************************************
**		File: uspMarkWorkItemForPurge.sql
**		Name: uspMarkWorkItemForPurge 
**		Desc: Example table purgeing technique
**
**		Auth: Steve Smith
**		Date: 20111125
**
**      Uses: @ID = record to update
**			  @purgeDate = date to purge record 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		20111125	Steve Smith			Original creation for demonstration
*******************************************************************************/
-- Set default purgeDate to Now
IF @purgeDate is NULL SET @purgeDate=getdate()

-- Performs the UPDATE and OUTPUTs the INSERTED. fields to the calling app
UPDATE WorkItemStatus
SET PurgeDate = @purgeDate
OUTPUT INSERTED.WorkItemID, INSERTED.purgeDate
FROM WorkItemStatus ws
WHERE WorkItemID = @ID
