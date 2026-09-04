import 'package:winnapp/domain/entities/visit.dart';
import 'package:winnapp/domain/repositories/visit_repository.dart';
class UpdateVisit {
  final VisitRepository repository;
  const UpdateVisit(this.repository);
  Future<Visit> call(Visit visit) {
    return repository.updateVisit(visit);
  }
}