enum ScoreStatus {
  initial,
  loading,
  success,
  failure,
}

class ScoreState {
  final ScoreStatus saveStatus;
  final ScoreStatus fetchStatus;

  final List<int> scores;

  final String? saveError;
  final String? fetchError;

  const ScoreState({
    this.saveStatus = ScoreStatus.initial,
    this.fetchStatus = ScoreStatus.initial,
    this.scores = const [],
    this.saveError,
    this.fetchError,
  });

  ScoreState copyWith({
    ScoreStatus? saveStatus,
    ScoreStatus? fetchStatus,
    List<int>? scores,
    String? saveError,
    String? fetchError,
    bool clearSaveError = false,
    bool clearFetchError = false,

  }) {
    return ScoreState(
      saveStatus: saveStatus ?? this.saveStatus,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      scores: scores ?? this.scores,
      saveError: clearSaveError ? null : saveError ?? this.saveError,
      fetchError: clearFetchError ? null : fetchError ?? this.fetchError,
    );
  }
}