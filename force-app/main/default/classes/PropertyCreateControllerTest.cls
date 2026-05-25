@isTest
private class PropertyCreateControllerTest {

    @isTest
    static void testCreateProperty() {

        Test.startTest();

        Id propertyId = PropertyCreateController.createProperty(
            'Blue Villa',
            'Hyderabad',
            25000,
            '123 Main Street',
            'Telangana',
            '500001',
            'India',
            'Residential',
            'Available'
        );

        Test.stopTest();

        Property__c propertyRec = [
            SELECT Id,
                   Name,
                   City__c,
                   Rent__c,
                   Address__c,
                   State__c,
                   Postal_Code__c,
                   Country__c,
                   Type__c,
                   Status__c
            FROM Property__c
            WHERE Id = :propertyId
        ];

        System.assertEquals('Blue Villa', propertyRec.Name);
        System.assertEquals('Hyderabad', propertyRec.City__c);
        System.assertEquals(25000, propertyRec.Rent__c);
        System.assertEquals('123 Main Street', propertyRec.Address__c);
        System.assertEquals('Telangana', propertyRec.State__c);
        System.assertEquals('500001', propertyRec.Postal_Code__c);
        System.assertEquals('India', propertyRec.Country__c);
        System.assertEquals('Residential', propertyRec.Type__c);
        System.assertEquals('Available', propertyRec.Status__c);
    }
}