import 'package:winnapp/domain/entities/visit.dart';
import 'package:winnapp/domain/repositories/visit_repository.dart';

class CreateVisit {
  final VisitRepository repository;

  const CreateVisit(this.repository);

  Future<Visit> call(Visit visit) {
    return repository.createVisit(visit);
  }
}