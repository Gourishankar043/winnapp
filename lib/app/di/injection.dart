import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../../core/network/connectivity_service.dart';
import '../../data/datasources/visit_local_data_source.dart';
import '../../data/datasources/visit_remote_data_source.dart';
import '../../data/repositories/visit_repository_impl.dart';
import '../../domain/repositories/visit_repository.dart';
import '../../domain/usecases/create_visit.dart';
import '../../domain/usecases/get_visits.dart';
import '../../domain/usecases/sync_visits.dart';
import '../../domain/usecases/update_visit.dart';
import '../../presentation/bloc/network/network_bloc.dart';
import '../../presentation/bloc/visit/visit_bloc.dart';
final GetIt getIt = GetIt.instance;

void configureDependencies() {
  // Connectivity
  getIt.registerLazySingleton<Connectivity>(
        () => Connectivity(),
  );

  getIt.registerLazySingleton<ConnectivityService>(
        () => ConnectivityServiceImpl(
      connectivity: getIt<Connectivity>(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<VisitLocalDataSource>(
        () => VisitLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<VisitRemoteDataSource>(
        () => VisitRemoteDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<VisitRepository>(
        () => VisitRepositoryImpl(
      localDataSource: getIt<VisitLocalDataSource>(),
      remoteDataSource: getIt<VisitRemoteDataSource>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton<GetVisits>(
        () => GetVisits(getIt<VisitRepository>()),
  );

  getIt.registerLazySingleton<CreateVisit>(
        () => CreateVisit(getIt<VisitRepository>()),
  );

  getIt.registerLazySingleton<UpdateVisit>(
        () => UpdateVisit(getIt<VisitRepository>()),
  );

  getIt.registerLazySingleton<SyncVisits>(
        () => SyncVisits(getIt<VisitRepository>()),
  );
  getIt.registerFactory<NetworkBloc>(
        () => NetworkBloc(
      connectivityService: getIt<ConnectivityService>(),
    ),
  );

  getIt.registerFactory<VisitBloc>(
        () => VisitBloc(
      getVisits: getIt<GetVisits>(),
      createVisit: getIt<CreateVisit>(),
      updateVisit: getIt<UpdateVisit>(),
      syncVisits: getIt<SyncVisits>(),
    ),
  );
}