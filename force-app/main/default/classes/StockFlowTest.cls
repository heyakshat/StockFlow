@isTest
public class StockFlowTest 
{
    @testSetup
static void setupData() {
    Warehouse__c wh = new Warehouse__c(Name = 'Jabalpur Main Hub');
    insert wh;
    Product2 prod = new Product2(Name = 'Industrial Sensor', IsActive = true);
    insert prod;

    Account supplier = new Account(Name = 'Global Tech Parts'); 
    insert supplier;

    Inventory__c inv = new Inventory__c(
        Warehouses__c = wh.Id,
        Products__c = prod.Id,
        Current_Stock__c = 100,
        Reorder_Level__c = 50,
        Max_Capacity__c = 500
    );
    insert inv;
}
    
    @isTest
    static void testAutoProcurement() {
        Inventory__c inv = [SELECT Id, Current_Stock__c FROM Inventory__c LIMIT 1];
        
        Test.startTest();
        inv.Current_Stock__c = 30; 
        update inv;
        Test.stopTest();

        List<Purchase_Order__c> pos = [SELECT Id FROM Purchase_Order__c];
        System.assert(pos.size() > 0, 'Automation should create a Purchase Order when stock is low.');
    }
}