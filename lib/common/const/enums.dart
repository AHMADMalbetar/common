enum BlocStatus { init, loading, success, failed }

enum Gender {
  male, female;
  factory Gender.fromJson(String gender){
    if(gender.toLowerCase() == Gender.male.toString()) {
      return Gender.male;
    } else {
      return Gender.female;
    }
  }
}