import 'package:talker_flutter/talker_flutter.dart';

final talker = Talker();

void logInfo(String label, String message) {
  talker.info(_beatifyMessage(label, message));
}

void logSuccess(String label, String message) {
  talker.verbose(_beatifyMessage(label, message));
}

void logWarning(String label, String message) {
  talker.warning(_beatifyMessage(label, message));
}

void logError(String label, Object error, {StackTrace? st}) {
  talker.error(label, error, st);
}

void logCustom(String label, String message) {
  talker.logTyped(
    _CustomLog(message, title: label),
  );
}

String _beatifyMessage(String label, String message) => '[${label.toUpperCase()}]: $message';

class _CustomLog extends TalkerLog {
  _CustomLog(super.message, {super.title});

  @override
  AnsiPen get pen => AnsiPen()..xterm(95);
}
