import 'package:logger/logger.dart' as l;

class Logger {
  late final l.Logger _logger;
  Logger() {
    _logger = l.Logger(
      printer: l.PrettyPrinter(
          methodCount: 0, // number of method calls to be displayed
          errorMethodCount:
              8, // number of method calls if stacktrace is provided
          lineLength: 120, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: true // Should each log print contain a timestamp
          ),
    );
  }

  void i(String info) {
    _logger.i(info);
  }

  void d(String message) {
    _logger.d(message);
  }

  void e(String error) {
    _logger.e(error);
  }
}
