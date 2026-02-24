import { LightningElement, wire, track } from 'lwc';
import getInventoryList from '@salesforce/apex/InventoryController.getInventoryList';

const COLUMNS = [
    { label: 'Item Name', fieldName: 'Name', type: 'text' },
    { label: 'Current Stock', fieldName: 'Current_Stock__c', type: 'number', cellAttributes: { alignment: 'left' } },
    { label: 'Reorder Level', fieldName: 'Reorder_Level__c', type: 'number', cellAttributes: { alignment: 'left' } },
    { label: 'Status', fieldName: 'Stock_Status__c', type: 'text' }
];

export default class StockFlowDashboard extends LightningElement {
    @track inventoryData = [];
    @track totalItems = 0;
    @track lowStockCount = 0;
    @track warehouseCount = 0;
    columns = COLUMNS;

    @wire(getInventoryList)
    wiredInventory({ error, data }) {
        if (data) {
            this.inventoryData = data;
            this.calculateMetrics(data);
        } else if (error) {
            console.error('Error fetching inventory data:', error);
        }
    }

    calculateMetrics(data) {
        this.totalItems = data.length;
        this.lowStockCount = data.filter(item => 
            item.Current_Stock__c <= item.Reorder_Level__c
        ).length;
        const uniqueWarehouses = [...new Set(data.map(item => item.Warehouse__c))];
        this.warehouseCount = uniqueWarehouses.filter(id => id).length;
    }
}