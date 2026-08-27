import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_spacing.dart';
import '../../domain/entities/visit.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';

class UpdateVisitScreen extends StatefulWidget {
  const UpdateVisitScreen({
    super.key,
  });

  @override
  State<UpdateVisitScreen> createState() => _UpdateVisitScreenState();
}

class _UpdateVisitScreenState extends State<UpdateVisitScreen> {
  Visit? _visit;
  bool _initialized = false;
  bool _submitted = false;

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
        if (!_submitted) {
          return;
        }

        if (state is VisitLoaded) {
          final updatedVisit = _findVisit(
            state.visits,
            visit.id,
          );

          if (updatedVisit != null) {
            Navigator.pop(
              context,
              updatedVisit,
            );
          }
        }

        if (state is VisitError) {
          _submitted = false;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is VisitLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit visit'),
            leading: IconButton(
              onPressed: isLoading
                  ? null
                  : () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: VisitForm(
                submitLabel: 'Save changes',
                initialSiteName: visit.siteName,
                initialDate: visit.date,
                initialLocation: visit.location,
                initialNotes: visit.notes,
                isLoading: isLoading,
                onSubmit: _updateVisit,
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateVisit(VisitFormData formData) {
    final currentVisit = _visit;

    if (currentVisit == null) {
      return;
    }

    final updatedVisit = Visit(
      id: currentVisit.id,
      siteName: formData.siteName,
      date: formData.date,
      location: formData.location,
      notes: formData.notes,
      createdAt: currentVisit.createdAt,
      stage: currentVisit.stage,
      syncedAt: currentVisit.syncedAt,
    );

    _submitted = true;

    context.read<VisitBloc>().add(
      UpdateVisitRequested(updatedVisit),
    );
  }

  Visit? _findVisit(
      List<Visit> visits,
      String id,
      ) {
    for (final visit in visits) {
      if (visit.id == id) {
        return visit;
      }
    }

    return null;
  }
}