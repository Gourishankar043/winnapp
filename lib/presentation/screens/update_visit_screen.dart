import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/navigation/app_scaffold.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/visit.dart';
import '../../l10n/app_localizations.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_form.dart';
class UpdateVisitScreen extends StatefulWidget {
  final ValueChanged<Locale> onLocaleChanged;
  const UpdateVisitScreen({
    super.key,
    required this.onLocaleChanged,
  });
  @override
  State<UpdateVisitScreen> createState() =>
      _UpdateVisitScreenState();
}
class _UpdateVisitScreenState
    extends State<UpdateVisitScreen> {
  late final Visit _originalVisit;
  bool _hasVisit = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments;
        if (arguments is Visit) {
          setState(() {
            _originalVisit = arguments;
            _hasVisit = true;
          });
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;
    if (!_hasVisit) {
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
      listener: _onStateChanged,
      builder: (context, state) {
        final isLoading =
        state is VisitLoading;
        return AppScaffold(
          onLocaleChanged:
          widget.onLocaleChanged,
          appBar: AppBar(
            title: Text(l10n.editVisit),
            leading: IconButton(
              tooltip: l10n.cancel,
              onPressed: isLoading
                  ? null
                  : () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              child: VisitForm(
                submitLabel:
                l10n.saveChanges,
                initialSiteName:
                _originalVisit.siteName,
                initialDate:
                _originalVisit.date,
                initialLocation:
                _originalVisit.location,
                initialNotes:
                _originalVisit.notes,
                isLoading: isLoading,
                onSubmit: _submitUpdate,
              ),
            ),
          ),
        );
      },
    );
  }
  void _onStateChanged(
      BuildContext context,
      VisitState state,
      ) {
    if (state is VisitUpdated) {
      if (!mounted) {
        return;
      }
      if (state.visit.id !=
          _originalVisit.id) {
        return;
      }
      Navigator.pop(
        context,
        state.visit,
      );
      return;
    }
    if (state is VisitError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.message,
            ),
          ),
        );
    }
  }
  void _submitUpdate(
      VisitFormData formData,
      ) {
    final updatedVisit = Visit(
      id: _originalVisit.id,
      siteName: formData.siteName,
      date: formData.date,
      location: formData.location,
      notes: formData.notes,
      createdAt: _originalVisit.createdAt,
      stage: _originalVisit.stage,
      syncedAt: _originalVisit.syncedAt,
    );
    context.read<VisitBloc>().add(
      UpdateVisitRequested(
        updatedVisit,
      ),
    );
  }
}