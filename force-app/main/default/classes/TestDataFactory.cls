@isTest
public with sharing class TestDataFactory {
	public static void grantsTestDataFactory() {
		Account account = new Account();
		account.Name = 'Test Account';
		insert account;

		Contact contact = new Contact();
		contact.FirstName = 'Test';
		contact.LastName = 'Contact';
		contact.AccountId = account.Id;
		insert contact;

		Expenditure_Category__c expenditureCategory = new Expenditure_Category__c();
		expenditureCategory.Name = 'Test Expenditure Category';
		expenditureCategory.Expenditure_Category_Name__c = 'Test Expenditure Category';
		insert expenditureCategory;

		Program__c program = new Program__c();
		program.Name = 'Test Expenditure Sub Category';
		program.Expenditure_Category__c = expenditureCategory.Id;
		// program.Sub_Category_Amount__c = 1000000;
		// program.Sub_Category_Amount_Expended__c = 0;
		// program.Sub_Category_Amount_Remaining__c = 0;
		program.Include_Reference_Eligibility__c = true;
		insert program;

		Reference_Eligibility__c referenceEligilibilty = new Reference_Eligibility__c();
		referenceEligilibilty.Expenditure_Sub_Category__c = program.Id;
		referenceEligilibilty.Question__c = 'test question';
		referenceEligilibilty.Correct_Response__c = 'Yes No';
		referenceEligilibilty.Sort_Order__c = 1;
		insert referenceEligilibilty;

		Reference_Cost_Category__c referenceCostCategory = new Reference_Cost_Category__c();
		referenceCostCategory.Program__c = program.Id;
		referenceCostCategory.Cost_Category_Name__c = 'Test Category';
		referenceCostCategory.Cost_Subcategory__c = 'Test Category';
		referenceCostCategory.Description__c = 'Test Category';
		referenceCostCategory.Cost_Category_Status__c = 'Active';
		referenceCostCategory.Sort_Order__c = 1;
		referenceCostCategory.Add_Up__c = true;
		insert referenceCostCategory;

		Grant__c grant = new Grant__c();
		grant.Name = 'Test Project';
		grant.Program__c = program.Id;
		grant.Project_Name__c = 'CC Test Project';
		grant.Adopted_Budget__c = 1000000;
		insert grant;

		Application__c app = new Application__c();
		app.Subrecipient__c = account.Id;
		app.Contact__c = contact.Id;
		app.Program__c = program.Id;
		app.Status__c = 'Approved';
		insert app;

		// Subrecipient_Agreement__c agreement = new Subrecipient_Agreement__c();
	}
}