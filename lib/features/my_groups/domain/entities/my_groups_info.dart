import 'package:equatable/equatable.dart';

class MyGroupsInfo extends Equatable {
  final String id;
  final String groupId;
  final bool isAdmin;
  final String idAdmin;

  const MyGroupsInfo({
    required this.id,
    required this.groupId,
    required this.isAdmin,
    required this.idAdmin,
  });

  @override
  List<Object?> get props => [id, groupId, isAdmin, idAdmin];
}
