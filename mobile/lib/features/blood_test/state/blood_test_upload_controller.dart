import 'package:flutter/foundation.dart';
import 'package:mobile/features/blood_test/state/blood_test_upload_state.dart';

class BloodTestUploadController extends ChangeNotifier {
  BloodTestUploadState _state = BloodTestUploadState.initial();

  BloodTestUploadState get state => _state;

  void pickMockFile() {
    _state = BloodTestUploadState.readyWithMockFile();
    notifyListeners();
  }

  Future<void> analyzeMockFile() async {
    if (!_state.canAnalyze) {
      return;
    }

    _state = BloodTestUploadState.analyzingMockFile();
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 850));

    _state = BloodTestUploadState.analysisReady();
    notifyListeners();
  }

  void reset() {
    _state = BloodTestUploadState.initial();
    notifyListeners();
  }
}
