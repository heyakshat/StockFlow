public with sharing class InventoryTriggerHandler {

    public static void handleAfterUpdate(List<Inventory__c> newItems, Map<Id, Inventory__c> oldMap) 
    {
        List<Purchase_Order__c> poList = new List<Purchase_Order__c>();

        for (Inventory__c inv : newItems) {
            Inventory__c oldInv = oldMap.get(inv.Id);
            
            if (inv.Current_Stock__c <= inv.Reorder_Level__c && oldInv.Current_Stock__c > inv.Reorder_Level__c) {
                poList.add(new Purchase_Order__c(
                    Status__c = 'Draft'
                ));
            }
        }


        if (!poList.isEmpty()) {
            insert poList;
        }
    }
    public static void createPurchaseOrder(Inventory__c inv) 
    {
    Purchase_Order__c newPO = new Purchase_Order__c();
    newPO.Inventory_Link__c = inv.Id;
    newPO.Products__c = inv.Products__c;
    
    newPO.Warehouse__c = inv.Warehouse__c; 
    
    newPO.Quantity__c = 100; 
    newPO.Status__c = 'Draft';
    
    insert newPO;
}
}
