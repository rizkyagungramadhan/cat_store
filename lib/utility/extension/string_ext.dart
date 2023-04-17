extension StringExt on String? {
  static const _nil = 'null';

  String get asTitleCase {
    if (this?.isNotNullOrEmpty ?? false) {
      return this
              ?.trim()
              .split(' ')
              .map((word) => word[0].toUpperCase() + word.substring(1))
              .join(' ') ??
          this!;
    }
    return orDash();
  }

  bool get isNotNullOrEmpty => this != _nil ? (this ?? '').isNotEmpty : false;

  bool get isNullOrEmpty => this != _nil ? (this ?? '').isEmpty : true;

  String orDash() => isNullOrEmpty ? '-' : this!;

  String? validateField({
    required String fieldName,
    int minLength = 0,
  }) {
    ///If text was null or empty
    if (this == _nil || (this?.length ?? 0) == 0) {
      return '$fieldName cannot be empty';
    }

    ///If text length is not enough from length required
    if ((this?.length ?? 0) >= minLength) {
      return null;
    } else {
      return '$fieldName need at least $minLength characters';
    }
  }
}
