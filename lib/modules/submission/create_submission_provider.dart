import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/submission/infra/models/create_submission_model.dart';

import 'domains/entities/create_submission_entity.dart';
import 'domains/usecases/create_submission_usecase.dart';
import 'infra/sources/create_submission_services.dart';

final createSubmissionServicesProvider = Provider<CreateSubmissionServices>((ref) {
  return CreateSubmissionServices();
});

final createSubmissionUseCaseProvider = Provider<CreateSubmissionUseCase>((ref) {
  final createSubmissionServices = ref.watch(createSubmissionServicesProvider);
  return CreateSubmissionUseCase(createSubmissionServices);
});

final createSubmissionProvider = Provider<CreateSubmissionProvider>((ref) {
  final createSubmissionUseCase = ref.watch(createSubmissionUseCaseProvider);
  return CreateSubmissionProvider(createSubmissionUseCase);
});

class CreateSubmissionProvider {
  final CreateSubmissionUseCase createSubmissionUseCase;

  CreateSubmissionProvider(this.createSubmissionUseCase);

  AppLogger logger = AppLogger();
  bool isLoading = false;
  String? error;

  Future<CreateSubmission> createSubmission(CreateSubmissionBodyRequest body) async {
    isLoading = true;

    try {
      final createSubmission = await createSubmissionUseCase.createSubmission(body);
      isLoading = false;
      return createSubmission;
    } on Exception catch (e) {
      isLoading = false;
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