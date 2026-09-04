import 'package:winnapp/domain/entities/visit.dart';
import 'package:winnapp/domain/repositories/visit_repository.dart';
class GetVisits {
  final VisitRepository repository;
  const GetVisits(this.repository);
  Future<List<Visit>> call() {
    return repository.getVisits();
  }
}