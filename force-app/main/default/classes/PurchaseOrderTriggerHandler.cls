public with sharing class PurchaseOrderTriggerHandler {
    public static void handleAfterUpdate(List<Purchase_Order__c> newPOs, Map<Id, Purchase_Order__c> oldMap) {
        for (Purchase_Order__c po : newPOs) {
            Purchase_Order__c oldPo = oldMap.get(po.Id);
            
            if (po.Status__c == 'Received' && oldPo.Status__c != 'Received') {
            }
        }
    }
}