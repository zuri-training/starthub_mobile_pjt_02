import 'dart:async';

import 'package:flutter/material.dart';

class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  // Register a callback function. Typically to show dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  // Calls the dialog listener and return a Future that will wait for dialogComplete
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));
    return _dialogCompleter.future;
  }

  // Show a Confirmation dialog
  Future<DialogResponse> showConfirmationDialog({
    String title,
    String description,
    String confirmationTitle = 'Ok',
    String cancelTitle = 'Cancel',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle, ));
    return _dialogCompleter.future;
  }

  // Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}

class DialogRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String cancelTitle;

  DialogRequest(
      {@required this.title,
      @required this.description,
      @required this.buttonTitle,
      this.cancelTitle});
}

class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  DialogResponse({this.fieldOne, this.fieldTwo, this.confirmed});
}
