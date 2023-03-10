class EnvConfig {
  static const localBaseUrl = 'http://localost:80/api/v1';
  static const prodBaseUrl = 'https://app.onedaylog.org/api/v1';
  static const herokuBaseUrl = 'https://daylog-dev.abexam.org/api/v1';
  static const testCloud = 'https://daylog-dev.abexam.org/api/v1';

  final String baseUrl;

  EnvConfig({required this.baseUrl});

  factory EnvConfig.local() {
    return EnvConfig(baseUrl: localBaseUrl);
  }

  factory EnvConfig.prod() {
    return EnvConfig(baseUrl: prodBaseUrl);
  }

  factory EnvConfig.test() {
    return EnvConfig(baseUrl: testCloud);
  }
}
