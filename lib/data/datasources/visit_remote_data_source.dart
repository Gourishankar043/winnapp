import 'dart:async';
import 'dart:math';

abstract class VisitRemoteDataSource {
  Future<Map<String, dynamic>> syncVisit(
      Map<String, dynamic> data,
      );
}

class VisitRemoteDataSourceImpl
    implements VisitRemoteDataSource {
  final Random _random;

  VisitRemoteDataSourceImpl({
    Random? random,
  }) : _random = random ?? Random();

  @override
  Future<Map<String, dynamic>> syncVisit(
      Map<String, dynamic> data,
      ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    final isSuccessful = _random.nextBool();

    final response =
    Map<String, dynamic>.from(data);

    if (isSuccessful) {
      response['stage'] = 'synced';
      response['synced_at'] =
          DateTime.now().toIso8601String();
    } else {
      response['stage'] = 'failed';
      response['synced_at'] = null;
    }

    return response;
  }
}