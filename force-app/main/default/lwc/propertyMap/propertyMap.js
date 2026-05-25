import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import LATITUDE from '@salesforce/schema/Property__c.Latitude__c';
import LONGITUDE from '@salesforce/schema/Property__c.Longitude__c';
import NAME from '@salesforce/schema/Property__c.Name';

const FIELDS = [NAME, LATITUDE, LONGITUDE];

export default class PropertyMap extends LightningElement {

    @api recordId;

    mapMarkers = [];

    @wire(getRecord, {
        recordId: '$recordId',
        fields: FIELDS
    })
    wiredProperty({ data }) {

        if(data){

            this.mapMarkers = [
                {
                    location: {
                        Latitude: data.fields.Latitude__c.value,
                        Longitude: data.fields.Longitude__c.value
                    },
                    title: data.fields.Name.value
                }
            ];
        }
    }
}