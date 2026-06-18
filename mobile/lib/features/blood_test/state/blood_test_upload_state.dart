import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';
import 'package:mobile/features/blood_test/data/repositories/blood_test_repository.dart';

enum UploadPreviewStep {
  waitingForFile,
  readyToAnalyze,
  analyzing,
  analysisReady,
}

class BloodTestUploadState {
  const BloodTestUploadState({
    required this.step,
    this.fileName,
    this.analysis,
  });

  factory BloodTestUploadState.initial() {
    return const BloodTestUploadState(step: UploadPreviewStep.waitingForFile);
  }

  factory BloodTestUploadState.readyWithMockFile() {
    return const BloodTestUploadState(
      step: UploadPreviewStep.readyToAnalyze,
      fileName: 'blood_panel_june.pdf',
    );
  }

  factory BloodTestUploadState.analyzingMockFile() {
    return const BloodTestUploadState(
      step: UploadPreviewStep.analyzing,
      fileName: 'blood_panel_june.pdf',
    );
  }

  factory BloodTestUploadState.analysisReady() {
    const BloodTestRepository repository = BloodTestRepository();

    return BloodTestUploadState(
      step: UploadPreviewStep.analysisReady,
      fileName: 'blood_panel_june.pdf',
      analysis: repository.previewAnalysis(),
    );
  }

  final UploadPreviewStep step;
  final String? fileName;
  final BloodTestAnalysis? analysis;

  bool get hasFile => fileName != null;
  bool get canAnalyze => step == UploadPreviewStep.readyToAnalyze;
  bool get isAnalyzing => step == UploadPreviewStep.analyzing;
  bool get hasAnalysis => step == UploadPreviewStep.analysisReady;
}
