/// Types of errors that can occur during ranking
enum RankingErrorType {
  network,
  clarification,
  safety,
  inappropriateContent,
  unknown,
}

class RankingException implements Exception {
  final RankingErrorType type;
  final String message;

  const RankingException(this.type, this.message);

  factory RankingException.network(String message) =>
      RankingException(RankingErrorType.network, message);

  factory RankingException.safety(String message) =>
      RankingException(RankingErrorType.safety, message);

  factory RankingException.clarification(String message) =>
      RankingException(RankingErrorType.clarification, message);

  factory RankingException.unknown(String message) =>
      RankingException(RankingErrorType.unknown, message);

  @override
  String toString() => message;
}
