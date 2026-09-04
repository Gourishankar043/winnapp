import '../entities/visit.dart';
import '../repositories/visit_repository.dart';
class CreateVisit {
  final VisitRepository repository;
  const CreateVisit(this.repository);
  Future<void> call(Visit visit) {
    return repository.createVisit(visit);
  }}