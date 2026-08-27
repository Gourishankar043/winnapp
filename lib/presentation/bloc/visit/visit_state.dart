import '../../../domain/entities/visit.dart';

abstract class VisitState {
  const VisitState();
}

class VisitInitial extends VisitState {
  const VisitInitial();
}

class VisitLoading extends VisitState {
  const VisitLoading();
}

class VisitLoaded extends VisitState {
  final List<Visit> visits;

  const VisitLoaded(this.visits);
}

class VisitEmpty extends VisitState {
  const VisitEmpty();
}

class VisitCreated extends VisitState {
  final Visit visit;

  const VisitCreated(this.visit);
}

class VisitUpdated extends VisitState {
  final Visit visit;

  const VisitUpdated(this.visit);
}

class VisitSynced extends VisitState {
  final Visit visit;

  const VisitSynced(this.visit);
}

class VisitError extends VisitState {
  final String message;

  const VisitError({
    required this.message,
  });
}