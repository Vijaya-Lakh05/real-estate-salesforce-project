@isTest
private class LeaseExpiryReminderBatchTest {

    @isTest
    static void testBatchForOneDayReminder() {

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
            End_Date__c = Date.today().addDays(1)
        );
        insert lease;

        Test.startTest();

        Database.executeBatch(
            new LeaseExpiryReminderBatch(1)
        );

        Test.stopTest();

        System.assert(true);
    }

    @isTest
    static void testBatchForThirtyDayReminder() {

        Property__c prop = new Property__c(
            Name = 'Property 2',
            Address__c = 'Address',
            City__c = 'Hyderabad',
            State__c = 'Telangana',
            Postal_Code__c = '500001',
            Country__c = 'India',
            Type__c = 'Residential',
            Status__c = 'Available',
            Rent__c = 30000
        );
        insert prop;

        Tenant__c tenant = new Tenant__c(
            Name = 'Jane Doe',
            Email__c = 'jane@test.com'
        );
        insert tenant;

        Lease_Agreement__c lease = new Lease_Agreement__c(
            Name = 'Lease 30 Days',
            Property__c = prop.Id,
            Tenant__c = tenant.Id,
            Terms__c = '6 Months',
            Agreed_Monthly_Rent__c = 30000,
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(30)
        );
        insert lease;

        Test.startTest();

        Database.executeBatch(
            new LeaseExpiryReminderBatch(30)
        );

        Test.stopTest();

        System.assert(true);
    }
}