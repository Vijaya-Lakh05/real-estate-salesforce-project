import { LightningElement, wire } from 'lwc';
import getTenants from '@salesforce/apex/TenantController.getTenants';

const COLUMNS = [
    { label: 'Tenant Name', fieldName: 'Name' },
    { label: 'Phone Number', fieldName: 'Phone__c' },
    { label: 'Email', fieldName: 'Email__c' }
];

export default class TenantList extends LightningElement {

    columns = COLUMNS;
    tenants = [];

    @wire(getTenants)
    wiredTenants({ data, error }) {

        if(data){
            this.tenants = data;
        }

        if(error){
            console.error(error);
        }
    }
}