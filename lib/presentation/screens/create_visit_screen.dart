import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../core/components/navigation/app_scaffold.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/visit.dart';
import '../../l10n/app_localizations.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';
class CreateVisitScreen extends StatefulWidget {
  final ValueChanged<Locale> onLocaleChanged;
  const CreateVisitScreen({
    super.key,
    required this.onLocaleChanged,
  });
  @override
  State<CreateVisitScreen> createState() => _CreateVisitScreenState();
}
class _CreateVisitScreenState extends State<CreateVisitScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppScaffold(
      onLocaleChanged: widget.onLocaleChanged,
      appBar: AppBar(
        title: Text(l10n.newVisit),
        leading: IconButton(
          tooltip: l10n.cancel,
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: BlocConsumer<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitCreated) {
            Navigator.pop(context, state.visit);
            return;
          }
          if (state is VisitError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: VisitForm(
              submitLabel: l10n.saveVisit,
              isLoading: state is VisitLoading,
              onSubmit: _createVisit,
            ),
          );
        },
      ),
    );
  }
  void _createVisit(VisitFormData formData) {
    final now = DateTime.now();
    final visit = Visit(
      id: const Uuid().v4(),
      siteName: formData.siteName,
      date: formData.date,
      location: formData.location,
      notes: formData.notes,
      createdAt: now,
      stage: VisitStage.draft,
    );
    context.read<VisitBloc>().add(CreateVisitRequested(visit));
  }
}