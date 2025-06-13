part of 'finance_bloc.dart';

sealed class FinanceEvent extends Equatable {
  const FinanceEvent();

  @override
  List<Object> get props => [];
}

class RequestWatchGetEntriesEvent extends FinanceEvent {
  final DateTime? dateTime;

  const RequestWatchGetEntriesEvent({required this.dateTime});
}

class GetEntriesEvent extends FinanceEvent {
  final DateTime? dateTime;

  const GetEntriesEvent({this.dateTime});
}

class InsertEntryEvent extends FinanceEvent {
  final EntriesCompanion entry;

  const InsertEntryEvent({required this.entry});
}

class DeleteEntryEvent extends FinanceEvent {
  final int id;

  const DeleteEntryEvent({required this.id});
}

class UpdateEntryEvent extends FinanceEvent {
  final EntriesCompanion entry;

  const UpdateEntryEvent({required this.entry});
}

class GetMonthlyBalanceEvent extends FinanceEvent {
  final DateTime? dateTime;

  const GetMonthlyBalanceEvent({required this.dateTime});
}

class ForwardSelectedDateTime extends FinanceEvent {}

class RewindSelectedDateTime extends FinanceEvent {}
