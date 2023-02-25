class EnvConfig {
  static const localBaseUrl = 'http://localost:8087/api/v1';
  static const prodBaseUrl = 'https://app.onedaylog.org/api/v1';
  static const herokuBaseUrl = 'https://daylog-dev.abexam.org/api/v1';

  final String baseUrl;

  EnvConfig({required this.baseUrl});

  factory EnvConfig.local() {
    return EnvConfig(baseUrl: localBaseUrl);
  }

  factory EnvConfig.prod() {
    return EnvConfig(baseUrl: prodBaseUrl);
  }

  factory EnvConfig.heroku() {
    return EnvConfig(baseUrl: herokuBaseUrl);
  }
}
