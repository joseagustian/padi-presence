import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/domains/job_division/entities/job_division_entity.dart';
import 'package:padi/modules/shared/domains/job_division/usecases/job_division_usecase.dart';
import 'package:padi/modules/shared/infra/sources/job_division_service.dart';

final jobDivisionServicesProvider = Provider<JobDivisionServices>((ref) {
  return JobDivisionServices();
});

final jobDivisionUseCaseProvider = Provider<JobDivisionUseCase>((ref) {
  final jobDivisionServices = ref.watch(jobDivisionServicesProvider);
  return JobDivisionUseCase(jobDivisionServices);
});

final getJobDivisionProvider = Provider<JobDivisionProvider>((ref) {
  final jobDivisionUseCase = ref.watch(jobDivisionUseCaseProvider);
  return JobDivisionProvider(jobDivisionUseCase);
});

final jobDivisionProvider = FutureProvider.autoDispose<JobDivisions>((ref) async {
  final jobDivisionProvider = ref.watch(getJobDivisionProvider);
  return jobDivisionProvider.getJobDivisions();
});

class JobDivisionProvider {
  final JobDivisionUseCase jobDivisionUseCase;

  JobDivisionProvider(this.jobDivisionUseCase);

  bool isLoading = false;
  String? error;

  JobDivisions? response;

  Future<JobDivisions> getJobDivisions() async {

    isLoading = true;

    try {
      response = await jobDivisionUseCase.getJobDivisions();
      isLoading = false;
      return response!;
    } on Exception catch (e) {
      if (e.toString().contains('SocketException')) {
        error = Strings.noInternetConnection;
      } else if (e.toString().contains('TimeoutException')) {
        error = Strings.failToConnectToServer;
      } else {
        error = e.toString();
      }
      throw Exception(error);
    }
  }

}