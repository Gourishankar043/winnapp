enum VisitStage {
  draft,
  synced,
  failed,
}
class Visit {
  final String id;
  final String siteName;
  final DateTime date;
  final String location;
  final String notes;
  final DateTime createdAt;
  final VisitStage stage;
  final DateTime? syncedAt;
  const Visit({
    required this.id,
    required this.siteName,
    required this.date,
    required this.location,
    required this.notes,
    required this.createdAt,
    required this.stage,
    this.syncedAt,
  });
}