enum ValidationType { apiKey }

enum ValidationError { empty, short, invalid }

class ValidationUseCase {
  static ValidationError? validate({
    required ValidationType validationType,
    required String field,
  }) {
    switch (validationType) {
      case ValidationType.apiKey:
        if (field.trim().isEmpty) {
          return ValidationError.empty;
        }
    }

    return null;
  }
}
