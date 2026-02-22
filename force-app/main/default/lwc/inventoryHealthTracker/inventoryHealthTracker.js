import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import STOCK_FIELD from '@salesforce/schema/Inventory__c.Current_Stock__c';
import MAX_FIELD from '@salesforce/schema/Inventory__c.Max_Capacity__c';
import REORDER_FIELD from '@salesforce/schema/Inventory__c.Reorder_Level__c';

export default class InventoryHealthTracker extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: [STOCK_FIELD, MAX_FIELD, REORDER_FIELD] })
    inventory;

    get currentStock() { return getFieldValue(this.inventory.data, STOCK_FIELD) || 0; }
    get maxCapacity() { return getFieldValue(this.inventory.data, MAX_FIELD) || 1; }
    get reorderLevel() { return getFieldValue(this.inventory.data, REORDER_FIELD) || 0; }

    get utilization() {
        return Math.round((this.currentStock / this.maxCapacity) * 100);
    }

    get healthStatus() {
        if (this.currentStock <= this.reorderLevel) return 'LOW STOCK - ACTION REQUIRED';
        if (this.currentStock >= this.maxCapacity) return 'CAPACITY FULL';
        return 'STOCK HEALTHY';
    }

    get badgeClass() {
        return this.currentStock <= this.reorderLevel ? 'slds-theme_error' : 'slds-theme_success';
    }

    get barVariant() {
        return this.currentStock <= this.reorderLevel ? 'expired' : 'base';
    }
}