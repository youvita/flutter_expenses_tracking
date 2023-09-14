import 'package:equatable/equatable.dart';

abstract class UseCase<Params> {
  Future<void> save(Params params);
  Future<void> update(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}