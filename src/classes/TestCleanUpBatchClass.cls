@isTest
private class TestCleanUpBatchClass {

  static testmethod void test() {
    // The query used by the batch job.
    String query = 'SELECT Id,CreatedDate FROM Merchandise__c ' +
                    'WHERE Id NOT IN (SELECT Merchandise__c FROM Line_Item__c)';
    // Create some test merchandise items to be deleted
    //   by the batch job.
    Warehouse__c w = new Warehouse__c(
            Name='Warehouse 1',
            City__c='San Francisco',
            Location__Latitude__s=37.7833,
            Location__Longitude__s=122.4167);
    insert w;
    Merchandise__c[] ml = new List<Merchandise__c>();
    for (Integer i=0;i<10;i++) {
      Merchandise__c m = new Merchandise__c(
         Name='Merchandise ' + i,
         Price__c=2,
         Quantity__c=100,
         Warehouse__c = w.Id);
      ml.add(m);
    } 

    insert ml;
    Test.startTest();
    CleanUpRecords c = new CleanUpRecords(query);
    Database.executeBatch(c);
    Test.stopTest();
    // Verify merchandise items got deleted
    Integer i = [SELECT COUNT() FROM Merchandise__c];
    System.assertEquals(i, 0);
  }
}