part of 'finance_bloc.dart';

class FinanceState extends Equatable {
  final RequestState entriesRequestState;
  final RequestState insertEntryRequestState;
  final RequestState updateEntryRequestState;
  final RequestState deleteEntryRequestState;
  final RequestState monthlyBalanceRequestState;
  final Stream<List<Entry>>? entriesStream;
  final Stream<double>? monthlyBalance;
  final DateTime selectedDateTime;
  const FinanceState({
    required this.selectedDateTime,
    this.entriesRequestState = RequestState.intial,
    this.insertEntryRequestState = RequestState.intial,
    this.updateEntryRequestState = RequestState.intial,
    this.deleteEntryRequestState = RequestState.intial,
    this.monthlyBalanceRequestState = RequestState.intial,
    this.entriesStream,
    this.monthlyBalance,
  });

  FinanceState copyWith({
    RequestState? entriesRequestState,
    RequestState? insertEntryRequestState,
    RequestState? updateEntryRequestState,
    RequestState? deleteEntryRequestState,
    RequestState? monthlyBalanceRequestState,
    Stream<List<Entry>>? entriesStream,
    Stream<double>? monthlyBalance,
    DateTime? selectedDateTime,
  }) {
    return FinanceState(
      entriesRequestState: entriesRequestState ?? this.entriesRequestState,
      insertEntryRequestState:
          insertEntryRequestState ?? this.insertEntryRequestState,
      updateEntryRequestState:
          updateEntryRequestState ?? this.updateEntryRequestState,
      deleteEntryRequestState:
          deleteEntryRequestState ?? this.deleteEntryRequestState,
      monthlyBalanceRequestState:
          monthlyBalanceRequestState ?? this.monthlyBalanceRequestState,
      entriesStream: entriesStream ?? this.entriesStream,
      monthlyBalance: monthlyBalance ?? this.monthlyBalance,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
    );
  }

  FinanceState resetStream() {
    return FinanceState(
      entriesRequestState: entriesRequestState,
      insertEntryRequestState: insertEntryRequestState,
      updateEntryRequestState: updateEntryRequestState,
      deleteEntryRequestState: deleteEntryRequestState,
      monthlyBalanceRequestState: monthlyBalanceRequestState,
      entriesStream: null,
      monthlyBalance: monthlyBalance,
      selectedDateTime: selectedDateTime,
    );
  }

  @override
  List<Object?> get props => [
        entriesRequestState,
        insertEntryRequestState,
        updateEntryRequestState,
        deleteEntryRequestState,
        monthlyBalanceRequestState,
        entriesStream,
        monthlyBalance,
        selectedDateTime,
      ];
}
