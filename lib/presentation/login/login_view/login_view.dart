import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/app/app_preferences.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/login/login_view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

import '../../resources/asset_manger.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppPreferences _appPref = instance<AppPreferences>();

  _bind() {
    _loginViewModel.init();
    _userNameController.addListener(
        () => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));
    _loginViewModel.isUserLoggedIn.stream.listen((isUserLoggedInSuccessfully) {
      if (isUserLoggedInSuccessfully) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPref.setLoggedInSuccessfully();
          Navigator.of(context).pushReplacementNamed(RoutesManager.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _loginViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getWidget(context, _getContent(), () {}) ??
                _getContent();
          }),
    );
  }

  Widget _getContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        child: Column(
          children: [
            const SizedBox(
              height: SizeValuesManager.s100,
            ),
            Center(
                child: Image.asset(
              ImageAsset.splashLogo,
            )),
            const SizedBox(
              height: SizeValuesManager.s28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingValuesManager.p28),
              child: StreamBuilder<bool>(
                  stream: _loginViewModel.isUserNameValid,
                  builder: (context, snapshots) {
                    return TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: StringManger.username.tr(),
                        labelText: StringManger.username.tr(),
                        errorText: (snapshots.data ?? true)
                            ? null
                            : StringManger.usernameError.tr(),
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
                  stream: _loginViewModel.isPasswordValid,
                  builder: (context, snapshots) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: StringManger.password.tr(),
                        labelText: StringManger.password.tr(),
                        errorText: (snapshots.data ?? true)
                            ? null
                            : StringManger.passwordError.tr(),
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
                  stream: _loginViewModel.outputAreAllInputsValid,
                  builder: (context, snapshots) {
                    return SizedBox(
                      width: double.infinity,
                      height: SizeValuesManager.s40,
                      child: ElevatedButton(
                        onPressed: (snapshots.data ?? false)
                            ? () {
                                _loginViewModel.login();
                              }
                            : null,
                        child: const Text(StringManger.login).tr(),
                      ),
                    );
                  }),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: PaddingValuesManager.p28,
                  right: PaddingValuesManager.p28,
                  top: PaddingValuesManager.p14,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          StringManger.forgetPassword.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesManager.forgetPasswordRoute);
                        },
                      ),
                      TextButton(
                        child: Text(
                          StringManger.notMember.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesManager.registerRoute);
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
