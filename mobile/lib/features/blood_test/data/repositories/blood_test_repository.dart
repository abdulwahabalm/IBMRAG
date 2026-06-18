import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';

class BloodTestRepository {
  const BloodTestRepository();

  BloodTestAnalysis previewAnalysis() {
    return const BloodTestAnalysis(
      summary:
          'Most markers are in a healthy range. Vitamin D and ferritin need a closer look in the next review.',
      confidence: 'Draft analysis',
      markers: <BloodMarker>[
        BloodMarker(
          name: 'Hemoglobin',
          value: '14.1 g/dL',
          range: '13.0-17.0',
          status: MarkerStatus.optimal,
        ),
        BloodMarker(
          name: 'Vitamin D',
          value: '24 ng/mL',
          range: '30-100',
          status: MarkerStatus.attention,
        ),
        BloodMarker(
          name: 'Ferritin',
          value: '38 ng/mL',
          range: '40-300',
          status: MarkerStatus.attention,
        ),
        BloodMarker(
          name: 'HDL',
          value: '55 mg/dL',
          range: '40+',
          status: MarkerStatus.improving,
        ),
      ],
      recommendations: <Recommendation>[
        Recommendation(
          title: 'Review supplements',
          detail: 'Discuss vitamin D dosage and iron intake with a clinician.',
          icon: Ionicons.flask_outline,
        ),
        Recommendation(
          title: 'Keep cardio steady',
          detail: 'HDL trend supports maintaining current weekly activity.',
          icon: Ionicons.heart_outline,
        ),
        Recommendation(
          title: 'Retest window',
          detail: 'Plan a follow-up panel after 8-12 weeks of changes.',
          icon: Ionicons.time_outline,
        ),
      ],
    );
  }
}
