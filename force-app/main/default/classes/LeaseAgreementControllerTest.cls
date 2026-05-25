@isTest
private class LeaseAgreementControllerTest {

    @isTest
    static void testGetLeaseAgreements() {

        // Property
        Property__c prop = new Property__c(
            Name = 'Test Property',
            Address__c = 'Address',
            City__c = 'Hyderabad',
            State__c = 'TS',
            Postal_Code__c = '500001',
            Country__c = 'India',
            Type__c = 'Residential',
            Status__c = 'Available',
            Rent__c = 25000
        );
        insert prop;

        // Tenant
        Tenant__c tenant = new Tenant__c(
            Name = 'John Doe',
            Email__c = 'john@test.com'
        );
        insert tenant;

        // Lease Agreement
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

        List<Lease_Agreement__c> leases =
            LeaseAgreementController.getLeaseAgreements();

        Test.stopTest();

        System.assertEquals(
            1,
            leases.size()
        );

        System.assertEquals(
            'Lease Test',
            leases[0].Name
        );
    }
}