import { LightningElement, wire, track } from 'lwc';
import getFullInventory from '@salesforce/apex/InventoryController.getAllInventory';

const COLUMNS = [
    { label: 'Product', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Warehouse', fieldName: 'WH_Name', type: 'text' },
    { label: 'Stock', fieldName: 'Current_Stock__c', type: 'number' },
    { 
        label: 'Status', 
        fieldName: 'Status_Label', 
        type: 'text',
        cellAttributes: { class: { fieldName: 'statusColor' } } 
    }
];

export default class StockCommandCenter extends LightningElement {
    @track fullData = [];
    @track filteredData = [];
    columns = COLUMNS;
    
    // Metrics
    lowStockCount = 0;
    warehouseCount = 0;
    orderCount = 0;

    @wire(getFullInventory)
    wiredInventory({ error, data }) {
        if (data) {
            this.fullData = data.map(item => ({
                ...item,
                WH_Name: item.Warehouse__r ? item.Warehouse__r.Name : 'Unassigned',
                Status_Label: item.Current_Stock__c <= item.Reorder_Level__c ? 'REORDER' : 'HEALTHY',
                statusColor: item.Current_Stock__c <= item.Reorder_Level__c ? 'slds-text-color_error' : 'slds-text-color_success'
            }));
            this.filteredData = this.fullData;
            this.calculateMetrics();
        }
    }

    calculateMetrics() {
        this.lowStockCount = this.fullData.filter(i => i.Current_Stock__c <= i.Reorder_Level__c).length;
        const whs = new Set(this.fullData.map(i => i.WH_Name));
        this.warehouseCount = whs.size;
    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
        this.filteredData = this.fullData.filter(item => 
            item.Name.toLowerCase().includes(searchKey) || 
            item.WH_Name.toLowerCase().includes(searchKey)
        );
    }
}