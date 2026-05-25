import { LightningElement } from 'lwc';
import createProperty from '@salesforce/apex/PropertyCreateController.createProperty';

export default class PropertyCreate extends LightningElement {

    propertyName;
    city;
    rent;
    address;
    state;
    postalCode;
    country;
    type;
    status;

    imageUploaded = false;

    // -----------------------------
    // INPUT HANDLERS
    // -----------------------------

    handleName(event) {
        this.propertyName = event.target.value;
    }

    handleCity(event) {
        this.city = event.target.value;
    }

    handleRent(event) {
        this.rent = event.target.value;
    }

    handleAddress(event) {
        this.address = event.target.value;
    }

    handleState(event) {
        this.state = event.target.value;
    }

    handlePostalCode(event) {
        this.postalCode = event.target.value;
    }

    handleCountry(event) {
        this.country = event.target.value;
    }

    handleType(event) {
        this.type = event.detail.value;
    }

    handleStatus(event) {
        this.status = event.detail.value;
    }

    // -----------------------------
    // COMBOBOX OPTIONS
    // -----------------------------

    get typeOptions() {
        return [
            { label: 'Residential', value: 'Residential' },
            { label: 'Commercial', value: 'Commercial' }
        ];
    }

    get statusOptions() {
        return [
            { label: 'Available', value: 'Available' },
            { label: 'Occupied', value: 'Occupied' }
        ];
    }

    // -----------------------------
    // FILE UPLOAD
    // -----------------------------

    handleUploadFinished(event) {
        alert('File uploaded');
        console.log('Uploaded Files:', event.detail.files);

        this.imageUploaded = true;
    }

    // -----------------------------
    // SAVE PROPERTY
    // -----------------------------

    handleSave() {

        alert('Create button clicked');

        if (!this.imageUploaded) {
            alert('Please upload an image.');
            return;
        }

        alert('Calling Apex');

        createProperty({
            propertyName: this.propertyName,
            city: this.city,
            rent: this.rent,
            address: this.address,
            state: this.state,
            postalCode: this.postalCode,
            country: this.country,
            type: this.type,
            status: this.status
        })
        .then(result => {
            alert('Property Created');
            console.log(result);
        })
        .catch(error => {
            console.error('FULL ERROR:', error);

            if (error.body) {
                alert(JSON.stringify(error.body));
            } else {
                alert(JSON.stringify(error));
            }
        });
    }
}