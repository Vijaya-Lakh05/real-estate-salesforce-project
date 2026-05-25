import { LightningElement, wire } from 'lwc';
import getExpiringLeases from '@salesforce/apex/PropertyController.getExpiringLeases';

export default class LeaseExpiryList extends LightningElement {

    leases = [];

    @wire(getExpiringLeases)
    wiredLeases({ data, error }) {

        if (data) {

            console.log('RAW DATA:', JSON.stringify(data));

            // FORCE SAFE MAPPING
            this.leases = data.map(row => {
                return {
                    Id: row.Id,
                    Name: row.Name,
                    End_Date__c: row.End_Date__c,
                    PropertyName: row.Property__r ? row.Property__r.Name : 'No Property Assigned'
                };
            });

        } else if (error) {
            console.error(error);
        }
    }
}