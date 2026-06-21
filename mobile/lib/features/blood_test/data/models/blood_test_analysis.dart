import 'package:flutter/material.dart';

enum MarkerStatus { optimal, attention, improving }

class BloodMarker {
  const BloodMarker({
    required this.name,
    required this.value,
    required this.range,
    required this.status,
    this.explanation,
    this.retrievedEvidence,
    this.suggestedFollowUp,
  });

  final String name;
  final String value;
  final String range;
  final MarkerStatus status;
  final String? explanation;
  final String? retrievedEvidence;
  final String? suggestedFollowUp;

  factory BloodMarker.fromJson(Map<String, dynamic> json) {
    // Map API status to MarkerStatus enum
    MarkerStatus status;
    switch (json['status'] as String) {
      case 'low':
        status = MarkerStatus.attention;
        break;
      case 'high':
        status = MarkerStatus.attention;
        break;
      case 'normal':
        status = MarkerStatus.optimal;
        break;
      default:
        status = MarkerStatus.optimal;
    }

    return BloodMarker(
      name: json['marker'] as String,
      value: '${json['value']} ${json['unit']}',
      range: json['referenceRange'] as String,
      status: status,
      explanation: json['explanation'] as String?,
      retrievedEvidence: json['retrievedEvidence'] as String?,
      suggestedFollowUp: json['suggestedFollowUp'] as String?,
    );
  }
}

class Recommendation {
  const Recommendation({
    required this.title,
    required this.detail,
    required this.icon,
  });

  final String title;
  final String detail;
  final IconData icon;
}

class BloodTestAnalysis {
  const BloodTestAnalysis({
    required this.summary,
    required this.confidence,
    required this.markers,
    required this.recommendations,
    this.auditId,
    this.disclaimer,
    this.safetyWarnings,
  });

  final String summary;
  final String confidence;
  final List<BloodMarker> markers;
  final List<Recommendation> recommendations;
  final String? auditId;
  final String? disclaimer;
  final List<String>? safetyWarnings;

  factory BloodTestAnalysis.fromJson(Map<String, dynamic> json) {
    final markersList = (json['markers'] as List<dynamic>)
        .map((m) => BloodMarker.fromJson(m as Map<String, dynamic>))
        .toList();

    return BloodTestAnalysis(
      summary: json['summary'] as String,
      confidence: json['auditId'] as String? ?? 'Analysis complete',
      markers: markersList,
      recommendations: [], // Will be generated from follow-ups
      auditId: json['auditId'] as String?,
      disclaimer: json['disclaimer'] as String?,
      safetyWarnings: (json['safetyWarnings'] as List<dynamic>?)
          ?.map((w) => w as String)
          .toList(),
    );
  }
}
