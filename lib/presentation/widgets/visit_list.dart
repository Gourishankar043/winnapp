import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../domain/entities/visit.dart';
import 'visit_card.dart';

class VisitList extends StatelessWidget {
  final List<Visit> visits;
  final ValueChanged<Visit>? onVisitTap;

  const VisitList({
    super.key,
    required this.visits,
    this.onVisitTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xxl,
      ),
      itemCount: visits.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final visit = visits[index];

        return VisitCard(
          visit: visit,
          onTap: onVisitTap == null
              ? null
              : () => onVisitTap!(visit),
        );
      },
    );
  }
}