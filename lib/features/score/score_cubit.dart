import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhythm_flux/features/score/score_repository.dart';
import 'package:rhythm_flux/features/score/score_states.dart';


class ScoreCubit extends Cubit<ScoreState> {
  final ScoreRepository repository;
  List<int> allScores=[];
  ScoreCubit({
    required this.repository,
  }) : super(const ScoreState());

  Future<void> saveScore(int score) async {
    emit(
      state.copyWith(
        saveStatus: ScoreStatus.loading,
        clearSaveError: true,
      ),
    );

    try {
      await repository.saveScore(score);

      emit(
        state.copyWith(
          saveStatus: ScoreStatus.success,
          clearSaveError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          saveStatus: ScoreStatus.failure,
          saveError: e.toString(),
        ),
      );
    }
  }

  Future<void> getScores() async {
    emit(
      state.copyWith(
        fetchStatus: ScoreStatus.loading,
        clearFetchError: true,
      ),
    );

    try {
      final scores = await repository.getScores();

      if (scores == null) {
        emit(
          state.copyWith(
            fetchStatus: ScoreStatus.failure,
            fetchError: "Can't get scores",
          ),
        );
        return;
      }

      allScores = scores;

      emit(
        state.copyWith(
          fetchStatus: ScoreStatus.success,
          scores: scores,
          clearFetchError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchStatus: ScoreStatus.failure,
          fetchError: e.toString(),
        ),
      );
    }
  }}