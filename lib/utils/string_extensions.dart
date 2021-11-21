extension StringExtensions on String {
  capitalized() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
