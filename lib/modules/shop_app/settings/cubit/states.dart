abstract class SettingsStates{}

class SettingInitialState extends SettingsStates{}

class SettingChangeSelection extends SettingsStates{}

class ContactLoadingState extends SettingsStates{}

class ContactSuccessState extends SettingsStates{}

class ContactErrorState extends SettingsStates{
  final String error;

  ContactErrorState(this.error);
}