class AuthUserError implements Exception {
  final String message;
  final bool loggedOut;
  // final int errorCode;

  // this.errorCode,
  AuthUserError(this.message, [this.loggedOut = false]);
}
