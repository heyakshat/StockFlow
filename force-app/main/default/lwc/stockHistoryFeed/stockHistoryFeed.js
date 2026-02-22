import { LightningElement, api, wire } from 'lwc';
import getStockHistory from '@salesforce/apex/InventoryController.getStockHistory';

export default class StockHistoryFeed extends LightningElement {
    @api recordId;

    @wire(getStockHistory, { inventoryId: '$recordId' })
    history;
}