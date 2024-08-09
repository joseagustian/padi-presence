import 'package:intl/intl.dart';
import 'package:padi/core/constants/strings.dart';

//create email validator
class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.emailEmpty;
    } else {
      final emailRegex = RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(value)) {
        return Strings.emailInvalid;
      }
    }
    return null;
  }


  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.passwordEmpty;
    } else if (value.length < 8) {
      return Strings.passwordShort;
    }
    return null;
  }

  static String? validateNewPassword(String? value) {
    final passwordRegex = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*/])");
    if (value == null || value.isEmpty) {
      return Strings.passwordEmpty;
    } else if (!passwordRegex.hasMatch(value)) {
      return Strings.passwordCriteria;
    } else if (value.length < 8) {
      return Strings.passwordShort;
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fullNameEmpty;
    } else {
      final nameRegex = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
      if (!nameRegex.hasMatch(value)) {
        return Strings.fullNameInvalid;
      }
    }
    return null;
  }

  static String? validateSecurityQuestionSelection(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.notYetSelectSecurityQuestion;
    }
    return null;
  }

  static String? validateSecurityQuestionAnswer(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.answerSecurityQuestionEmpty;
    } else if (value
        .split(' ')
        .length > 3) {
      return Strings.answerSecurityQuestionMax3Words;
    }
    {
      final answerRegex = RegExp(r"^[a-zA-Z\s]+$");
      if (!answerRegex.hasMatch(value)) {
        return Strings.invalidFormatAnswerSecurityQuestion;
      }
    }
    return null;
  }

  static String? validateBirthDateSelection(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.pleaseSelectBirthDate;
    }

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    DateTime birthDate = dateFormat.parse(value);
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;

    if (age <= 18) {
      return Strings.ageNotEnough;
    }

    return null;
  }

  static String? validateOfficeLocationSelection(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.pleaseSelectOfficeLocation;
    }
    return null;
  }

  static String? validateDivisionSelection(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.pleaseSelectDivision;
    }
    return null;
  }

  static String? validatePositionSelection(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.pleaseSelectPosition;
    }
    return null;
  }

  static String? validateConfirmationPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return Strings.confirmationPasswordEmpty;
    } else if (value != password) {
      return Strings.passwordNotMatch;
    }
    return null;
  }

  static String? validateCaptcha(String? value, int captcha) {
    if (value == null || value.isEmpty) {
      return Strings.captchaEmpty;
    } else if (value != captcha.toString()) {
      return Strings.captchaNotMatch;
    }
    return null;
  }

  static String? validateCheckIn(String? timestamp,
      String? lat,
      String? long,
      String? status,) {
    bool allEmpty = timestamp == null || timestamp.isEmpty || lat == null ||
        lat.isEmpty || long == null || long.isEmpty || status == null ||
        status.isEmpty;
    if (allEmpty) {
      return Strings.checkInFormInvalidData;
    }
    return null;
  }

  static String? validateWorkType(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.pleaseSelectWorkType;
    }
    return null;
  }

  static String? validateCheckOut(String? timestamp,
      String? lat,
      String? long,
      String? status,
      String? progressType,) {
    bool allEmpty = timestamp == null || timestamp.isEmpty || lat == null ||
        lat.isEmpty || long == null || long.isEmpty || status == null ||
        status.isEmpty || progressType == null || progressType.isEmpty;

    if (allEmpty) {
      return Strings.checkOutFormInvalidData;
    }
    return null;
  }

  static String? validateProgressTypeAndActivity(String? progressType,
      String? activity,) {
    if (activity == null || activity.isEmpty) {
      return Strings.pleaseFillWorkActivity;
    }

    if (progressType == null || progressType.isEmpty) {
      return Strings.pleaseSelectWorkProgress;
    }

    return null;
  }

  static String? validateEmployeeIDNumber(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.employeeIDNumberEmpty;
    } else {
      final employeeIDNumberRegex = RegExp(r"^[a-zA-Z0-9\s]*$");
      if (!employeeIDNumberRegex.hasMatch(value)) {
        return Strings.employeeIDNumberInvalid;
      }
    }
    return null;
  }

  static String? validateEmployeeAddress(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.employeeAddressEmpty;
    } else {
      final employeeAddressRegex = RegExp(r"^[a-zA-Z0-9\s,'./\-]*$");
      if (!employeeAddressRegex.hasMatch(value)) {
        return Strings.employeeAddressInvalid;
      }
    }
    return null;
  }

  static String? validateEmployeeReligion(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.employeeReligionEmpty;
    } else {
      final employeeReligionRegex = RegExp(r"^[a-zA-Z\s]*$");
      if (!employeeReligionRegex.hasMatch(value)) {
        return Strings.employeeReligionInvalid;
      }
    }
    return null;
  }

  static String? validateCorrection(String? progressType,
      String? activity) {
    if (activity == null || activity.isEmpty) {
      return Strings.pleaseFillWorkActivity;
    }

    if (progressType == null || progressType.isEmpty) {
      return Strings.pleaseSelectWorkProgress;
    }

    return null;
  }

  static String? validateSubmissionType(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.submissionTypeEmpty;
    }
    return null;
  }

  static String? validateSubmissionStartDate(String? startDate, String? endDate) {

    if (startDate == null || startDate.isEmpty) {
      return Strings.submissionStartDateEmpty;
    }

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    DateTime start = dateFormat.parse(startDate);
    DateTime end = dateFormat.parse(endDate!);

    if (start.isAfter(end)) {
      return Strings.submissionStartDateAfterEndDate;
    }


    return null;
  }

  static String? validateSubmissionEndDate(String? startDate, String? endDate) {

    if (endDate == null || endDate.isEmpty) {
      return Strings.submissionEndDateEmpty;
    }

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    DateTime start = dateFormat.parse(startDate!);
    DateTime end = dateFormat.parse(endDate);

    if (end.isBefore(start)) {
      return Strings.submissionEndDateBeforeStartDate;
    }

    return null;
  }

  static String? validateSubmissionDescription(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.submissionDescriptionEmpty;
    } else if (value.length < 10) {
      return Strings.submissionDescriptionShort;
    }
    return null;
  }
}
