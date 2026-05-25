import { LightningElement, wire } from 'lwc';
import getPropertyStats from '@salesforce/apex/PropertyController.getPropertyStats';

export default class PropertyDashboard extends LightningElement {

    totalProperties = 0;
    availableProperties = 0;
    occupiedProperties = 0;
    occupancyRate = 0;

    @wire(getPropertyStats)
    wiredStats({ data, error }) {

        if (data) {

            this.totalProperties = data.total;
            this.availableProperties = data.available;
            this.occupiedProperties = data.occupied;

            if (this.totalProperties > 0) {
                this.occupancyRate =
                    ((this.occupiedProperties / this.totalProperties) * 100)
                    .toFixed(2);
            }

        } else if (error) {
            console.error(error);
        }
    }
}