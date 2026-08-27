import 'package:flutter/material.dart';

import '../../core/components/cards/app_card.dart';
import '../../core/components/chips/status_chip.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/visit.dart';

class VisitCard extends StatelessWidget {
  final Visit visit;
  final VoidCallback? onTap;

  const VisitCard({
    super.key,
    required this.visit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: AppSpacing.cardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  visit.siteName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusChip(
                stage: visit.stage,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            visit.location,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            visit.notes,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}