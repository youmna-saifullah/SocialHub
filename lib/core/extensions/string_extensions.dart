/// Extension methods on String for common operations
extension StringExtensions on String {
  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
  
  /// Check if string is a valid phone number
  bool get isValidPhone {
    return RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(this);
  }
  
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  /// Capitalize each word
  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }
  
  /// Get initials from name
  String get initials {
    final words = trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[words.length - 1][0]}'.toUpperCase();
  }
  
  /// Truncate string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
  
  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');
  
  /// Check if string is null or empty
  bool get isNullOrEmpty => isEmpty;
  
  /// Check if string is not null or empty
  bool get isNotNullOrEmpty => isNotEmpty;
}

/// Extension on nullable String
extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
