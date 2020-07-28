 `kasey` workflow

1. `bundle install kasey`
2. `rails g kasey:init` - this will create the kasey.yml file in config/, and
   add other necessary parts
3. edit the config/kasey.yml file
4. `rails kasey:build` generates the `app/controllers/step_controller` and all
   steps at `app/controllers/steps/step_name`, along with updates to the model

```yml
intake_model: Intake
steps:
  - title: "WHAT is your NAME?"
    field_type: text
    field_name: name
  - title: "WHAT is your QUeST?"
    field_type: text
    field_name: quest
  - title: "WHAT is your FAVORITE COLOR?"
    field_type: select
    field_values:
      - label: Blue
        value: blue
      - label: Yellow
        value: yellow
  - title: Are you a shapechanger?
    field_type: YN
```

TODO: list all field types
