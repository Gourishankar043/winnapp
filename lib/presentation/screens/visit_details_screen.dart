import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/route_names.dart';
import '../../core/components/cards/app_card.dart';
import '../../core/components/chips/status_chip.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/visit.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';

class VisitDetailsScreen extends StatefulWidget {
  const VisitDetailsScreen({
    super.key,
  });

  @override
  State<VisitDetailsScreen> createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {
  Visit? _visit;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) {
      return;
    }

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Visit) {
      _visit = arguments;
    }

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final visit = _visit;

    if (visit == null) {
      return const Scaffold(
        body: Center(
          child: Text('Visit not found'),
        ),
      );
    }

    return BlocConsumer<VisitBloc, VisitState>(
      listener: (context, state) {
        if (state is VisitUpdated) {
          if (state.visit.id == _visit?.id) {
            setState(() {
              _visit = state.visit;
            });
          }
          return;
        }

        if (state is VisitSynced) {
          if (state.visit.id == _visit?.id) {
            setState(() {
              _visit = state.visit;
            });
          }
          return;
        }

        if (state is VisitError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final currentVisit = _visit!;

        final isSaving = state is VisitLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail'),
            leading: IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentVisit.siteName,
                    style: AppTextStyles.titleMedium,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  StatusChip(
                    stage: currentVisit.stage,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  const Divider(),

                  const SizedBox(height: AppSpacing.md),

                  _DetailRow(
                    label: 'Date',
                    value: _formatDate(currentVisit.date),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  _DetailRow(
                    label: 'Location',
                    value: currentVisit.location,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  _DetailRow(
                    label: 'Logged by',
                    value:
                    'You · ${_formatCreatedAt(currentVisit.createdAt)}',
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      currentVisit.notes,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomActions(
            context,
            currentVisit,
            isSaving,
          ),
        );
      },
    );
  }

  Widget? _buildBottomActions(
      BuildContext context,
      Visit visit,
      bool isSaving,
      ) {
    if (visit.stage == VisitStage.synced) {
      return null;
    }

    final isFailed = visit.stage == VisitStage.failed;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                  final updatedVisit =
                  await Navigator.pushNamed<Visit>(
                    context,
                    RouteNames.updateVisit,
                    arguments: visit,
                  );

                  if (!mounted || updatedVisit == null) {
                    return;
                  }

                  setState(() {
                    _visit = updatedVisit;
                  });
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions.buttonHeight,
                  ),
                ),
                child: const Text('Edit'),
              ),
            ),

            const SizedBox(width: AppSpacing.sm),

            Expanded(
              child: ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () {
                  _syncVisit(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions.buttonHeight,
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                  width: AppDimensions.iconSmall,
                  height: AppDimensions.iconSmall,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  isFailed ? 'Retry' : 'Save',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _syncVisit(BuildContext context) {
    final visit = _visit;

    if (visit == null) {
      return;
    }

    context.read<VisitBloc>().add(
      SyncVisitRequested(visit),
    );
  }

  String _formatDate(DateTime date) {
    return '${_monthName(date.month)} ${date.day}, ${date.year}';
  }

  String _formatCreatedAt(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return 'just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    }

    return _formatDate(date);
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.labelSmall,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }
}