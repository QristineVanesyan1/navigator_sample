class Info {
  const Info({required this.version, required this.newsSites});
  factory Info.fromJson(Map<String, dynamic> map) {
    return Info(
        version: map['version'],
        newsSites: List<String>.from(map['newsSites']));
  }
  final String version;
  final List<String> newsSites;
}
