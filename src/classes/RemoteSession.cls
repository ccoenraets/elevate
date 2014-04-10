global with sharing class RemoteSession {

    @RemoteAction
    global static List<Session__c> findAll() {

        String soql = 'SELECT Id, Name, Description FROM Session__c';

        return(database.Query(soql));
    }

}