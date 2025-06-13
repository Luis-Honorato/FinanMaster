import 'package:drift/drift.dart';

class Entries extends Table {
  // ID primário
  IntColumn get id => integer().autoIncrement()();

  // Tipo da entrada (ex: receita ou despesa) - mapeado como string
  TextColumn get entryType => text()();

  // Categoria da entrada - mapeado como string
  TextColumn get entryCategory => text()();

  // Data da entrada
  DateTimeColumn get entryDate => dateTime()();

  // Valor da entrada
  RealColumn get value => real()();

  // Nome opcional
  TextColumn get name => text().nullable()();

  // Descrição opcional
  TextColumn get description => text().nullable()();
}
