@isTest
private class LeaseAgreementPdfControllerTest {

    @isTest
    static void testGetLeaseAgreementAndSendEmail() {

        // Create Property
        Property__c prop = new Property__c(
            Name = 'Test Property',
            Address__c = 'Test Address',
            City__c = 'Hyderabad',
            State__c = 'Telangana',
            Postal_Code__c = '500001',
            Country__c = 'India',
            Type__c = 'Residential',
            Status__c = 'Available',
            Rent__c = 25000
        );
        insert prop;

        // Create Tenant
        Tenant__c tenant = new Tenant__c(
            Name = 'John Doe',
            Phone__c = '9876543210',
            Email__c = 'john@test.com'
        );
        insert tenant;

        // Create Lease Agreement
        Lease_Agreement__c lease = new Lease_Agreement__c(
            Name = 'Lease Test',
            Property__c = prop.Id,
            Tenant__c = tenant.Id,
            Terms__c = '12 Months',
            Agreed_Monthly_Rent__c = 25000,
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addMonths(12)
        );
        insert lease;

        Test.startTest();

        // Test getLeaseAgreement
        Lease_Agreement__c result =
            LeaseAgreementPdfController.getLeaseAgreement(
                lease.Id
            );

        System.assertEquals(
            'Lease Test',
            result.Name
        );

        // Test sendLeaseEmail
        String response =
            LeaseAgreementPdfController.sendLeaseEmail(
                lease.Id
            );

        System.assertEquals(
            'Success',
            response
        );

        Test.stopTest();
    }
}