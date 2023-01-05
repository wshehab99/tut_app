import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/presentation/resources/asset_manger.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

enum StateRendererType {
  //popup states
  loadingPopupState,
  errorPopupState,
  successPopupState,
  // full screen states
  loadingFullScreenState,
  errorFullScreenState,
  emptyFullScreenState,
  //content states
  contentState,
}

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    super.key,
    required this.stateRendererType,
    required this.message,
    this.retryFunction,
  });
  final StateRendererType stateRendererType;
  final String message;
  final Function? retryFunction;
  @override
  Widget build(BuildContext context) {
    return _getStateRendererWidget(stateRendererType, context, message);
  }

  Widget _getStateRendererWidget(StateRendererType stateRendererType,
      BuildContext context, String message) {
    switch (stateRendererType) {
      case StateRendererType.loadingPopupState:
        return _getPopupDialog(context: context, children: [
          _getAnimatedImage(
            JsonAssetManager.loading,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.errorPopupState:
        return _getPopupDialog(context: context, children: [
          _getAnimatedImage(
            JsonAssetManager.error,
          ),
          _getMessage(message, context),
          _getRetryButton(context, StringManger.cancel),
        ]);
      case StateRendererType.successPopupState:
        return _getPopupDialog(context: context, children: [
          _getAnimatedImage(
            JsonAssetManager.success,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.loadingFullScreenState:
        return _getItemColumn(children: [
          _getAnimatedImage(
            JsonAssetManager.loading,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.errorFullScreenState:
        return _getItemColumn(children: [
          _getAnimatedImage(
            JsonAssetManager.error,
          ),
          _getMessage(message, context),
          _getRetryButton(context, StringManger.retryAgain),
        ]);
      case StateRendererType.emptyFullScreenState:
        return _getItemColumn(children: [
          _getAnimatedImage(
            JsonAssetManager.empty,
          ),
          _getMessage(message, context),
        ]);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getItemColumn(
      {required List<Widget> children,
      MainAxisSize mainAxisSize = MainAxisSize.max}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  _getPopupDialog(
      {required BuildContext context, required List<Widget> children}) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(
            SizeValuesManager.s14,
          ),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.black,
            ),
          ],
        ),
        child: _getDialogContent(context: context, children: children),
      ),
    );
  }

  _getDialogContent(
      {required BuildContext context, required List<Widget> children}) {
    return _getItemColumn(children: children, mainAxisSize: MainAxisSize.min);
  }

  Widget _getAnimatedImage(String jsonName) {
    return Lottie.asset(
      jsonName,
      height: SizeValuesManager.s100,
      width: SizeValuesManager.s100,
    );
  }

  Widget _getMessage(message, context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _getRetryButton(context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PaddingValuesManager.p28,
          vertical: PaddingValuesManager.p14),
      child: SizedBox(
          width: double.infinity,
          height: SizeValuesManager.s40,
          child: ElevatedButton(
              onPressed:
                  stateRendererType == StateRendererType.errorFullScreenState
                      ? retryFunction!.call()
                      : () {
                          Navigator.pop(context);
                        },
              child: Text(text))),
    );
  }
}
