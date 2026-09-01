import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/route_names.dart';
import '../../core/components/cards/app_card.dart';
import '../../core/components/chips/status_chip.dart';
import '../../core/components/navigation/app_scaffold.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/visit.dart';
import '../../l10n/app_localizations.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';

class VisitDetailsScreen extends StatefulWidget {
  final ValueChanged<Locale> onLocaleChanged;

  const VisitDetailsScreen({
    super.key,
    required this.onLocaleChanged,
  });

  @override
  State<VisitDetailsScreen> createState() =>
      _VisitDetailsScreenState();
}

class _VisitDetailsScreenState
    extends State<VisitDetailsScreen> {
  Visit? _visit;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) {
      return;
    }

    final arguments =
        ModalRoute.of(context)?.settings.arguments;

    if (arguments is Visit) {
      _visit = arguments;
    }

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    final visit = _visit;

    if (visit == null) {
      return AppScaffold(
        onLocaleChanged:
        widget.onLocaleChanged,
        body: Center(
          child: Text(
            l10n.visitNotFound,
          ),
        ),
      );
    }

    return BlocConsumer<VisitBloc, VisitState>(
      listener: _handleState,
      builder: (context, state) {
        final currentVisit = _visit!;

        return AppScaffold(
          onLocaleChanged:
          widget.onLocaleChanged,
          appBar: AppBar(
            title: Text(l10n.detail),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    currentVisit.siteName,
                    style:
                    AppTextStyles.titleMedium,
                  ),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  StatusChip(
                    stage: currentVisit.stage,
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  _DetailRow(
                    label: l10n.date,
                    value: _formatDate(
                      currentVisit.date,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  _DetailRow(
                    label: l10n.location,
                    value: currentVisit.location,
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  _DetailRow(
                    label: l10n.loggedBy,
                    value:
                    '${l10n.appTitle} · '
                        '${_formatCreatedAt(currentVisit.createdAt)}',
                  ),
                  const SizedBox(
                    height: AppSpacing.lg,
                  ),
                  AppCard(
                    padding: const EdgeInsets.all(
                      AppSpacing.md,
                    ),
                    child: Text(
                      currentVisit.notes,
                      style:
                      AppTextStyles.bodyMedium,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar:
          _buildBottomActions(
            context,
            currentVisit,
            state is VisitLoading,
            l10n,
          ),
        );
      },
    );
  }

  void _handleState(
      BuildContext context,
      VisitState state,
      ) {
    if (state is VisitUpdated) {
      if (state.visit.id == _visit?.id) {
        setState(() {
          _visit = state.visit;
        });
      }

      return;
    }

    if (state is VisitSynced) {
      if (state.visit.id != _visit?.id) {
        return;
      }

      setState(() {
        _visit = state.visit;
      });

      final l10n =
      AppLocalizations.of(context)!;

      final message =
      state.visit.stage == VisitStage.synced
          ? l10n.syncSuccess
          : l10n.syncFailed;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );

      return;
    }

    if (state is VisitSyncOffline) {
      if (state.visit.id != _visit?.id) {
        return;
      }

      setState(() {
        _visit = state.visit;
      });

      final l10n =
      AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.syncOffline,
            ),
          ),
        );

      return;
    }

    if (state is VisitError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
    }
  }

  Widget? _buildBottomActions(
      BuildContext context,
      Visit visit,
      bool isSaving,
      AppLocalizations l10n,
      ) {
    if (visit.stage == VisitStage.synced) {
      return null;
    }

    final isFailed =
        visit.stage == VisitStage.failed;

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
                  await Navigator
                      .pushNamed<Visit>(
                    context,
                    RouteNames.updateVisit,
                    arguments: visit,
                  );

                  if (!mounted ||
                      updatedVisit == null) {
                    return;
                  }

                  setState(() {
                    _visit = updatedVisit;
                  });
                },
                style:
                OutlinedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions
                        .buttonHeight,
                  ),
                ),
                child: Text(l10n.edit),
              ),
            ),
            const SizedBox(
              width: AppSpacing.sm,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () {
                  _syncVisit(context);
                },
                style:
                ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions
                        .buttonHeight,
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                  width: AppDimensions
                      .iconSmall,
                  height: AppDimensions
                      .iconSmall,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  isFailed
                      ? l10n.retry
                      : l10n.save,
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
    return '${_monthName(date.month)} '
        '${date.day}, ${date.year}';
  }

  String _formatCreatedAt(DateTime date) {
    final difference =
    DateTime.now().difference(date);

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
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.labelSmall,
          ),
        ),
        const SizedBox(
          width: AppSpacing.md,
        ),
        Flexible(
          flex: 5,
          child: Text(
            value,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }
}