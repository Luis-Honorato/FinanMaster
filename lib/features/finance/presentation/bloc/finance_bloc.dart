import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/delete_entry_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/get_entries_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/get_monthly_balance_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/insert_entry_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/update_entry_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/enums/request_state_enum.dart';

part 'finance_event.dart';
part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  final GetEntriesUsecase getEntriesUsecase;
  final DeleteEntryUsecase deleteEntryUsecase;
  final InsertEntryUsecase insertEntryUsecase;
  final UpdateEntryUsecase updateEntryUsecase;
  final GetMonthlyBalanceUsecase getMonthlyBalanceUsecase;

  FinanceBloc({
    required this.getEntriesUsecase,
    required this.deleteEntryUsecase,
    required this.insertEntryUsecase,
    required this.updateEntryUsecase,
    required this.getMonthlyBalanceUsecase,
  }) : super(FinanceState(selectedDateTime: DateTime.now())) {
    on<GetEntriesEvent>((event, emit) async {
      emit(state.resetStream());
      emit(state.copyWith(
        entriesRequestState: RequestState.loading,
      ));

      final eventDateTime = event.dateTime ?? state.selectedDateTime;
      final result = await getEntriesUsecase(
        month: eventDateTime.month,
        year: eventDateTime.year,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          entriesRequestState: RequestState.failure,
        )),
        (entriesStream) => emit(state.copyWith(
          entriesRequestState: RequestState.success,
          entriesStream: entriesStream,
        )),
      );
    });
    on<InsertEntryEvent>((event, emit) async {
      emit(state.copyWith(
        insertEntryRequestState: RequestState.loading,
      ));

      final result = await insertEntryUsecase(event.entry);

      result.fold(
        (failure) => emit(state.copyWith(
          insertEntryRequestState: RequestState.failure,
        )),
        (success) => emit(state.copyWith(
          insertEntryRequestState: RequestState.success,
        )),
      );
    });

    on<UpdateEntryEvent>((event, emit) async {
      emit(state.copyWith(
        updateEntryRequestState: RequestState.loading,
      ));

      final result = await updateEntryUsecase(event.entry);

      result.fold(
        (failure) => emit(state.copyWith(
          updateEntryRequestState: RequestState.failure,
        )),
        (success) => emit(state.copyWith(
          updateEntryRequestState: RequestState.success,
        )),
      );
    });

    on<DeleteEntryEvent>((event, emit) async {
      emit(state.copyWith(
        deleteEntryRequestState: RequestState.loading,
      ));

      final result = await deleteEntryUsecase(event.id);

      result.fold(
        (failure) => emit(state.copyWith(
          deleteEntryRequestState: RequestState.failure,
        )),
        (success) => emit(state.copyWith(
          deleteEntryRequestState: RequestState.success,
        )),
      );
    });

    on<GetMonthlyBalanceEvent>((event, emit) async {
      emit(state.resetStream());
      emit(state.copyWith(
        monthlyBalanceRequestState: RequestState.loading,
      ));

      final eventDateTime = event.dateTime;
      final result = await getMonthlyBalanceUsecase(
        month: eventDateTime?.month,
        year: eventDateTime?.year,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          monthlyBalanceRequestState: RequestState.failure,
        )),
        (balanceStream) => emit(state.copyWith(
          monthlyBalanceRequestState: RequestState.success,
          monthlyBalance: balanceStream,
        )),
      );
    });

    on<ForwardSelectedDateTime>((event, emit) async {
      final selectedDateTime = state.selectedDateTime;
      final currentMonth = state.selectedDateTime.month;
      late DateTime newSelectedDateTime;

      if (currentMonth < 12) {
        newSelectedDateTime = DateTime(selectedDateTime.year,
            selectedDateTime.month + 1, selectedDateTime.day);
      } else {
        newSelectedDateTime =
            DateTime(selectedDateTime.year + 1, 1, selectedDateTime.day);
      }
      emit(state.copyWith(selectedDateTime: newSelectedDateTime));
      add(GetEntriesEvent(dateTime: newSelectedDateTime));
    });

    on<RewindSelectedDateTime>((event, emit) async {
      final selectedDateTime = state.selectedDateTime;
      final currentMonth = state.selectedDateTime.month;
      late DateTime newSelectedDateTime;

      if (currentMonth > 1) {
        newSelectedDateTime = DateTime(selectedDateTime.year,
            selectedDateTime.month - 1, selectedDateTime.day);
      } else {
        newSelectedDateTime =
            DateTime(selectedDateTime.year - 1, 12, selectedDateTime.day);
      }
      emit(state.copyWith(selectedDateTime: newSelectedDateTime));

      add(GetEntriesEvent(dateTime: newSelectedDateTime));
    });
  }
}
