import 'package:flutter/material.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';

import '../../resources/string_manger.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState implements FlowState {
  final StateRendererType stateRendererType;
  final String message;
  LoadingState(
      {required this.stateRendererType, this.message = StringManger.loading});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState implements FlowState {
  final StateRendererType stateRendererType;
  final String message;
  ErrorState({required this.stateRendererType, required this.message});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class EmptyState implements FlowState {
  EmptyState();
  @override
  String getMessage() => AppConstants.empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyFullScreenState;
}

class ContentState implements FlowState {
  ContentState();
  @override
  String getMessage() => AppConstants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

extension FlowStateExtension on FlowState {
  Widget getWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.loadingPopupState) {
          showPopup(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryFunction: retryActionFunction,
          );
        }

      case ErrorState:
        if (getStateRendererType() == StateRendererType.errorPopupState) {
          dismissDialog(context);
          showPopup(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          dismissDialog(context);
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryFunction: retryActionFunction,
          );
        }
      case EmptyState:
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          retryFunction: retryActionFunction,
        );
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;

      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  bool _isCurrentDialog(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialog(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
                stateRendererType: stateRendererType,
                message: message,
                retryFunction: () {},
              ));
    });
  }
}
