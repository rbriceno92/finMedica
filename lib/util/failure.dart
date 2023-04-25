import 'package:app/util/models/error_model_server.dart';
import 'package:equatable/equatable.dart';

abstract class ErrorGeneral extends Equatable {
  // Si las subclases tienen propiedades, llegaran a este constructor
  // Para que Equatable pueda hacer su comparacion
  const ErrorGeneral([List properties = const <dynamic>[]]);
}

class ServerFailure extends ErrorGeneral {
  final ErrorModelServer modelServer;

  const ServerFailure({required this.modelServer});

  @override
  List<Object?> get props => [modelServer];
}

class ErrorMessage extends ErrorGeneral {
  final String message;

  const ErrorMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

//specify more types of errors here
