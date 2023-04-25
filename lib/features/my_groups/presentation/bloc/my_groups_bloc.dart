import 'package:app/features/my_groups/data/models/edit_admin_request.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_admin.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_fetch_data.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_remove_member.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/models/message_model.dart';
import 'package:app/util/use_case.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/constants/constants.dart';
import '../../../../util/failure.dart';
import '../../data/models/remove_member_request.dart';
import '../../domain/use_case/create_my_groups.dart';
import '../../domain/use_case/my_groups_list.dart';
import '../../domain/use_case/my_groups_transfer_admin.dart';
import './my_groups_events.dart';
import './my_groups_state.dart';

class MyGroupsBloc extends Bloc<MyGroupsEvent, MyGroupsState> {
  MyGroupsFetchDataUseCase myGroupsFetchDataUseCase;
  MyGroupsRemoveMemberUseCase myGroupsRemoveMemberUseCase;
  MyGroupsEditAdminUseCase myGroupsEditAdminUseCase;
  MyGroupsListUseCase myGroupsListUseCase;
  CreateMyGroupsUseCase createMyGroupsUseCase;
  UserPreferenceDao userDao;
  MyGroupsBloc(
      {required this.myGroupsFetchDataUseCase,
      required this.myGroupsRemoveMemberUseCase,
      required this.myGroupsEditAdminUseCase,
      required this.myGroupsListUseCase,
      required this.createMyGroupsUseCase,
      required this.userDao})
      : super(const MyGroupsState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<RemoveMember>(_onRemoveMember);
    on<AddMember>(_onAddMember);
    on<ChangeFilter>(_onChangeFilter);
    on<FetchData>(_onFetchData);
    on<FetchUser>(_onFetchUser);
    on<TransferManagement>(_onTransferManagement);
    on<LeaveGroup>(_onLeaveGroup);
    on<CreateGroup>(_onCreateGroup);
  }

  void _onCreateGroup(CreateGroup event, Emitter<MyGroupsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    var result = await createMyGroupsUseCase.call(state.user!.userId!);
    result.fold(
      (l) {
        var message = getMessage(l);
        emit(state.copyWith(
            members: [], loading: LoadingState.close, messageError: message));
      },
      (r) {
        emit(state.copyWith(
            groupInfo: r.groupMembers.toEntity(),
            admin: MyGroupsAdmin(
              firstName: state.user!.firstName!,
              lastName: state.user!.lastName!,
              gender: state.user!.gender!,
              age: state.user!.age!,
              userId: state.user!.userId!,
              idUserAlephoo: state.user!.idUserAlephoo!,
            ),
            loading: LoadingState.close));
      },
    );
    emit(state.copyWith(loading: LoadingState.close));
  }

  void _onDisposeLoading(
      DisposeLoading event, Emitter<MyGroupsState> emit) async {
    emit(state.copyWith(
        loading: LoadingState.dispose, messageError: '', removeSuccess: false));
  }

  void _onRemoveMember(RemoveMember event, Emitter<MyGroupsState> emit) async {
    var result = await myGroupsRemoveMemberUseCase.call(RemoveMemberRequest(
        userId: event.userId, groupId: state.groupInfo!.groupId));
    emit(state.copyWith(loading: LoadingState.show));
    await result.fold(
      (l) async {
        var message = getMessage(l);
        emit(
            state.copyWith(loading: LoadingState.close, messageError: message));
      },
      (r) async {
        emit(state.copyWith(
            groupInfo: r.groupMembers.toEntity(),
            members: state.members!
                .where(
                    (member) => r.groupMembers.members.contains(member.userId))
                .toList(),
            loading: LoadingState.close,
            removeSuccess: true));
      },
    );
  }

  void _onChangeFilter(ChangeFilter event, Emitter<MyGroupsState> emit) async {
    emit(state.copyWith(filter: event.filter, useFilter: true));
  }

  void _onFetchData(FetchData event, Emitter<MyGroupsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    var result = await myGroupsFetchDataUseCase.call(ParametroVacio());
    await result.fold((l) async {
      if (l is ServerFailure &&
          !l.modelServer.isSimple() &&
          (l.modelServer.message.first as MessageModel).type == 'GROUP_ERROR') {
        emit(MyGroupsState(loading: LoadingState.close, user: state.user));
      } else {
        emit(state.copyWith(
          loading: LoadingState.close,
          messageError: getMessage(l),
          canDisplay: false,
        ));
      }
    }, (r) async {
      var groupInfo = r.toEntity();
      var result = await myGroupsListUseCase.call(r.idAdmin);
      result.fold(
        (l) {
          emit(MyGroupsState(
              loading: LoadingState.close,
              messageError: getMessage(l),
              groupInfo: groupInfo,
              user: state.user));
        },
        (r) {
          emit(state.copyWith(
            groupInfo: groupInfo,
            admin: r.administrator.toEntity(),
            members: r.members.map((e) => e.toEntity()).toList(),
            loading: LoadingState.close,
          ));
        },
      );
    });
  }

  void _onAddMember(AddMember event, Emitter<MyGroupsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    List<MyGroupsMember> membersList;
    if (state.members != null) {
      membersList = state.members!..add(event.member);
    } else {
      membersList = [event.member];
    }
    emit(state.copyWith(
      members: membersList,
      loading: LoadingState.close,
    ));
  }

  void _onFetchUser(FetchUser event, Emitter<MyGroupsState> emit) async {
    var user = await userDao.getUser();
    emit(state.copyWith(user: user.fold((error) => null, (user) => user)));
  }

  void _onTransferManagement(
      TransferManagement event, Emitter<MyGroupsState> emit) async {
    var result = await myGroupsEditAdminUseCase.call(EditAdminRequest(
        adminId: state.admin!.userId,
        newAdminId: event.member.userId!,
        groupId: state.groupInfo!.groupId));
    emit(state.copyWith(loading: LoadingState.show));
    await result.fold(
      (l) async {
        var message = getMessage(l);
        emit(
            state.copyWith(loading: LoadingState.close, messageError: message));
      },
      (r) async {
        var newAdmin = MyGroupsAdmin(
            firstName: event.member.firstName!,
            lastName: event.member.lastName!,
            gender: event.member.gender!,
            age: event.member.age!,
            userId: event.member.userId!,
            idUserAlephoo: event.member.idUserAlephoo!);
        var members = state.members!
            .where((member) => member.userId != event.member.userId)
            .toList();
        members.add(MyGroupsMember(
            firstName: state.admin!.firstName,
            lastName: state.admin!.lastName,
            gender: state.admin!.gender,
            age: state.admin!.age,
            userId: state.admin!.userId));
        emit(state.copyWith(admin: newAdmin, members: members));
      },
    );
  }

  void _onLeaveGroup(LeaveGroup event, Emitter<MyGroupsState> emit) async {
    MyGroupsState newState = MyGroupsState(user: state.user);

    emit(newState);
  }

  String getMessage(ErrorGeneral l) {
    if (l is ServerFailure) {
      if (l.modelServer.isSimple()) {
        return l.modelServer.message ?? '';
      } else {
        return l.modelServer.message?.first.message ?? '';
      }
    }
    if (l is ErrorMessage) {
      return l.message;
    }
    return ERROR_MESSAGE;
  }
}
