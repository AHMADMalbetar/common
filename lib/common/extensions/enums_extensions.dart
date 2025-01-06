import 'package:common/common/const/enums.dart';

extension GenderExtensions on Gender {
  String get isMale => this == Gender.male ? 'Male' : 'Female';
}
