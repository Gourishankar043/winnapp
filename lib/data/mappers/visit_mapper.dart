import '../../domain/entities/visit.dart';
import '../models/visit_model.dart';
class VisitMapper {
  VisitMapper._();
  static Visit toEntity(VisitModel model) {
    return Visit(
      id: model.id,
      siteName: model.siteName,
      date: model.date,
      location: model.location,
      notes: model.notes,
      createdAt: model.createdAt,
      stage: model.stage,
      syncedAt: model.syncedAt,
    );
  }
  static VisitModel toModel(Visit entity) {
    return VisitModel(
      id: entity.id,
      siteName: entity.siteName,
      date: entity.date,
      location: entity.location,
      notes: entity.notes,
      createdAt: entity.createdAt,
      stage: entity.stage,
      syncedAt: entity.syncedAt,
    );
  }
}