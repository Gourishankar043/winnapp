import '../entities/visit.dart';

class SearchVisits {
  const SearchVisits();

  List<Visit> call(
      List<Visit> visits,
      String query,
      ) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<Visit>.from(visits);
    }

    return visits.where((visit) {
      return visit.siteName.toLowerCase().contains(normalizedQuery) ||
          visit.location.toLowerCase().contains(normalizedQuery) ||
          visit.notes.toLowerCase().contains(normalizedQuery);
    }).toList();
  }
}