public with sharing class PropertyCreateController {

    @AuraEnabled
    public static Id createProperty(
        String propertyName,
        String city,
        Decimal rent,
        String address,
        String state,
        String postalCode,
        String country,
        String type,
        String status
    ) {

        Property__c propertyRec = new Property__c();

        propertyRec.Name = propertyName;
        propertyRec.City__c = city;
        propertyRec.Rent__c = rent;

        propertyRec.Address__c = address;
        propertyRec.State__c = state;
        propertyRec.Postal_Code__c = postalCode;
        propertyRec.Country__c = country;
        propertyRec.Type__c = type;
        propertyRec.Status__c = status;

        insert propertyRec;

        return propertyRec.Id;
    }
}