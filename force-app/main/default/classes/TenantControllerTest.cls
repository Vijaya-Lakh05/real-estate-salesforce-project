@isTest
private class TenantControllerTest {

    @isTest
    static void testGetTenants() {

        Tenant__c tenant = new Tenant__c(
            Name = 'John Doe',
            Phone__c = '9876543210',
            Email__c = 'john@test.com'
        );

        insert tenant;

        Test.startTest();

        List<Tenant__c> tenants =
            TenantController.getTenants();

        Test.stopTest();

        System.assertEquals(
            1,
            tenants.size()
        );

        System.assertEquals(
            'John Doe',
            tenants[0].Name
        );
    }
}