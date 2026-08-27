import 'package:winnapp/domain/entities/visit.dart';
import 'package:winnapp/domain/repositories/visit_repository.dart';

class SyncVisits {
  final VisitRepository repository;

  const SyncVisits(this.repository);

  Future<Visit> call(Visit visit) {
    return repository.syncVisit(visit);
  }
}