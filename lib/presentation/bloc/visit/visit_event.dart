import '../../../domain/entities/visit.dart';

abstract class VisitEvent {
  const VisitEvent();
}

class LoadVisits extends VisitEvent {
  const LoadVisits();
}

class CreateVisitRequested extends VisitEvent {
  final Visit visit;

  const CreateVisitRequested(this.visit);
}

class UpdateVisitRequested extends VisitEvent {
  final Visit visit;

  const UpdateVisitRequested(this.visit);
}

class SyncVisitRequested extends VisitEvent {
  final Visit visit;

  const SyncVisitRequested(this.visit);
}

class SearchVisitsRequested extends VisitEvent {
  final String query;

  const SearchVisitsRequested(this.query);
}