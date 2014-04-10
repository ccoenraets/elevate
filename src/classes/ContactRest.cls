@RestResource(urlMapping='/contact')
global with sharing class ContactRest {

	@HttpGet
    global static List<Contact> getContacts() {
		String name = RestContext.request.params.get('name');
        String soql;
        if (String.isNotBlank(name)) {
	    	name = '%' + name + '%';
    	    soql = 'SELECT Id, Name, Title, Phone, Email FROM Contact where Name LIKE :name LIMIT 50';
        } else {
        	soql = 'SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 50';
        }
        return(database.Query(soql));
        
    }
	
	class RESTException extends Exception {}

}