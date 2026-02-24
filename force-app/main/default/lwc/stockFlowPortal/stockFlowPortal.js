import { LightningElement, wire, track } from 'lwc';
import getInventoryList from '@salesforce/apex/InventoryController.getInventoryList';

const COLUMNS = [
    { label: 'Item Name', fieldName: 'Name', type: 'text' },
    { label: 'Stock Level', fieldName: 'Current_Stock__c', type: 'number' },
    { label: 'Threshold', fieldName: 'Reorder_Level__c', type: 'number' },
    { label: 'Status', fieldName: 'Stock_Status__c', type: 'text' }
];

export default class StockFlowPortal extends LightningElement {
    @track inventoryData = [];
    @track totalItems = 0;
    @track lowStockCount = 0;
    @track healthyStockCount = 0;
    columns = COLUMNS;

    @wire(getInventoryList)
    wiredInventory({ error, data }) {
        if (data) {
            this.inventoryData = data;
            this.totalItems = data.length;
            this.lowStockCount = data.filter(item => item.Current_Stock__c <= item.Reorder_Level__c).length;
            this.healthyStockCount = this.totalItems - this.lowStockCount;
        } else if (error) {
            console.error('Data Fetch Error:', error);
        }
    }
}