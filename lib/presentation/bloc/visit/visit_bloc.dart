import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winnapp/domain/usecases/create_visit.dart';
import 'package:winnapp/domain/usecases/get_visits.dart';
import 'package:winnapp/domain/usecases/sync_visits.dart';
import 'package:winnapp/domain/usecases/update_visit.dart';
import 'package:winnapp/presentation/bloc/visit/visit_event.dart';
import 'package:winnapp/presentation/bloc/visit/visit_state.dart';

class VisitBloc extends Bloc<VisitEvent,VisitState>{
  final GetVisits getVisits;
  final CreateVisit createVisit;
  final UpdateVisit updateVisit;
  final SyncVisits syncVisits;

  VisitBloc({
    required this.getVisits,
    required this.createVisit,
    required this.updateVisit,
    required this.syncVisits,
}): super(const VisitInitial()){
    on<LoadVisits>(_onLoadVisits);
    on<CreateVisitRequested>(_onCreateVisit);
    on<UpdateVisitRequested>(_onUpdateVisit);
    on<SyncVisitRequested>(_onSyncVisit);
  }
  Future<void>_onLoadVisits(
      LoadVisits event,
      Emitter<VisitState>emit,
      )async{
    emit(const VisitLoading());
    try{
      final visits=await getVisits();
      if(visits.isEmpty){
        emit(const VisitEmpty());
      }else{
        emit(VisitLoaded(visits));
      }
    }catch(error){
      emit(VisitError(error.toString()));
    }
  }

  Future<void>_onCreateVisit(
      CreateVisitRequested event,
      Emitter<VisitState>emit,
      )async{
    emit(const VisitLoading());
    try{
      await createVisit(event.visit);
      final visits=await getVisits();
      if(visits.isEmpty){
        emit(const VisitEmpty());
      }else{
        emit(VisitLoaded(visits));
      }
    }catch(error){
      emit(VisitError(error.toString()));
    }
  }

  Future<void>_onUpdateVisit(
      UpdateVisitRequested event,
      Emitter<VisitState>emit,
      )async{
    emit(const VisitLoading());
    try{
      await updateVisit(event.visit);
      final visits=await getVisits();

      if(visits.isEmpty){
        emit(const VisitEmpty());
      }else{
        emit(VisitLoaded(visits));
      }
    }catch(error){
      emit(VisitError(error.toString()));
    }
  }
  Future<void>_onSyncVisit(
      SyncVisitRequested event,
      Emitter<VisitState>emit,
      )async{
    emit(const VisitLoading());
    try{
      await syncVisits(event.visit);
      final visits=await getVisits();
      if(visits.isEmpty){
        emit(const VisitEmpty());
      }else{
        emit(VisitLoaded(visits));
      }

    }catch(error){
      emit(VisitError(error.toString()));
    }
  }

}