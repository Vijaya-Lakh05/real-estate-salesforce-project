@isTest
private class MaintenanceRequestHandlerTest {

    @isTest
    static void testVendorAssignment() {

        // Create Vendors
        Vendor__c vendor1 = new Vendor__c(
            Name = 'Vendor A',
            Phone__c = '9876543210',
            Email__c = 'vendor1@test.com'
        );

        Vendor__c vendor2 = new Vendor__c(
            Name = 'Vendor B',
            Phone__c = '9876543211',
            Email__c = 'vendor2@test.com'
        );

        insert new List<Vendor__c>{vendor1, vendor2};

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

        Test.startTest();

        // Create Maintenance Request
        Maintenance_Request__c req =
            new Maintenance_Request__c(
                Name = 'Water Leakage',
                Property__c = prop.Id,
                Status__c = 'Open',
                Description__c = 'Pipeline issue'
            );

        insert req;

        Test.stopTest();

        req = [
            SELECT Id,
                   Vendor__c
            FROM Maintenance_Request__c
            WHERE Id = :req.Id
        ];

        System.assertNotEquals(
            null,
            req.Vendor__c,
            'Vendor should be assigned automatically'
        );
    }
    @isTest
static void testNoVendors() {

    Property__c prop = new Property__c(
        Name='Test Property',
        Address__c='Address',
        City__c='Hyd',
        State__c='TS',
        Postal_Code__c='500001',
        Country__c='India',
        Type__c='Residential',
        Status__c='Available',
        Rent__c=10000
    );
    insert prop;

    Maintenance_Request__c req =
        new Maintenance_Request__c(
            Name='Test Request',
            Property__c=prop.Id,
            Status__c='Open'
        );

    Test.startTest();
    insert req;
    Test.stopTest();

    System.assertNotEquals(null, req.Id);
}
}