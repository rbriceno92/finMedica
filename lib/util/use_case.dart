import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'failure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<ErrorGeneral, Type>> call(Param param);
}

// Esta clase sera usada cuando el caso de uso no requiera parametros
class ParametroVacio extends Equatable {
  @override
  List<Object?> get props => [];
}
