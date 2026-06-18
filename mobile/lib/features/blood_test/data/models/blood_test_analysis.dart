import 'package:flutter/material.dart';

enum MarkerStatus { optimal, attention, improving }

class BloodMarker {
  const BloodMarker({
    required this.name,
    required this.value,
    required this.range,
    required this.status,
  });

  final String name;
  final String value;
  final String range;
  final MarkerStatus status;
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
  });

  final String summary;
  final String confidence;
  final List<BloodMarker> markers;
  final List<Recommendation> recommendations;
}
