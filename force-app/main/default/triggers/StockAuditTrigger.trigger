trigger StockAuditTrigger on Inventory__c (after update) {
    List<Stock_Audit_Log__c> logs = new List<Stock_Audit_Log__c>();
    for (Inventory__c inv : Trigger.new) {
        Inventory__c oldInv = Trigger.oldMap.get(inv.Id);
        if (inv.Current_Stock__c != oldInv.Current_Stock__c) {
            logs.add(new Stock_Audit_Log__c(
                Inventory__c = inv.Id,
                Old_Quantity__c = oldInv.Current_Stock__c,
                New_Quantity__c = inv.Current_Stock__c,
                Changed_By__c = UserInfo.getName()
            ));
        }
    }
    insert logs;
}