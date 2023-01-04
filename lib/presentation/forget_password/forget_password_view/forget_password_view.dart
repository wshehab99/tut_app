import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view_model/forget_password_view_model.dart';

import '../../resources/asset_manger.dart';
import '../../resources/string_manger.dart';
import '../../resources/value_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final ForgetPasswordViewModel _forgetPasswordViewModel =
      instance<ForgetPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  _bind() {
    _emailController.addListener(() {
      _forgetPasswordViewModel.setEmail(_emailController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _forgetPasswordViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getWidget(context, _getContent(), () {}) ??
              _getContent();
        },
      ),
    );
  }

  Widget _getContent() {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: SizeValuesManager.s100,
          ),
          Center(
            child: Image.asset(
              ImageAsset.splashLogo,
            ),
          ),
          const SizedBox(
            height: SizeValuesManager.s28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingValuesManager.p28),
            child: StreamBuilder<bool>(
                stream: _forgetPasswordViewModel.isEmailValid,
                builder: (context, snapshots) {
                  return TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: StringManger.email,
                      labelText: StringManger.email,
                      errorText: (snapshots.data ?? true)
                          ? null
                          : StringManger.emailError,
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: SizeValuesManager.s28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingValuesManager.p28),
            child: StreamBuilder<bool>(
                stream: _forgetPasswordViewModel.outputAreAllInputIsValid,
                builder: (context, snapshots) {
                  return SizedBox(
                    width: double.infinity,
                    height: SizeValuesManager.s40,
                    child: ElevatedButton(
                      onPressed: (snapshots.data ?? false)
                          ? () {
                              _forgetPasswordViewModel.forgetPassword();
                            }
                          : null,
                      child: const Text(StringManger.login),
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
