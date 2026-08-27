import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../core/theme/app_spacing.dart';
import '../../domain/entities/visit.dart';
import '../../l10n/app_localizations.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';

class CreateVisitScreen extends StatefulWidget {
  const CreateVisitScreen({
    super.key,
  });

  @override
  State<CreateVisitScreen> createState() => _CreateVisitScreenState();
}

class _CreateVisitScreenState extends State<CreateVisitScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newVisit),
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: BlocConsumer<VisitBloc, VisitState>(
        listener: (context, state) {
          if (state is VisitCreated) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
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
          final isLoading = state is VisitLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: VisitForm(
              submitLabel: l10n.saveVisit,
              isLoading: isLoading,
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

    context.read<VisitBloc>().add(
      CreateVisitRequested(visit),
    );
  }
}