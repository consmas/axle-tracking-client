import 'package:flutter/foundation.dart';

class SessionInvalidator extends ChangeNotifier {
  void invalidate() {
    notifyListeners();
  }
}
