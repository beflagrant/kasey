# Clinic Workflow

## Clinic Intake

### Sample Questions

1. What is your name?
2. What is your date of birth?
3. Do you have insurance? Upload a picture of your insurance card

For a nominal config, consider: [clinic_intake](clinic_intake.yml)

## Visit Intake

1. Is this an emergency?
2. Where does it hurt?
3. How did it happen?
4. On a scale of 1-10 how bad does it hurt?
5. Would you like to schedule an appointment?

### Sample Questions

## Workflow

1. User submitted (ClinicIntake.status => :new)
2. Nurse reviewed (ClinicIntake.status => :accepted or :pending)
3. Nurse asked additional questions (ClinicIntake::Note)
4. Nurse reviewed
5. Answers accepted (ClinicIntake.status => :accepted)
6. Appointment

## Actions

- Create a new case (`ClinicIntakeCase`)
- Check the status of a case
- Update a case

## Statuses

1. ClinicIntake:

- :new
- :pending
- :accepted
- :abandoned

2. VisitIntake:

- :new
- :scheduled
- :complete
- :abandoned
