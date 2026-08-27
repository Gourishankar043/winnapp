import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';
import '../datasources/visit_local_data_source.dart';
import '../datasources/visit_remote_data_source.dart';
import '../mappers/visit_mapper.dart';
import '../models/visit_model.dart';

class VisitRepositoryImpl implements VisitRepository {
  final VisitLocalDataSource localDataSource;
  final VisitRemoteDataSource remoteDataSource;

  const VisitRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Visit>> getVisits() async {
    final localVisits = await localDataSource.getLocalVisits();
    final visitLog = await localDataSource.getVisitLog();

    final visits = [
      ...localVisits,
      ...visitLog,
    ];

    visits.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return visits.map(VisitMapper.toEntity).toList();
  }

  @override
  Future<Visit> createVisit(Visit visit) async {
    final model = VisitMapper.toModel(visit);

    await localDataSource.insertLocalVisit(model);

    return visit;
  }

  @override
  Future<Visit> updateVisit(Visit visit) async {
    final model = VisitMapper.toModel(visit);

    await localDataSource.updateLocalVisit(model);

    return visit;
  }

  @override
  Future<Visit> syncVisit(Visit visit) async {
    final model = VisitMapper.toModel(visit);

    final requestData = model.toJson();

    final response = await remoteDataSource.syncVisit(requestData);

    final responseModel = VisitModel.fromJson(response);

    await localDataSource.deleteLocalVisit(visit.id);

    await localDataSource.insertVisitLog(responseModel);

    return VisitMapper.toEntity(responseModel);
  }
}