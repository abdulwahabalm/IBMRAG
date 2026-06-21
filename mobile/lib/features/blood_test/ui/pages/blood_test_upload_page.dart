import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/core/theme/theme_extensions.dart';
import 'package:mobile/core/widgets/app_buttons.dart';
import 'package:mobile/core/widgets/app_surface.dart';
import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';
import 'package:mobile/features/blood_test/data/repositories/blood_test_repository.dart';

class BloodTestUploadPage extends StatefulWidget {
  const BloodTestUploadPage({super.key});

  @override
  State<BloodTestUploadPage> createState() => _BloodTestUploadPageState();
}

class _BloodTestUploadPageState extends State<BloodTestUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _haemoglobinController = TextEditingController();
  final _whiteBloodCellsController = TextEditingController();
  final _ferritinController = TextEditingController();
  final _crpController = TextEditingController();
  
  bool _isLoading = false;
  BloodTestAnalysis? _analysis;
  String? _errorMessage;

  @override
  void dispose() {
    _haemoglobinController.dispose();
    _whiteBloodCellsController.dispose();
    _ferritinController.dispose();
    _crpController.dispose();
    super.dispose();
  }

  Future<void> _analyzeBloodTest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _analysis = null;
    });

    try {
      final repository = const BloodTestRepository();
      final markers = {
        'haemoglobin': double.parse(_haemoglobinController.text),
        'whiteBloodCells': double.parse(_whiteBloodCellsController.text),
        'ferritin': double.parse(_ferritinController.text),
        'crp': double.parse(_crpController.text),
      };

      final analysis = await repository.analyzeBloodTest(markers);

      setState(() {
        _analysis = analysis;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to analyze blood test: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _reset() {
    setState(() {
      _haemoglobinController.clear();
      _whiteBloodCellsController.clear();
      _ferritinController.clear();
      _crpController.clear();
      _analysis = null;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    context.spacing.xl,
                    context.spacing.xl,
                    context.spacing.xl,
                    context.spacing.lg,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ionicons.pulse_outline,
                              color: context.colours.primary,
                              size: 28,
                            ),
                            SizedBox(width: context.spacing.sm),
                            Text(
                              'BloodLens',
                              style: context.textTheme.titleLarge,
                            ),
                            const Spacer(),
                            if (_analysis != null)
                              GestureDetector(
                                onTap: _reset,
                                behavior: HitTestBehavior.opaque,
                                child: Icon(
                                  Ionicons.refresh,
                                  color: context.colours.textMuted,
                                  size: 22,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: context.spacing.xxl),
                        Text(
                          'Blood Test Analysis',
                          style: context.textTheme.displayMedium,
                        ),
                        SizedBox(height: context.spacing.md),
                        Text(
                          'Enter your blood test markers to get AI-powered analysis and recommendations.',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colours.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.xl,
                  ),
                  sliver: SliverList.list(
                    children: [
                      if (_analysis == null) ...[
                        AppSurface(
                          child: Padding(
                            padding: EdgeInsets.all(context.spacing.lg),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Blood Test Markers',
                                    style: context.textTheme.titleMedium,
                                  ),
                                  SizedBox(height: context.spacing.lg),
                                  _buildTextField(
                                    controller: _haemoglobinController,
                                    label: 'Haemoglobin (g/dL)',
                                    hint: 'e.g., 14.1',
                                    icon: Ionicons.water_outline,
                                  ),
                                  SizedBox(height: context.spacing.md),
                                  _buildTextField(
                                    controller: _whiteBloodCellsController,
                                    label: 'White Blood Cells (× 10⁹/L)',
                                    hint: 'e.g., 7.5',
                                    icon: Ionicons.shield_outline,
                                  ),
                                  SizedBox(height: context.spacing.md),
                                  _buildTextField(
                                    controller: _ferritinController,
                                    label: 'Ferritin (ng/mL)',
                                    hint: 'e.g., 85',
                                    icon: Ionicons.magnet_outline,
                                  ),
                                  SizedBox(height: context.spacing.md),
                                  _buildTextField(
                                    controller: _crpController,
                                    label: 'C-Reactive Protein (mg/L)',
                                    hint: 'e.g., 2.5',
                                    icon: Ionicons.flame_outline,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.spacing.lg),
                        PrimaryActionButton(
                          label: _isLoading ? 'Analyzing...' : 'Analyze Blood Test',
                          icon: Ionicons.sparkles,
                          isLoading: _isLoading,
                          onPressed: _isLoading ? null : _analyzeBloodTest,
                        ),
                        if (_errorMessage != null) ...[
                          SizedBox(height: context.spacing.lg),
                          AppSurface(
                            child: Padding(
                              padding: EdgeInsets.all(context.spacing.lg),
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.warning_outline,
                                    color: context.colours.error,
                                    size: 20,
                                  ),
                                  SizedBox(width: context.spacing.sm),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        color: context.colours.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                      if (_analysis != null) ...[
                        // Disclaimer
                        AppSurface(
                          child: Padding(
                            padding: EdgeInsets.all(context.spacing.lg),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Ionicons.information_circle_outline,
                                  color: context.colours.primary,
                                  size: 24,
                                ),
                                SizedBox(width: context.spacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Important Disclaimer',
                                        style: context.textTheme.titleSmall?.copyWith(
                                          color: context.colours.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: context.spacing.xs),
                                      Text(
                                        _analysis!.disclaimer ?? 'This analysis is for informational purposes only.',
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: context.spacing.lg),
                        // Summary
                        AppSurface(
                          child: Padding(
                            padding: EdgeInsets.all(context.spacing.lg),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.document_text_outline,
                                      color: context.colours.primary,
                                      size: 20,
                                    ),
                                    SizedBox(width: context.spacing.sm),
                                    Text(
                                      'Summary',
                                      style: context.textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(height: context.spacing.md),
                                Text(
                                  _analysis!.summary,
                                  style: context.textTheme.bodyMedium,
                                ),
                                if (_analysis!.auditId != null) ...[
                                  SizedBox(height: context.spacing.md),
                                  Text(
                                    'Audit ID: ${_analysis!.auditId}',
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: context.colours.textMuted,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: context.spacing.lg),
                        // Safety Warnings
                        if (_analysis!.safetyWarnings != null &&
                            _analysis!.safetyWarnings!.isNotEmpty) ...[
                          AppSurface(
                            child: Padding(
                              padding: EdgeInsets.all(context.spacing.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Ionicons.warning_outline,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                      SizedBox(width: context.spacing.sm),
                                      Text(
                                        'Safety Warnings',
                                        style: context.textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.spacing.md),
                                  ..._analysis!.safetyWarnings!.map(
                                    (warning) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: context.spacing.sm,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('• ', style: context.textTheme.bodyMedium),
                                          Expanded(
                                            child: Text(
                                              warning,
                                              style: context.textTheme.bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.spacing.lg),
                        ],
                        // Markers
                        Text(
                          'Marker Analysis',
                          style: context.textTheme.titleMedium,
                        ),
                        SizedBox(height: context.spacing.md),
                        ..._analysis!.markers.map(
                          (marker) => Padding(
                            padding: EdgeInsets.only(bottom: context.spacing.md),
                            child: _buildMarkerCard(context, marker),
                          ),
                        ),
                      ],
                      SizedBox(height: context.spacing.xl),
                      Text(
                        'Not medical advice. Share important findings with a qualified clinician.',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colours.textMuted,
                        ),
                      ),
                      SizedBox(height: context.spacing.xxl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildMarkerCard(BuildContext context, BloodMarker marker) {
    Color statusColor;
    IconData statusIcon;
    
    switch (marker.status) {
      case MarkerStatus.optimal:
        statusColor = Colors.green;
        statusIcon = Ionicons.checkmark_circle;
        break;
      case MarkerStatus.attention:
        statusColor = Colors.orange;
        statusIcon = Ionicons.warning;
        break;
      case MarkerStatus.improving:
        statusColor = Colors.blue;
        statusIcon = Ionicons.trending_up;
        break;
    }

    return AppSurface(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 20),
                SizedBox(width: context.spacing.sm),
                Expanded(
                  child: Text(
                    marker.name,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.sm,
                    vertical: context.spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    marker.value,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.spacing.xs),
            Text(
              'Reference Range: ${marker.range}',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colours.textMuted,
              ),
            ),
            if (marker.explanation != null) ...[
              SizedBox(height: context.spacing.md),
              Text(
                marker.explanation!,
                style: context.textTheme.bodyMedium,
              ),
            ],
            if (marker.suggestedFollowUp != null) ...[
              SizedBox(height: context.spacing.md),
              Container(
                padding: EdgeInsets.all(context.spacing.sm),
                decoration: BoxDecoration(
                  color: context.colours.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Ionicons.bulb_outline,
                      size: 16,
                      color: context.colours.primary,
                    ),
                    SizedBox(width: context.spacing.xs),
                    Expanded(
                      child: Text(
                        marker.suggestedFollowUp!,
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (marker.retrievedEvidence != null) ...[
              SizedBox(height: context.spacing.md),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'Evidence',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: context.spacing.sm),
                    child: Text(
                      marker.retrievedEvidence!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colours.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Made with Bob
