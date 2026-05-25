public with sharing class LeaseAgreementPdfController {

    
    // GET LEASE FOR PDF
    
    @AuraEnabled(cacheable=true)
    public static Lease_Agreement__c getLeaseAgreement(Id recordId) {

        return [
            SELECT Id,
                   Name,
                   Terms__c,
                   Agreed_Monthly_Rent__c,
                   Start_Date__c,
                   End_Date__c,
                   Property__r.Name,
                   Tenant__r.Name,
                   Tenant__r.Email__c
            FROM Lease_Agreement__c
            WHERE Id = :recordId
            LIMIT 1
        ];
    }

   
    //  EMAIL MANUALLY FROM LWC
    
    @AuraEnabled
    public static String sendLeaseEmail(Id recordId) {

        Lease_Agreement__c lease = [
            SELECT Id,
                   Name,
                   Terms__c,
                   Agreed_Monthly_Rent__c,
                   Start_Date__c,
                   End_Date__c,
                   Tenant__r.Name,
                   Tenant__r.Email__c
            FROM Lease_Agreement__c
            WHERE Id = :recordId
            LIMIT 1
        ];

        
        // VALIDATION 
        
        if (lease.Tenant__r == null || String.isBlank(lease.Tenant__r.Email__c)) {
            throw new AuraHandledException('Tenant email is missing.');
        }

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        email.setToAddresses(new String[] { lease.Tenant__r.Email__c });

        email.setSubject('Lease Agreement - ' + lease.Name);

        String body =
            'Hello ' + lease.Tenant__r.Name + ',\n\n' +
            'Lease Agreement Details:\n\n' +
            'Agreement: ' + lease.Name + '\n' +
            'Monthly Rent: ' + lease.Agreed_Monthly_Rent__c + '\n' +
            'Start Date: ' + lease.Start_Date__c + '\n' +
            'End Date: ' + lease.End_Date__c + '\n\n' +
            'Regards,\nProperty Management Team';

        email.setPlainTextBody(body);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });

        return 'Success';
    }
}