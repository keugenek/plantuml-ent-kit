# CRM Entity-Relationship Model

Customer Relationship Management (CRM) systems are crucial for managing an 
organization's interactions with customers and potential customers.
A well-designed CRM model helps in understanding customer behaviors,
managing relationships, and enhancing sales and support processes.

Below is a reference entity-relationship model for a typical CRM system illustrated using PlantUML.

## Entities and Relationships

In a typical CRM system, the primary entities include 
`Customer`, `Contact`, `Opportunity`, `Lead`, `Account`, `Case`, and `Activity`.

Here is a simplified ER diagram representing these entities and their relationships:

```plantuml
@startuml

!define table(x) class x << (T,#FFAAAA) >>
!define primary_key(x) <b>x</b>
!define foreign_key(x) <color:red>x</color>

table(Customer) {
  +primary_key(CustomerID): int
  FirstName: varchar(255)
  LastName: varchar(255)
  Email: varchar(255)
  Phone: varchar(15)
}

table(Contact) {
  +primary_key(ContactID): int
  +foreign_key(CustomerID): int
  ContactType: varchar(50)
  ContactValue: varchar(255)
}

table(Opportunity) {
  +primary_key(OpportunityID): int
  +foreign_key(CustomerID): int
  OpportunityName: varchar(255)
  Stage: varchar(50)
  CloseDate: date
}

table(Lead) {
  +primary_key(LeadID): int
  LeadSource: varchar(255)
  Status: varchar(50)
}

table(Account) {
  +primary_key(AccountID): int
  AccountName: varchar(255)
  Industry: varchar(255)
}

table(Case) {
  +primary_key(CaseID): int
  +foreign_key(CustomerID): int
  +foreign_key(AccountID): int
  Subject: varchar(255)
  Status: varchar(50)
  Priority: varchar(50)
}

table(Activity) {
  +primary_key(ActivityID): int
  +foreign_key(CustomerID): int
  ActivityType: varchar(50)
  Description: text
  DueDate: date
}

Customer -- Contact : has
Customer -- Opportunity : has
Customer -- Case : has
Customer -- Activity : has
Account -- Case : has

@enduml
```
![CRM](images/crm.png)

# Entity Descriptions
- Customer: Central entity representing individual customers.
- Contact: Contains contact information related to customers.
- Opportunity: Represents sales opportunities with customers.
- Lead: Represents potential customers or leads.
- Account: Represents business accounts.
- Case: Contains support or service cases related to customers and accounts.
- Activity: Represents various activities or interactions with customers.

# Relationship Descriptions
A Customer can have multiple Contacts, Opportunities, Cases, and Activities.

An Account can have multiple Cases.

Each Contact, Opportunity, Case, and Activity is associated with one Customer.

Each Case may be associated with an Account.

This simplified CRM model serves as a basis for understanding the relationships and interactions within a CRM system. It can be further expanded or modified to meet the specific needs of different organizations.
