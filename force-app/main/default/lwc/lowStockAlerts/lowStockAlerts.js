import { LightningElement, wire, track } from 'lwc';
import getLowStockItems from '@salesforce/apex/InventoryController.getLowStockItems';

const COLUMNS = [
    { label: 'Item Name', fieldName: 'Name', type: 'text' },
    { label: 'Warehouse', fieldName: 'WarehouseName', type: 'text' },
    { 
        label: 'Stock', 
        fieldName: 'Current_Stock__c', 
        type: 'number',
        cellAttributes: { class: { fieldName: 'stockColor' } } 
    },
    { label: 'Reorder Level', fieldName: 'Reorder_Level__c', type: 'number' }
];

export default class LowStockAlerts extends LightningElement {
    @track items = [];
    columns = COLUMNS;

    @wire(getLowStockItems)
    wiredItems({ error, data }) {
        if (data) {
            this.items = data.map(record => {
                return {
                    ...record,
                    WarehouseName: record.Warehouses__r ? record.Warehouses__r.Name : 'N/A',
                    stockColor: 'slds-text-color_error slds-font-weight_bold'
                };
            });
        } else if (error) {
            console.error('Error fetching inventory:', error);
        }
    }
}