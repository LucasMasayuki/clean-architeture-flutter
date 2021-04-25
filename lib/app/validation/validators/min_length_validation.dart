import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:petdiary/app/presentation/protocols/validation.dart';
import 'package:petdiary/app/validation/protocols/field_validation.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;

  List get props => [field, size];

  MinLengthValidation({
    @required this.field,
    @required this.size,
  });

  ValidationError validate(Map input) =>
      input[field] != null && input[field].length >= size
          ? null
          : ValidationError.invalidField;
}
