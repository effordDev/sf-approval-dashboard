public with sharing class CustomApprovalDashboardHelper {
    
    @AuraEnabled
    public static List<AggregateResult> getProcessInstanceWorkitems() {
        return [
            SELECT COUNT(Id) value, Actor.Name, Actor.Id, MIN(CreatedDate)earliest
            FROM ProcessInstanceWorkitem 
            GROUP BY Actor.Name, Actor.Id
            ORDER BY Actor.Name
            LIMIT 150
        ];
    }

    @AuraEnabled
    public static resultWrapper getProcessInstanceWorkitemsWithSobjects() {
        List<String> users = new List<String>(); 
        Set<String> sobjectList = new Set<String>(); 

        resultWrapper response = new resultWrapper(); 
        response.data = new List<dataWrapper>();

        List<ProcessInstanceWorkitem> results = [
            SELECT Id, Actor.Name, ProcessInstance.TargetObjectId
            FROM ProcessInstanceWorkitem
            ORDER BY Actor.Name, ProcessInstance.TargetObjectId
            LIMIT 150
        ];

        for (ProcessInstanceWorkitem result : results) {

            String userName = result.Actor.Name;

            if (!users.contains(userName)) {
                users.add(userName);
            }

            Id recordId = result.ProcessInstance.TargetObjectId;
            String sobjectName = recordId.getSObjectType().getDescribe().getName();

            sobjectList.add(sobjectName);
        }

        response.userNames = users;

        for (String name : sobjectList) {

            dataWrapper dw = new dataWrapper();
                dw.sobjectName = name;
                dw.count = new List<Integer>();

            for (String u : users) {
                dw.count.add(0);
            }

            response.data.add(dw);
        }

        for (ProcessInstanceWorkitem result : results) {

            String userName = result.Actor.Name;
            Integer userIndex = users.indexOf(userName);

            Id recordId = result.ProcessInstance.TargetObjectId;
            String sobjectName = recordId.getSObjectType().getDescribe().getName();

            for (dataWrapper wrapper : response.data) {
                if (wrapper.sobjectName == sobjectName) {
                    
                    Integer i = 0;
                    for (Integer count : wrapper.count) {
                        
                        if (i == userIndex) {
                            wrapper.count[i]++;
                        }
                        i++;
                    }
                }
            }
        }

        System.debug(response);
        return response;
    }
    
    public class resultWrapper {
        @AuraEnabled
        public List<String> userNames{get;set;}
        
        @AuraEnabled
        public List<dataWrapper> data{get;set;}

        public resultWrapper() {}
    }

    public class dataWrapper {
        @AuraEnabled
        public String sobjectName{get;set;}
        
        @AuraEnabled
        public List<Integer> count{get;set;}

        public dataWrapper() {}
    }
}