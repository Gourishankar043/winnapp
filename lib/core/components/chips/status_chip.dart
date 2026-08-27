import 'package:flutter/material.dart';
import 'package:winnapp/core/theme/app_dimensions.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

enum StatusType{
  draft,
  pending,
  done,
}

class StatusChip extends StatelessWidget{
  final StatusType status;
  const StatusChip({
    super.key,
    required this.status,
});
  String get label{
    switch(status){
      case StatusType.draft:
        return 'Draft';
      case StatusType.pending:
        return 'Pending';
      case StatusType.done:
        return 'done';
    }
  }
  Color get backgroundColor{
    switch (status){
      case StatusType.draft:
        return AppColors.lightMutedText.withValues(alpha:0.12);
      case StatusType.pending:
        return AppColors.warning.withValues(alpha:0.12);
      case StatusType.done:
        return AppColors.success.withValues(alpha: 0.12);
    }
  }
  Color get foregroundColor{
    switch(status){
      case StatusType.draft:
        return AppColors.lightMutedText;
      case StatusType.pending:
        return AppColors.warning;
      case StatusType.done:
        return AppColors.success;
    }
  }
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: foregroundColor,),
      ),
    );
  }
}