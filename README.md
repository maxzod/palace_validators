# **`Part of Queen Palace 🏰👑`**

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

# Palace Validators

# Motivation

- the palace need to validate the request body throw some rules with easy clean and readable way
- inspired from `class-validators` we built this package to fix this problem

# Content

- helper function `List<String> validateDto(OBject o)` which validate a DTO based on decorations from
  `queen_validators` package
- provider validation rules from `queen_validators` package

# example

```dart
class GoodDto {
  @MinLength(5)
  @MaxLength(200)
  final String name = 'queen';

  @MinLength(5)
  @MaxLength(200)
  final String address = 'kingdom palace';

  @IsEmail()
  final String email = 'queen@royal.kingdom';
}

 final failedRules = validateDto(GoodDto());
  if(failedRules.isEmpty){
     // * the dto passed the validation successfully
  }else{
     // * the dto has one or more failed rules
     failedRules.forEach(print);
     // the result will be formatted like this in case  of any failed rules
     /// '`$fieldName ${rule.errorMsg}'`
     /// email failure
     /// '`email is not valid email address'`
  }


```

## Notes

the palace core package will be responsible for instantiates the `Dto` form req body
example

```dart
final SignInDto dtoInstance = buildDto<SignInDto>({'email':'queen@Royal.kingdom'});
print(dtoInstance is SignInDto) // true
print(dtoInstance.email) // queen@Royal.kingdom
```

# TODO

- [ ] add support for isRequired
- [ ] add support for isOptional

## License

The Palace-Validators framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
