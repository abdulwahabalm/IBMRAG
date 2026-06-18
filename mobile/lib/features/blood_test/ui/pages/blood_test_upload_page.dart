import 'package:flutter/material.dart';
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/core/theme/theme_extensions.dart';
import 'package:mobile/core/widgets/app_buttons.dart';
import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';
import 'package:mobile/features/blood_test/state/blood_test_upload_controller.dart';
import 'package:mobile/features/blood_test/state/blood_test_upload_state.dart';
import 'package:mobile/features/blood_test/ui/components/analysis_summary_card.dart';
import 'package:mobile/features/blood_test/ui/components/marker_list.dart';
import 'package:mobile/features/blood_test/ui/components/recommendation_list.dart';
import 'package:mobile/features/blood_test/ui/components/upload_drop_zone.dart';
import 'package:mobile/features/blood_test/ui/components/upload_status_card.dart';

class BloodTestUploadPage extends StatefulWidget {
  const BloodTestUploadPage({super.key});

  @override
  State<BloodTestUploadPage> createState() => _BloodTestUploadPageState();
}

class _BloodTestUploadPageState extends State<BloodTestUploadPage> {
  late final BloodTestUploadController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BloodTestUploadController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: ListenableBuilder(
              listenable: _controller,
              builder: (BuildContext context, Widget? child) {
                final BloodTestUploadState state = _controller.state;
                final BloodTestAnalysis? analysis = state.analysis;
                final String fileName = state.fileName ?? 'PDF, JPG, or PNG';

                return CustomScrollView(
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
                                if (state.hasFile)
                                  GestureDetector(
                                    onTap: _controller.reset,
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
                              'Upload your blood test and get a clear next step.',
                              style: context.textTheme.displayMedium,
                            ),
                            SizedBox(height: context.spacing.md),
                            Text(
                              'Attach a result, run a fake analysis, and preview how backend recommendations will feel in the app.',
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
                          UploadDropZone(
                            title: state.hasFile
                                ? 'File attached'
                                : 'Upload blood test',
                            subtitle: fileName,
                            actionIcon: state.hasFile
                                ? Ionicons.checkmark_circle
                                : Ionicons.add,
                            isActive: state.hasFile,
                            onTap: _controller.pickMockFile,
                          ),
                          SizedBox(height: context.spacing.lg),
                          PrimaryActionButton(
                            label: state.isAnalyzing
                                ? 'Analyzing result'
                                : 'Analyze result',
                            icon: Ionicons.sparkles,
                            isLoading: state.isAnalyzing,
                            onPressed: state.canAnalyze
                                ? _controller.analyzeMockFile
                                : null,
                          ),
                          SizedBox(height: context.spacing.lg),
                          UploadStatusCard(state: state),
                          if (analysis != null) ...[
                            SizedBox(height: context.spacing.xl),
                            AnalysisSummaryCard(analysis: analysis),
                            SizedBox(height: context.spacing.lg),
                            MarkerList(markers: analysis.markers),
                            SizedBox(height: context.spacing.lg),
                            RecommendationList(
                              recommendations: analysis.recommendations,
                            ),
                          ],
                          SizedBox(height: context.spacing.xl),
                          Text(
                            'Not medical advice. Share important findings with a qualified clinician.',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium,
                          ),
                          SizedBox(height: context.spacing.xxl),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
