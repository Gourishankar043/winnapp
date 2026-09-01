import 'package:winnapp/core/network/connectivity_service.dart';
import 'package:winnapp/domain/entities/visit.dart';
import 'package:winnapp/domain/repositories/visit_repository.dart';

class OfflineSyncException implements Exception {
  const OfflineSyncException();

  @override
  String toString() {
    return 'No internet connection. Unable to sync visit.';
  }
}

class SyncVisits {
  final VisitRepository repository;
  final ConnectivityService connectivityService;

  const SyncVisits({
    required this.repository,
    required this.connectivityService,
  });

  Future<Visit> call(Visit visit) async {
    final isConnected =
    await connectivityService.checkConnection();

    if (!isConnected) {
      throw const OfflineSyncException();
    }

    return repository.syncVisit(visit);
  }
}