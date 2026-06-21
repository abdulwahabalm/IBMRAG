import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';

class BloodTestRepository {
  const BloodTestRepository();

  /// Analyze blood test markers using the FastAPI backend
  Future<BloodTestAnalysis> analyzeBloodTest(
    Map<String, double> markers,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/blood-test/analyse'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(markers),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return BloodTestAnalysis.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to analyze blood test: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error connecting to analysis service: $e');
    }
  }

  /// Preview analysis with mock data (for backward compatibility)
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
