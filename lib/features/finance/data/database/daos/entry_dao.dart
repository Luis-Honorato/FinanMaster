import 'package:drift/drift.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/tables/entries.dart';
import '../app_database.dart';

part 'entry_dao.g.dart';

@DriftAccessor(tables: [Entries])
class EntryDao extends DatabaseAccessor<AppDatabase> with _$EntryDaoMixin {
  EntryDao(AppDatabase db) : super(db);

  Future<void> insertEntry(EntriesCompanion entry) {
    return into(db.entries).insert(entry);
  }

  Future<Stream<List<Entry>>> watchEntriesByCategory(String type) async {
    return (select(db.entries)..where((t) => t.entryCategory.equals(type)))
        .watch();
  }

  Stream<List<Entry>> watchEntries() {
    return select(db.entries).watch();
  }

  Future<Stream<List<Entry>>> watchEntriesByMonthYear({
    required int month,
    required int year,
  }) async {
    final query = select(db.entries)
      ..where((t) {
        return t.entryDate.month.equals(month) & t.entryDate.year.equals(year);
      })
      ..orderBy([
        (t) => OrderingTerm(expression: t.entryDate, mode: OrderingMode.asc),
      ]);

    return query.watch();
  }

  Future<void> updateEntry({
    required EntriesCompanion newEntry,
    required int id,
  }) {
    return (update(db.entries)..where((t) => t.id.equals(id))).write(newEntry);
  }

  Future<void> deleteEntry({
    required int id,
  }) {
    return (delete(db.entries)..where((t) => t.id.equals(id))).go();
  }

  Future<Stream<double>> watchMonthlyBalance({
    required int month,
    required int year,
  }) async {
    final query = select(entries)
      ..where((e) =>
          e.entryDate.month.equals(month) & e.entryDate.year.equals(year));

    return query.watch().map((entriesList) {
      double income = 0;
      double expense = 0;

      for (final entry in entriesList) {
        if (entry.entryType == 'income') {
          income += entry.value;
        } else if (entry.entryType == 'expense') {
          expense += entry.value;
        }
      }

      return income - expense;
    });
  }
}
