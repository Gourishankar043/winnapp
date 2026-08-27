import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/create_visit.dart';
import '../../../domain/usecases/get_visits.dart';
import '../../../domain/usecases/sync_visits.dart';
import '../../../domain/usecases/update_visit.dart';
import 'visit_event.dart';
import 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final GetVisits getVisits;
  final CreateVisit createVisit;
  final UpdateVisit updateVisit;
  final SyncVisits syncVisits;

  VisitBloc({
    required this.getVisits,
    required this.createVisit,
    required this.updateVisit,
    required this.syncVisits,
  }) : super(const VisitInitial()) {
    on<LoadVisits>(_onLoadVisits);
    on<CreateVisitRequested>(_onCreateVisit);
    on<UpdateVisitRequested>(_onUpdateVisit);
    on<SyncVisitRequested>(_onSyncVisit);
  }

  Future<void> _onLoadVisits(
      LoadVisits event,
      Emitter<VisitState> emit,
      ) async {
    emit(const VisitLoading());

    try {
      final visits = await getVisits();

      if (visits.isEmpty) {
        emit(const VisitEmpty());
        return;
      }

      emit(
        VisitLoaded(visits),
      );
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
      final updatedVisit = await updateVisit(event.visit);

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
      final result = await syncVisits(event.visit);

      emit(
        VisitSynced(result),
      );
    } catch (e) {
      emit(
        VisitError(
          message: e.toString(),
        ),
      );
    }
  }
}