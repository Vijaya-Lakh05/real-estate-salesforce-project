public class MaintenanceRequestHandler {

    public static void assignVendor(List<Maintenance_Request__c> newRequests) {

        List<Vendor__c> vendors = [
            SELECT Id, Name
            FROM Vendor__c
        ];

        if(vendors.isEmpty()){
            return;
        }

        Map<Id, Integer> vendorWorkload = new Map<Id, Integer>();

        for(AggregateResult ar : [
            SELECT Vendor__c vendorId, COUNT(Id) total
            FROM Maintenance_Request__c
            WHERE Vendor__c != null
            GROUP BY Vendor__c
        ]) {

            vendorWorkload.put(
                (Id)ar.get('vendorId'),
                (Integer)ar.get('total')
            );
        }

        for(Maintenance_Request__c req : newRequests){

            Id selectedVendor;
            Integer minCount = 999999;

            for(Vendor__c v : vendors){

                Integer count = vendorWorkload.containsKey(v.Id)
                    ? vendorWorkload.get(v.Id)
                    : 0;

                if(count < minCount){

                    minCount = count;
                    selectedVendor = v.Id;
                }
            }

            req.Vendor__c = selectedVendor;

            System.debug('Assigned Vendor = ' + selectedVendor);
        }
    }
}