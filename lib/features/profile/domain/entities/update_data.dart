import 'package:equatable/equatable.dart';

class UpdateData extends Equatable {
  final String phone;

  const UpdateData({required this.phone});

  UpdateData copyWith({
    String? phone,
  }) {
    return UpdateData(
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [phone];
}
