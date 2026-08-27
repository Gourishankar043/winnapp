import '../../domain/entities/visit.dart';

class VisitModel {
  final String id;
  final String siteName;
  final DateTime date;
  final String location;
  final String notes;
  final DateTime createdAt;
  final VisitStage stage;
  final DateTime? syncedAt;

  const VisitModel({
    required this.id,
    required this.siteName,
    required this.date,
    required this.location,
    required this.notes,
    required this.createdAt,
    required this.stage,
    this.syncedAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'] as String,
      siteName: json['site_name'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      notes: json['notes'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      stage: VisitStage.values.byName(json['stage'] as String),
      syncedAt: json['synced_at'] != null
          ? DateTime.parse(json['synced_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'site_name': siteName,
      'date': date.toIso8601String(),
      'location': location,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'stage': stage.name,
      'synced_at': syncedAt?.toIso8601String(),
    };
  }
}