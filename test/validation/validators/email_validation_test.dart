import 'package:flutter_test/flutter_test.dart';
import 'package:petdiary/app/presentation/protocols/validation.dart';
import 'package:petdiary/app/validation/validators/email_validation.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate({}), null);
    expect(sut.validate({'any_field': null}), null);
  });

  test('Should return null if email is valid', () {
    expect(
      sut.validate({'any_field': 'rodrigo.manguinho@gmail.com'}),
      null,
    );
  });

  test('Should return error if email is invalid', () {
    expect(
      sut.validate({'any_field': 'rodrigo.manguinho'}),
      ValidationError.invalidField,
    );
  });
}
