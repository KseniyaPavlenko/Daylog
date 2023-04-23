class EnvConfig {
  static const localBaseUrl = 'http://localhost:80/api/v1';
  static const debugBaseUrl = 'http://localhost:8082/api/v1';
  static const prodBaseUrl = 'https://app.onedaylog.org/api/v1';
  static const herokuBaseUrl = 'https://daylog-dev.abexam.org/api/v1';
  static const testCloud = 'https://daylog-dev.abexam.org/api/v1';

  final String baseUrl;

  EnvConfig({required this.baseUrl});

  factory EnvConfig.local() {
    return EnvConfig(baseUrl: localBaseUrl);
  }

  factory EnvConfig.debug() {
    return EnvConfig(baseUrl: debugBaseUrl);
  }

  factory EnvConfig.prod() {
    return EnvConfig(baseUrl: prodBaseUrl);
  }

  factory EnvConfig.test() {
    return EnvConfig(baseUrl: testCloud);
  }
}
