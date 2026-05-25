import { LightningElement, wire } from 'lwc';
import getPropertyCount from '@salesforce/apex/PropertyController.getPropertyCount';
import getPropertiesPaged from '@salesforce/apex/PropertyController.getPropertiesPaged';

export default class PropertyList extends LightningElement {

    // -------------------------
    // DATA
    // -------------------------
    properties = [];

    pageNumber = 1;
    pageSize = 25;
    totalRecords = 0;
    totalPages = 0;

    // -------------------------
    // FILTERS
    // -------------------------
    distance = null;
    minPrice = null;
    maxPrice = null;
    status = null;
    furnishing = null;

    // -------------------------
    // DROPDOWN OPTIONS
    // -------------------------
    statusOptions = [
    { label: 'Available', value: 'Available' },
    { label: 'Occupied', value: 'Occupied' }
];

    furnishingOptions = [
        { label: 'Furnished', value: 'Furnished' },
        { label: 'Semi-Furnished', value: 'Semi-Furnished' },
        { label: 'Unfurnished', value: 'Unfurnished' }
    ];

    // -------------------------
    // COUNT (DASHBOARD SUPPORT)
    // -------------------------
    @wire(getPropertyCount)
    wiredCount({ data }) {
        if (data) {
            this.totalRecords = data;
            this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
        }
    }

    // -------------------------
    // INIT LOAD
    // -------------------------
    connectedCallback() {
        this.loadData();
    }

   loadData() {

    console.log('loadData called');

    console.log({
        pageNumber: this.pageNumber,
        minPrice: this.minPrice,
        maxPrice: this.maxPrice,
        status: this.status,
        furnishing: this.furnishing
    });

    getPropertiesPaged({
        pageNumber: this.pageNumber,
        minPrice: this.minPrice,
        maxPrice: this.maxPrice,
        status: this.status,
        furnishing: this.furnishing,
        distanceKm: this.distance
    })
    .then(result => {
        this.properties = result;
    })
    .catch(error => {
        console.error(error);
    });
}


    // -------------------------
    // PAGINATION
    // -------------------------
    handleNext() {
        if (this.pageNumber < this.totalPages) {
            this.pageNumber++;
            this.loadData();
        }
    }

    handlePrevious() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            this.loadData();
        }
    }

    // -------------------------
    // FILTER HANDLERS
    // -------------------------
    handleMinPrice(event) {
        this.minPrice = event.target.value ? Number(event.target.value) : null;
    }

    handleMaxPrice(event) {
        this.maxPrice = event.target.value ? Number(event.target.value) : null;
    }

    handleStatus(event) {
        this.status = event.detail.value || null;
    }

    handleFurnishing(event) {
        this.furnishing = event.detail.value || null;
    }

    handleFilterChange() {
    this.pageNumber = 1;
    this.loadData();
}
handleDistance(event) {
    this.distance = event.target.value
        ? Number(event.target.value)
        : null;
}

  

    // -------------------------
    // GETTERS
    // -------------------------
    get isFirstPage() {
        return this.pageNumber === 1;
    }

    get isLastPage() {
        return this.pageNumber === this.totalPages;
    }
}