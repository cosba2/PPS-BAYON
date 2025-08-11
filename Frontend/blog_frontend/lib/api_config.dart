import 'dart:html' as html;

class ApiConfig {
  // Lee la variable API_BASE_URL desde window.env
  static String get baseUrl {
    final env = html.window as dynamic;
    return env.env != null && env.env['API_BASE_URL'] != null
        ? env.env['API_BASE_URL'] as String
        : 'https://default-url.com/api'; // Valor por defecto
  }

  static String get apiKey {
    final env = html.window as dynamic;
    return env.env != null && env.env['API_KEY'] != null
        ? env.env['API_KEY'] as String
        : 'default-key';
  }
}
