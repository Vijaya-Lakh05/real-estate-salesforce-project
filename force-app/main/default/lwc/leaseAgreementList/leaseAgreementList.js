import { LightningElement, wire } from 'lwc';
import getLeaseAgreements from '@salesforce/apex/LeaseAgreementController.getLeaseAgreements';

const COLUMNS = [
    { label: 'Lease Name', fieldName: 'Name' },
    { label: 'Property', fieldName: 'propertyName' },
    { label: 'Tenant', fieldName: 'tenantName' },
    { label: 'Monthly Rent', fieldName: 'Agreed_Monthly_Rent__c', type: 'currency' },
    { label: 'Start Date', fieldName: 'Start_Date__c', type: 'date' },
    { label: 'End Date', fieldName: 'End_Date__c', type: 'date' }
];

export default class LeaseAgreementList extends LightningElement {

    columns = COLUMNS;
    agreements = [];

    @wire(getLeaseAgreements)
    wiredAgreements({ data, error }) {

        if (data) {

            this.agreements = data.map(item => {
                return {
                    ...item,
                    propertyName: item.Property__r ? item.Property__r.Name : '',
                    tenantName: item.Tenant__r ? item.Tenant__r.Name : ''
                };
            });

        } else if (error) {
            console.error(error);
        }
    }
}