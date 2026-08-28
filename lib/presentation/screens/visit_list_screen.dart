import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/route_names.dart';
import '../../core/components/feedback/empty_state.dart';
import '../../core/components/feedback/error_view.dart';
import '../../core/components/feedback/loading_view.dart';
import '../../core/components/navigation/app_scaffold.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/visit.dart';
import '../../l10n/app_localizations.dart';
import '../bloc/visit/visit_bloc.dart';
import '../bloc/visit/visit_event.dart';
import '../bloc/visit/visit_state.dart';
import '../widgets/visit_list.dart';

class VisitListScreen extends StatefulWidget {
  final ValueChanged<Locale> onLocaleChanged;

  const VisitListScreen({
    super.key,
    required this.onLocaleChanged,
  });

  @override
  State<VisitListScreen> createState() => _VisitListScreenState();
}

class _VisitListScreenState extends State<VisitListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      context.read<VisitBloc>().add(
        const LoadVisits(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      onLocaleChanged: widget.onLocaleChanged,
      appBar: AppBar(
        title: Text(l10n.visits),
        actions: [
          IconButton(
            tooltip: l10n.searchVisits,
            onPressed: _openSearch,
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
              title: l10n.noVisitsLogged,
              message: l10n.addFirstVisit,
              actionLabel: l10n.addVisit,
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
              onVisitTap: _openVisitDetails,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.addVisit,
        onPressed: _openCreateVisit,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openSearch() async {
    final visits = context.read<VisitBloc>().allVisits;

    final query = await showSearch<String>(
      context: context,
      delegate: VisitSearchDelegate(
        visits: visits,
        l10n: AppLocalizations.of(context)!,
      ),
    );

    if (!mounted || query == null) {
      return;
    }

    if (query.isEmpty) {
      context.read<VisitBloc>().add(
        const LoadVisits(),
      );
      return;
    }

    context.read<VisitBloc>().add(
      SearchVisitsRequested(query),
    );
  }

  Future<void> _openVisitDetails(Visit visit) async {
    await Navigator.pushNamed(
      context,
      RouteNames.visitDetails,
      arguments: visit,
    );

    if (!mounted) {
      return;
    }

    context.read<VisitBloc>().add(
      const LoadVisits(),
    );
  }

  Future<void> _openCreateVisit() async {
    await Navigator.pushNamed(
      context,
      RouteNames.createVisit,
    );

    if (!mounted) {
      return;
    }

    context.read<VisitBloc>().add(
      const LoadVisits(),
    );
  }
}

class VisitSearchDelegate extends SearchDelegate<String> {
  final List<Visit> visits;
  final AppLocalizations l10n;

  VisitSearchDelegate({
    required this.visits,
    required this.l10n,
  });

  @override
  String get searchFieldLabel => l10n.searchVisits;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          tooltip: l10n.cancel,
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: l10n.cancel,
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResults(context);
  }

  Widget _buildResults(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();

    final results = visits.where((visit) {
      if (normalizedQuery.isEmpty) {
        return true;
      }

      return visit.siteName.toLowerCase().contains(
        normalizedQuery,
      ) ||
          visit.location.toLowerCase().contains(
            normalizedQuery,
          ) ||
          visit.notes.toLowerCase().contains(
            normalizedQuery,
          );
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(l10n.noVisitsMatch),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, _) => const Divider(
        height: 1,
      ),
      itemBuilder: (context, index) {
        final visit = results[index];

        return ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
          ),
          title: Text(visit.siteName),
          subtitle: Text(visit.location),
          onTap: () {
            close(context, query);
          },
        );
      },
    );
  }
}