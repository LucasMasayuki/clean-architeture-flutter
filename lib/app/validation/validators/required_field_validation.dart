import 'package:equatable/equatable.dart';
import 'package:petdiary/app/presentation/protocols/validation.dart';
import 'package:petdiary/app/validation/protocols/field_validation.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  RequiredFieldValidation(this.field);

  ValidationError validate(Map input) =>
      input[field]?.isNotEmpty == true ? null : ValidationError.requiredField;
}
