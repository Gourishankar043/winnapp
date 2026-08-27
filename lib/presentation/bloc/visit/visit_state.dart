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

class VisitError extends VisitState {
  final String message;

  const VisitError({
    required this.message,
  });
}