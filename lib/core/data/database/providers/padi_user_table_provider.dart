
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/data/database/repositories/padi_user_table_repository.dart';

class PadiUserTableDataProvider {

  PadiUserAccountTableRepository padiUserAccountTableRepository = PadiUserAccountTableRepository();

  Future<String> getUserToken() async {
    final data = await padiUserAccountTableRepository.getPadiUserAccount();
    return data?.userAccessToken?? '';
  }

  Future<Map<String, dynamic>> getEmployeeData() async {
    final data = await padiUserAccountTableRepository.getPadiUserAccount();
    final employeeData = {
      'email': data?.userEmail?? '',
      'name': data?.userAccountName?? '',
      'employeeId': data?.userEmployeeId?? '',
      'dateOfBirth': data?.userDateOfBirth?? '',
      'address': data?.userAddress?? '',
      'religion': data?.userReligion?? '',
      'jobPosition': data?.userJobPosition?? '',
      'jobDivision': data?.userJobDivision?? '',
    };

    return employeeData;
  }

}

final padiUserTableProvider = Provider<PadiUserTableDataProvider>((ref) {
  return PadiUserTableDataProvider();
});

final userTokenProvider = FutureProvider<String>((ref) async {
  return ref.watch(padiUserTableProvider).getUserToken();
});

final employeeDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return ref.watch(padiUserTableProvider).getEmployeeData();
});

class PadiUserDataState{
  final String userAccessToken;
  final String userAccountName;
  final String userEmployeeId;
  final String userDateOfBirth;
  final String userAddress;
  final String userReligion;
  final String userJobPosition;
  final String userJobDivision;

  PadiUserDataState({
    required this.userAccessToken,
    required this.userAccountName,
    required this.userEmployeeId,
    required this.userDateOfBirth,
    required this.userAddress,
    required this.userReligion,
    required this.userJobPosition,
    required this.userJobDivision,
  });

  PadiUserDataState copyWith({
    String? userAccessToken,
    String? userAccountName,
    String? userEmployeeId,
    String? userDateOfBirth,
    String? userAddress,
    String? userReligion,
    String? userJobPosition,
    String? userJobDivision,
  }) {
    return PadiUserDataState(
      userAccessToken: userAccessToken ?? this.userAccessToken,
      userAccountName: userAccountName ?? this.userAccountName,
      userEmployeeId: userEmployeeId ?? this.userEmployeeId,
      userDateOfBirth: userDateOfBirth ?? this.userDateOfBirth,
      userAddress: userAddress ?? this.userAddress,
      userReligion: userReligion ?? this.userReligion,
      userJobPosition: userJobPosition ?? this.userJobPosition,
      userJobDivision: userJobDivision ?? this.userJobDivision,
    );
  }

}

class PadiUserDataProvider extends StateNotifier<PadiUserDataState> {

  PadiUserAccountTableRepository padiUserAccountTableRepository = PadiUserAccountTableRepository();
  PadiUserDataProvider() : super(PadiUserDataState(
    userAccessToken: '',
    userAccountName: '',
    userEmployeeId: '',
    userDateOfBirth: '',
    userAddress: '',
    userReligion: '',
    userJobPosition: '',
    userJobDivision: '',
  )) {
    _setUserData();
  }

  Future<void> _setUserData() async {
    final data = await padiUserAccountTableRepository.getPadiUserAccount();
    state = state.copyWith(
      userAccessToken: data?.userAccessToken?? '',
      userAccountName: data?.userAccountName?? '',
      userEmployeeId: data?.userEmployeeId?? '',
      userDateOfBirth: data?.userDateOfBirth?? '',
      userAddress: data?.userAddress?? '',
      userReligion: data?.userReligion?? '',
      userJobPosition: data?.userJobPosition?? '',
      userJobDivision: data?.userJobDivision?? '',
    );
  }

}

final padiUserDataProvider = StateNotifierProvider<PadiUserDataProvider, PadiUserDataState>((ref) {
  return PadiUserDataProvider();
});