const _authErrorMessage = 'Authorization error, try again.';
const _defaultErrorMessage =
    'Something went wrong we are already working on it.';

enum DaylogError {
  authError(_authErrorMessage),
  deafultError(_defaultErrorMessage);

  const DaylogError(this.message);

  final String message;
}
