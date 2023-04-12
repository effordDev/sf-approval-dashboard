@isTest
public with sharing class CustomApprovalDashboardHelperTest {
    
    @TestSetup
    static void makeData(){
        TestDataFactory.grantsTestDataFactory();
    }

    @isTest
    private static void getProcessInstanceWorkitemsTest() {
        CustomApprovalDashboardHelper.getProcessInstanceWorkitems();
    }
    @isTest
    private static void getProcessInstanceWorkitemsWithSobjectsTest() {
        
        Application__c app = [SELECT Id FROM Application__c LIMIT 1];

        ProcessDefinition approvalProcess = [
            SELECT 
            Id, 
            DeveloperName, 
            Name, 
            State, 
            TableEnumOrId, 
            Type  
        FROM ProcessDefinition
        WHERE State = 'Active' 
            AND TableEnumOrId = 'Application__c'
            LIMIT 1
        ];

        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting request for approval.');
        req.setObjectId(app.id);
        
        // Submit on behalf of a specific submitter
        req.setSubmitterId(UserInfo.getUserId()); 
        
        // Submit the record to specific process and skip the criteria evaluation
        req.setProcessDefinitionNameOrId(approvalProcess.DeveloperName);
        req.setSkipEntryCriteria(true);
        
        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req);

        CustomApprovalDashboardHelper.getProcessInstanceWorkitemsWithSobjects();
    }
}