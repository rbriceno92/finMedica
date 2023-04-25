import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'confidentiality_event.dart';
import 'confidentiality_state.dart';

class ConfidentialityBloc
    extends Bloc<ConfidentialityEvent, ConfidentialityState> {
  ConfidentialityBloc() : super(const ConfidentialityState()) {
    on<ConfidentialityPrivate>(setPrivateConfidentiality);
  }

  FutureOr<void> setPrivateConfidentiality(
      ConfidentialityPrivate event, Emitter<ConfidentialityState> emit) {
    emit(state.copyWith(isPrivate: !state.isPrivate));
  }
}
