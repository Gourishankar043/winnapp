import 'package:flutter/material.dart';
import '../../../domain/entities/visit.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_spacing.dart';
class StatusChip extends StatelessWidget {
  final VisitStage stage;
  const StatusChip({super.key, required this.stage});
  String get label {
    switch (stage) {
      case VisitStage.draft:
        return 'Draft';
      case VisitStage.synced:
        return 'Synced';
      case VisitStage.failed:
        return 'Failed';
    }}
  Color get backgroundColor {
    switch (stage) {
      case VisitStage.draft:
        return AppColors.surfaceMuted;
      case VisitStage.synced:
        return AppColors.success.withValues(alpha: 0.12);
      case VisitStage.failed:
        return AppColors.danger.withValues(alpha: 0.12);
    }
  }
  Color get foregroundColor {
    switch (stage) {
      case VisitStage.draft:
        return AppColors.lightMutedText;
      case VisitStage.synced:
        return AppColors.success;
      case VisitStage.failed:
        return AppColors.danger;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: foregroundColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: foregroundColor)),
        ],
      ),
    );
  }
}