import 'dart:mirrors';

import 'package:queen_validators/queen_validators.dart';

List<String> validateDto(Object dto) {
  /// reflect the Dto to InstanceMirror
  final dtoMirror = reflect(dto);

  /// take out the Dto fields
  final fields = dtoMirror.type.declarations.values.whereType<VariableMirror>();

  /// errors is a list<String> which will contains the failed validation messages
  final errors = <String>[];

  /// loop for each field so if the the filed is annotated with
  /// any `QueenValidationRule` Object the loop will run the rule against the current
  /// field if is valid or is not annotate with any rules or annotate with other annotation
  /// it will skip it
  for (final field in fields) {
    /// `Iterable<QueenValidationRule>` which contains rules for this field
    final fieldRulesRef = field.metadata.where((r) => r.reflectee is QueenValidationRule);
    final fieldRules = fieldRulesRef.map((r) => r.reflectee).toList().cast<QueenValidationRule>();

    /// get the field value from the object
    final fieldValue = dtoMirror.getField(field.simpleName).reflectee;

    /// loop for every rule in the field rule and apply them
    for (final rule in fieldRules) {
      /// if the validation fails add the field name and
      /// the validation message to the `errors` list
      if (!rule.validate(fieldValue)) {
        /// extract the field name
        final fieldName = MirrorSystem.getName(field.simpleName);

        /// add the error to the list
        errors.add('$fieldName ${rule.errorMsg}');
      }
    }
  }
  return errors;
}
