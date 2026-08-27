import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/route_names.dart';
import '../../core/components/feedback/empty_state.dart';
import '../../core/components/feedback/error_view.dart';
import '../../core/components/feedback/loading_view.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_list.dart';

class VisitListScreen extends StatefulWidget {
  const VisitListScreen({
    super.key,
  });

  @override
  State<VisitListScreen> createState() => _VisitListScreenState();
}

class _VisitListScreenState extends State<VisitListScreen> {
  @override
  void initState() {
    super.initState();

    context.read<VisitBloc>().add(
      const LoadVisits(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visits'),
        actions: [
          IconButton(
            onPressed: () {
              // Search/filter functionality will be added later.
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<VisitBloc, VisitState>(
        builder: (context, state) {
          if (state is VisitLoading) {
            return const LoadingView();
          }

          if (state is VisitEmpty) {
            return EmptyState(
              icon: Icons.assignment_outlined,
              title: 'No visits logged yet',
              message: 'Tap the + button to record your first site visit.',
              actionLabel: 'Add visit',
              onAction: _openCreateVisit,
            );
          }

          if (state is VisitError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<VisitBloc>().add(
                  const LoadVisits(),
                );
              },
            );
          }

          if (state is VisitLoaded) {
            return VisitList(
              visits: state.visits,
              onVisitTap: (visit) {
                Navigator.pushNamed(
                  context,
                  RouteNames.visitDetails,
                  arguments: visit,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateVisit,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openCreateVisit() {
    Navigator.pushNamed(
      context,
      RouteNames.createVisit,
    ).then((_) {
      if (!mounted) {
        return;
      }

      context.read<VisitBloc>().add(
        const LoadVisits(),
      );
    });
  }
}