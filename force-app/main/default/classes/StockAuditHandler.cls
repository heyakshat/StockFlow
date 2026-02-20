public with sharing class StockAuditHandler {
    public static void logStockChanges(List<Inventory__c> newItems, Map<Id, Inventory__c> oldMap) {
        List<Stock_Log__c> logsToInsert = new List<Stock_Log__c>();
        
        for (Inventory__c inv : newItems) {
            Inventory__c oldInv = oldMap.get(inv.Id);
            
            if (inv.Current_Stock__c != oldInv.Current_Stock__c) {
                logsToInsert.add(new Stock_Log__c(
                    Inventory_Item__c = inv.Id,
                    Previous_Stock__c = oldInv.Current_Stock__c,
                    New_Stock__c = inv.Current_Stock__c,
                    User__c = UserInfo.getUserId(),
                    Change_Date__c = System.now()
                ));
            }
        }
        
        if (!logsToInsert.isEmpty()) {
            insert logsToInsert;
        }
    }
}