class AppEndpoints {
  // TODO: How to test private constructors
  // Is that necessary??
  AppEndpoints._();

  static const String baseUrl = 'https://www.breakingbadapi.com';

  /// Get all characters
  /// Endpoint to retrieve information from all characters.
  static const String allCharacters = '$baseUrl/api/characters';

  /// Get single character
  /// Endpoint to retrieve information from one character by id.
  static const String charactersById = '$baseUrl/api/characters/{{id}}';
}
