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

    final response =
    Map<String, dynamic>.from(data);

    const stages = [
      'synced',
      'draft',
      'failed',
    ];

    final stage =
    stages[_random.nextInt(stages.length)];

    response['stage'] = stage;

    if (stage == 'synced') {
      response['synced_at'] =
          DateTime.now().toIso8601String();
    } else {
      response['synced_at'] = null;
    }

    return response;
  }
}