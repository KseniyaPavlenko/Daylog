const _authErrorMessage = 'Authorization error, try again.';
const _defaultErrorMessage = 'Something went wrong we are already working on it.';

enum ErrorState {
  empty(''),
  auth(_authErrorMessage),
  deafult(_defaultErrorMessage); // TODO(Kseniya): тут опечатка, но правильно он не даст записать
  // так как это слово зарезервировано, переименуй на common

  const ErrorState(this.message);

  final String message;

  bool get hasError => this != ErrorState.empty;
}
