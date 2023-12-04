abstract class FAQsStates{}

class FAQsInitialState extends FAQsStates{}

class FAQsChangeSelection extends FAQsStates{}

class FAQsLoadingState extends FAQsStates{}

class FAQsSuccessState extends FAQsStates{}

class FAQsErrorState extends FAQsStates{
  final String error;

  FAQsErrorState(this.error);
}