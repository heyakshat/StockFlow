public with sharing class StockAuditHandler {

    public static void logStockChanges(List<Inventory__c> newItems, Map<Id, Inventory__c> oldMap) {
        List<Task> auditTasks = new List<Task>();
        
        for (Inventory__c inv : newItems) {
            Inventory__c oldInv = oldMap.get(inv.Id);
            
            if (inv.Current_Stock__c != oldInv.Current_Stock__c) {
                auditTasks.add(new Task(
                    Subject = 'Stock Level Changed',
                    Description = 'Stock updated from ' + oldInv.Current_Stock__c + ' to ' + inv.Current_Stock__c,
                    WhatId = inv.Id,           
                    Status = 'Completed',      
                    ActivityDate = Date.today(),
                    Priority = 'Normal'
                ));
            }
        }
        
        if (!auditTasks.isEmpty()) {
            insert auditTasks;
        }
    }
}