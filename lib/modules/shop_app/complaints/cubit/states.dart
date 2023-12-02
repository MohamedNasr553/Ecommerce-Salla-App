abstract class ComplaintsStates{}

class ComplaintsInitialState extends ComplaintsStates{}

class ComplaintsLoadingState extends ComplaintsStates{}

class ComplaintsSuccessState extends ComplaintsStates{}

class ComplaintsErrorState extends ComplaintsStates{
  final String error;

  ComplaintsErrorState(this.error);
}
