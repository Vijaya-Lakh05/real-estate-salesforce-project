public with sharing class PropertyController {

    
    // COUNT FOR DASHBOARD
    
    @AuraEnabled(cacheable=true)
    public static Integer getPropertyCount() {
        return [SELECT COUNT() FROM Property__c];
    }

    
    // 2. PAGINATION + FILTERS (MAIN METHOD)
    
  @AuraEnabled(cacheable=true)
public static List<Property__c> getPropertiesPaged(
    Integer pageNumber,
    Decimal minPrice,
    Decimal maxPrice,
    String status,
    String furnishing,
    Decimal distanceKm
) {

    Integer pageSize = 25;
    Integer offsetSize = (pageNumber - 1) * pageSize;

    List<Property__c> properties = [
        SELECT Id,
               Name,
               City__c,
               Rent__c,
               Status__c,
               Furnishing_Status__c,
               Latitude__c,
               Longitude__c
        FROM Property__c
        ORDER BY CreatedDate DESC
        LIMIT :pageSize
        OFFSET :offsetSize
    ];

    List<Property__c> filteredProperties = new List<Property__c>();

    for(Property__c p : properties){

        Boolean match = true;

        if(minPrice != null && p.Rent__c < minPrice){
            match = false;
        }

        if(maxPrice != null && p.Rent__c > maxPrice){
            match = false;
        }

        if(status != null && status != '' && p.Status__c != status){
            match = false;
        }

        if(furnishing != null && furnishing != '' &&
           p.Furnishing_Status__c != furnishing){
            match = false;
        }

        if(match){
            filteredProperties.add(p);
        }
    }

    return filteredProperties;
}

    
    //  LEASE EXPIRY (30 DAYS)
   
    @AuraEnabled(cacheable=true)
    public static List<Lease_Agreement__c> getExpiringLeases() {
        return [
            SELECT Id, Name, End_Date__c, Property__c, Property__r.Name
            FROM Lease_Agreement__c
            WHERE End_Date__c = NEXT_N_DAYS:30
        ];
    }

    
    //  DASHBOARD STATS
   
    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getPropertyStats() {

        Map<String, Integer> stats = new Map<String, Integer>();

        stats.put('total', [SELECT COUNT() FROM Property__c]);

        stats.put('available',
            [SELECT COUNT() FROM Property__c WHERE Status__c = 'Available']
        );

        stats.put('occupied',
            [SELECT COUNT() FROM Property__c WHERE Status__c = 'Occupied']
        );

        return stats;
    }
}