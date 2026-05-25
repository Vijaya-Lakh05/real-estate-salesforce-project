@isTest
private class PropertyControllerTest {

    @isTest
    static void testPropertyControllerMethods() {

        // Create Property 1
        Property__c prop1 = new Property__c(
            Name = 'Blue Villa',
            Address__c = 'Address 1',
            City__c = 'Hyderabad',
            State__c = 'TS',
            Postal_Code__c = '500001',
            Country__c = 'India',
            Type__c = 'Residential',
            Status__c = 'Available',
            Furnishing_Status__c = 'Furnished',
            Rent__c = 25000
        );

        // Create Property 2
        Property__c prop2 = new Property__c(
            Name = 'Green Villa',
            Address__c = 'Address 2',
            City__c = 'Hyderabad',
            State__c = 'TS',
            Postal_Code__c = '500002',
            Country__c = 'India',
            Type__c = 'Residential',
            Status__c = 'Occupied',
            Furnishing_Status__c = 'Semi-Furnished',
            Rent__c = 30000
        );

        insert new List<Property__c>{prop1, prop2};

        // Create Tenant
        Tenant__c tenant = new Tenant__c(
            Name = 'John Doe',
            Email__c = 'john@test.com'
        );
        insert tenant;

        // Create Lease Agreement
        Lease_Agreement__c lease = new Lease_Agreement__c(
            Name = 'Lease Test',
            Property__c = prop1.Id,
            Tenant__c = tenant.Id,
            Terms__c = '12 Months',
            Agreed_Monthly_Rent__c = 25000,
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(15)
        );
        insert lease;

        Test.startTest();

        // getPropertyCount()
        Integer count = PropertyController.getPropertyCount();
        System.assertEquals(2, count);

        // getPropertiesPaged()
        List<Property__c> properties =
            PropertyController.getPropertiesPaged(
                1,
                20000,
                35000,
                null,
                null,
                null
            );

        System.assert(properties.size() > 0);

        // getExpiringLeases()
        List<Lease_Agreement__c> leases =
            PropertyController.getExpiringLeases();

        System.assertEquals(1, leases.size());

        // getPropertyStats()
        Map<String, Integer> stats =
            PropertyController.getPropertyStats();

        System.assertEquals(2, stats.get('total'));
        System.assertEquals(1, stats.get('available'));
        System.assertEquals(1, stats.get('occupied'));

        Test.stopTest();
    }
}