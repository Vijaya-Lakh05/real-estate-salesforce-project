public with sharing class LeaseAgreementController {

    @AuraEnabled(cacheable=true)
    public static List<Lease_Agreement__c> getLeaseAgreements() {

        return [
            SELECT Id,
                   Name,
                   Property__r.Name,
                   Tenant__r.Name,
                   Agreed_Monthly_Rent__c,
                   Start_Date__c,
                   End_Date__c
            FROM Lease_Agreement__c
            ORDER BY CreatedDate DESC
        ];
    }
}