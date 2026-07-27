class AppConfig {
  final int minBuildNumber;
  final bool maintenance;
  final String updateUrl;

  AppConfig({
    required this.minBuildNumber,
    required this.maintenance,
    required this.updateUrl,
  });

  factory AppConfig.fromFirestore(Map<String, dynamic> json) {
    return AppConfig(
      minBuildNumber: json['minBuildNumber'],
      maintenance: json['maintenance'],
      updateUrl: json['updateUrl'],
    );
  }
}
