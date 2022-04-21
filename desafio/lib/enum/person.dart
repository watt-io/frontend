enum Person { physical, legal }

// ignore: non_constant_identifier_names
Person PersonFrom(String value) {
  for (var item in Person.values) {
    if (value == item.name) {
      return item;
    }
  }

  throw 'Person not found';
}

extension PersonExtension on Person {
  String get name {
    switch (this) {
      case Person.physical:
        return 'Pessoa Física';
      case Person.legal:
        return 'Pessoa Jurídica';

      default:
        throw 'Person not found';
    }
  }
}
