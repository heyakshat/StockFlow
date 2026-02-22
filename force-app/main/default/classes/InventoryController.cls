public with sharing class InventoryController {
    @AuraEnabled(cacheable=true)
    public static List<Inventory__c> getAllInventory() 
    {
        try {
            return [
                SELECT Id, 
                       Name, 
                       Current_Stock__c, 
                       Reorder_Level__c, 
                       Warehouses__r.Name 
                FROM Inventory__c 
                WITH SECURITY_ENFORCED
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching inventory: ' + e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Task> getStockHistory(Id inventoryId) {
    return [SELECT Id, Subject, Description, CreatedDate 
            FROM Task 
            WHERE WhatId = :inventoryId 
            ORDER BY CreatedDate DESC 
            LIMIT 5];
}
}