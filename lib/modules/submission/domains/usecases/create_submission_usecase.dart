import 'package:padi/modules/submission/domains/entities/create_submission_entity.dart';
import 'package:padi/modules/submission/infra/models/create_submission_model.dart';
import 'package:padi/modules/submission/infra/sources/create_submission_services.dart';

class CreateSubmissionUseCase {
  final CreateSubmissionServices _createSubmissionServices;

  CreateSubmissionUseCase(this._createSubmissionServices);

  Future<CreateSubmission> createSubmission(CreateSubmissionBodyRequest body) async {
    final createSubmissionData = await _createSubmissionServices.createSubmission(body);

    final createSubmission = CreateSubmission(
      status: createSubmissionData.status,
      message: createSubmissionData.message,
    );

    return createSubmission;
  }
}