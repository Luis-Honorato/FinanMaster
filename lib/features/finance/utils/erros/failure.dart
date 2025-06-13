abstract class Failure {
  final String message;

  Failure({required this.message});
}

class DaoFailure extends Failure {
  DaoFailure({required super.message});
}
