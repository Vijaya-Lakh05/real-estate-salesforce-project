import { LightningElement, api } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';

import jsPDFResource from '@salesforce/resourceUrl/jsPDF';

import getLeaseAgreement
from '@salesforce/apex/LeaseAgreementPdfController.getLeaseAgreement';

import sendLeaseEmail
from '@salesforce/apex/LeaseAgreementPdfController.sendLeaseEmail';

export default class LeaseAgreementPdf extends LightningElement {

    @api recordId;

    jsPdfInitialized = false;

    renderedCallback() {

        if (this.jsPdfInitialized) {
            return;
        }

        this.jsPdfInitialized = true;

        loadScript(this, jsPDFResource)
            .then(() => {
                console.log('jsPDF Loaded');
            })
            .catch(error => {
                console.error(error);
            });
    }

    downloadPdf() {

        getLeaseAgreement({
            recordId: this.recordId
        })
        .then(result => {

            const { jsPDF } = window.jspdf;

            const doc = new jsPDF();

            doc.text('Lease Agreement', 20, 20);

            doc.text('Lease Name: ' + result.Name, 20, 40);

            doc.text(
                'Property: ' +
                (result.property__r ? result.property__r.Name : 'Not Available'),
                20,
                60
            );

            doc.text(
                'Tenant: ' +
                (result.Tenant__r ? result.Tenant__r.Name : ''),
                20,
                80
            );

            doc.text(
                'Monthly Rent: ' +
                result.Agreed_Monthly_Rent__c,
                20,
                100
            );

            doc.text(
                'Start Date: ' +
                result.Start_Date__c,
                20,
                120
            );

            doc.text(
                'End Date: ' +
                result.End_Date__c,
                20,
                140
            );

            doc.text(
                'Terms: ' +
                result.Terms__c,
                20,
                160
            );

            doc.save('LeaseAgreement.pdf');
        })
        .catch(error => {
            console.error(error);
        });
        console.log('LEASE DATA:', JSON.stringify(result));
        console.log('FULL LEASE RESPONSE:', result);
        console.log('PROPERTY OBJECT:', result.Property__r);
    }

    sendEmail() {

    sendLeaseEmail({
        recordId: this.recordId
    })
    .then(() => {
        alert('Email Sent Successfully');
    })
    .catch(error => {
        console.error(error);
    });
}
}