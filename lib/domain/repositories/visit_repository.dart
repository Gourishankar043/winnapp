import '../entities/visit.dart';

abstract class VisitRepository {
  Future<List<Visit>> getVisits();

  Future<Visit> createVisit(Visit visit);

  Future<Visit> updateVisit(Visit visit);

  Future<Visit> syncVisit(Visit visit);
}