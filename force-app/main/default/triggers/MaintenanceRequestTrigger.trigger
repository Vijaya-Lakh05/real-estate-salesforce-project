trigger MaintenanceRequestTrigger on Maintenance_Request__c (before insert) {

    MaintenanceRequestHandler.assignVendor(Trigger.new);
}