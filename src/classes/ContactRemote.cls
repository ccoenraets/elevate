global with sharing class ContactRemote {

    @RemoteAction
    global static List<Contact> findAll() {

        String soql = 'SELECT Id, Name, Title FROM Contact';

        return(database.Query(soql));
    }

    @RemoteAction
    global static List<Contact> findByName(string searchKey) {

    	searchKey = '%' + searchKey + '%';
        String soql = 'SELECT Id, Name, Title, Phone, Email FROM Contact where Name LIKE :searchKey';

        return(database.Query(soql));
    }

}