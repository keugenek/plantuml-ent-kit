---
layout: default
title: HMS Entity-Relationship Model
---

# Healthcare Management System Reference Architecture

The Healthcare Management System serves as a platform to facilitate patient care, appointment scheduling, and medical billing. This reference architecture demonstrates the key entities and relationships inherent in a typical Healthcare Management System.

## Entities and Relationships

The primary entities in a Healthcare Management System include `Patient`, `Doctor`, `Appointment`, `Medical Record`, `Billing`, and `Insurance`. Here's a simplified ER diagram representing these entities and their relationships:

```plantuml
@startuml

!define table(x) class x << (T,#FFAAAA) >>
!define primary_key(x) <b>x</b>
!define foreign_key(x) <color:red>x</color>

table(Patient) {
  +primary_key(PatientID): int
  FirstName: varchar(255)
  LastName: varchar(255)
  DateOfBirth: date
}

table(Doctor) {
  +primary_key(DoctorID): int
  FirstName: varchar(255)
  LastName: varchar(255)
  Specialty: varchar(255)
}

table(Appointment) {
  +primary_key(AppointmentID): int
  +foreign_key(PatientID): int
  +foreign_key(DoctorID): int
  AppointmentDate: date
  AppointmentTime: time
}

table(MedicalRecord) {
  +primary_key(RecordID): int
  +foreign_key(PatientID): int
  MedicalHistory: text
  Prescription: text
  Diagnosis: text
}

table(Billing) {
  +primary_key(BillingID): int
  +foreign_key(PatientID): int
  +foreign_key(InsuranceID): int
  AmountDue: decimal(10,2)
  PaymentDate: date
}

table(Insurance) {
  +primary_key(InsuranceID): int
  InsuranceName: varchar(255)
  Coverage: text
}

Patient -- Appointment : has
Patient -- MedicalRecord : has
Patient -- Billing : has
Doctor -- Appointment : has
Appointment -- MedicalRecord : generates
Billing -- Insurance : covered by

@enduml
```
![Healthcare Management System](images/hms.png)

## Entity Descriptions
- Patient: Represents an individual patient with personal details.
- Doctor: Represents a medical doctor with specialization details.
- Appointment: Represents a scheduled appointment between a patient and a doctor.
- Medical Record: Contains medical history, prescriptions, and diagnoses of a patient.
- Billing: Represents the billing information related to a patient's treatment.
- Insurance: Represents the insurance details covering the patient's medical expenses.

## Relationship Descriptions
- A Patient can have multiple Appointments, Medical Records, and Billings.
- A Doctor can have multiple Appointments.
- An Appointment is scheduled between a Patient and a Doctor, and can generate a Medical Record.
- A Billing record is associated with a Patient and an Insurance.

This simplified Healthcare Management System model serves as a basis for understanding the relationships and interactions within a healthcare setting. It can be further expanded or modified to meet the specific needs of different healthcare institutions.

