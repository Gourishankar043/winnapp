import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/visit.dart';
import '../../../domain/usecases/create_visit.dart';
import '../../../domain/usecases/get_visits.dart';
import '../../../domain/usecases/search_visits.dart';
import '../../../domain/usecases/sync_visits.dart';
import '../../../domain/usecases/update_visit.dart';
import 'visit_event.dart';
import 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final GetVisits getVisits;
  final CreateVisit createVisit;
  final UpdateVisit updateVisit;
  final SyncVisits syncVisits;
  final SearchVisits searchVisits;

  List<Visit> _allVisits = [];

  List<Visit> get allVisits =>
      List.unmodifiable(_allVisits);

  VisitBloc({
    required this.getVisits,
    required this.createVisit,
    required this.updateVisit,
    required this.syncVisits,
    required this.searchVisits,
  }) : super(const VisitInitial()) {
    on<LoadVisits>(_onLoadVisits);
    on<CreateVisitRequested>(_onCreateVisit);
    on<UpdateVisitRequested>(_onUpdateVisit);
    on<SyncVisitRequested>(_onSyncVisit);
    on<SearchVisitsRequested>(_onSearchVisits);
  }

  Future<void> _onLoadVisits(
      LoadVisits event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitLoading());

    try {
      final visits = await getVisits();

      _allVisits = visits;

      if (visits.isEmpty) {
        emit(const VisitEmpty());
        return;
      }

      emit(VisitLoaded(visits));
    } catch (e) {
      emit(
        VisitError(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCreateVisit(
      CreateVisitRequested event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitLoading());

    try {
      await createVisit(event.visit);

      final visits = await getVisits();

      _allVisits = visits;

      emit(
        VisitCreated(event.visit),
      );
    } catch (e) {
      emit(
        VisitError(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateVisit(
      UpdateVisitRequested event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitLoading());

    try {
      final updatedVisit =
      await updateVisit(event.visit);

      final visits = await getVisits();

      _allVisits = visits;

      emit(
        VisitUpdated(updatedVisit),
      );
    } catch (e) {
      emit(
        VisitError(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSyncVisit(
      SyncVisitRequested event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitLoading());

    try {
      final syncedVisit =
      await syncVisits(event.visit);

      final visits = await getVisits();

      _allVisits = visits;

      emit(
        VisitSynced(syncedVisit),
      );
    } on OfflineSyncException {
      emit(
        VisitSyncOffline(event.visit),
      );
    } catch (e) {
      emit(
        VisitError(
          message: e.toString(),
        ),
      );
    }
  }

  void _onSearchVisits(
      SearchVisitsRequested event,
      Emitter<VisitState> emit,
      ) {
    final filteredVisits = searchVisits(
      _allVisits,
      event.query,
    );

    if (filteredVisits.isEmpty) {
      emit(const VisitEmpty());
      return;
    }

    emit(
      VisitLoaded(filteredVisits),
    );
  }
}