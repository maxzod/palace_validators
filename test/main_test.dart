import 'package:palace_validators/palace_validators.dart';
import 'package:test/test.dart';

void main() {
  test('is valid dto', () => expect(validateDto(GoodDto()), []));
  test(
    'is not valid dto',
    () => expect(validateDto(BadDto()), [
      'name min length is 500',
      'name max length is 2',
      'name is not accepted',
      'address min length is 30',
      'address is not valid email address',
    ]),
  );

  test('BadDtoWithNull', () {
    expect(validateDto(BadDtoWithNull()), [
      'name min length is 500',
      'name max length is 2',
      'name is not accepted',
      'address min length is 30',
      'address max length is 40',
      'address is not accepted'
    ]);
  });
  test('Bad Dto With Null And Is Optional', () {
    expect(validateDto(BadDtoWithNullAndOptional()), [
      'name min length is 500',
      'name max length is 2',
      'name is not accepted',
    ]);
  });
}

class GoodDto {
  @MinLength(5)
  @MaxLength(200)
  @IsIn(['queen', 'royal'])
  final String name = 'queen';

  @MinLength(5)
  @MaxLength(200)
  @IsNotIn(['enemy army'])
  final String address = 'kingdom palace';
}

class BadDto {
  @MinLength(500)
  @MaxLength(2)
  @IsIn(['enemies', 'dictators'])
  final String name = 'queen';

  @MinLength(30)
  @MaxLength(40)
  @IsNotIn(['our army'])
  @IsEmail()
  final String address = 'kingdom palace';
}

class BadDtoWithNull {
  @MinLength(500)
  @MaxLength(2)
  @IsIn(['enemies', 'dictators'])
  final String name = 'queen';

  @MinLength(30)
  @MaxLength(40)
  @IsNotIn(['our army'])
  String? address;
}

class BadDtoWithNullAndOptional {
  @MinLength(500)
  @MaxLength(2)
  @IsIn(['enemies', 'dictators'])
  final String name = 'queen';

  @MinLength(30)
  @MaxLength(40)
  @IsNotIn(['our army'])
  @IsOptional()
  String? address;
}
