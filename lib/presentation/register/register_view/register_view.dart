import 'dart:io';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_app/app/app_preferences.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/register/register_view_model/register_view_model.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

import '../../resources/asset_manger.dart';
import '../../resources/string_manger.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPref = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _phoneNumberEditingController =
      TextEditingController();

  void _bind() {
    _usernameEditingController.addListener(() {
      _registerViewModel.setUsername(_usernameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _registerViewModel.setEmail(_emailEditingController.text);
    });
    _passwordEditingController.addListener(() {
      _registerViewModel.setPassword(_passwordEditingController.text);
    });
    _phoneNumberEditingController.addListener(() {
      _registerViewModel.setPhoneNumber(_phoneNumberEditingController.text);
      _registerViewModel.isUserRegisterSuccessfully.stream.listen((isLogged) {
        if (isLogged) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _appPref.setLoggedInSuccessfully();

            Navigator.pushReplacementNamed(context, RoutesManager.mainRoute);
          });
        }
      });
    });
  }

  @override
  void initState() {
    _bind();
    _registerViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: SizeValuesManager.s0,
        iconTheme: const IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _registerViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getWidget(
                context,
                _getContent(),
                () {},
              ) ??
              _getContent();
        },
      ),
    );
  }

  Widget _getContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeValuesManager.s28, vertical: SizeValuesManager.s10),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageAsset.splashLogo,
              ),
              const SizedBox(
                height: SizeValuesManager.s18,
              ),
              StreamBuilder<bool>(
                  stream: _registerViewModel.isUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _usernameEditingController,
                      decoration: InputDecoration(
                        hintText: StringManger.username,
                        labelText: StringManger.username,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : StringManger.usernameError,
                      ),
                    );
                  }),
              const SizedBox(
                height: SizeValuesManager.s14,
              ),
              StreamBuilder<bool>(
                  stream: _registerViewModel.isEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailEditingController,
                      decoration: InputDecoration(
                        hintText: StringManger.email,
                        labelText: StringManger.email,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : StringManger.emailError,
                      ),
                    );
                  }),
              const SizedBox(
                height: SizeValuesManager.s14,
              ),
              StreamBuilder<bool>(
                  stream: _registerViewModel.isPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordEditingController,
                      decoration: InputDecoration(
                        hintText: StringManger.password,
                        labelText: StringManger.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : StringManger.passwordError,
                      ),
                    );
                  }),
              const SizedBox(
                height: SizeValuesManager.s14,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: StreamBuilder<CountryCode>(
                          stream: _registerViewModel.countryCode,
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () async {
                                _registerViewModel.setCountryCode(
                                  await const FlCountryCodePicker(
                                              favorites: ["EG", "YE", "SA"])
                                          .showPicker(
                                        context: context,
                                      ) ??
                                      const CountryCode(
                                        name: "EG",
                                        code: "EG",
                                        dialCode: "+20",
                                      ),
                                );
                              },
                              child: Container(
                                  height: SizeValuesManager.s50,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          SizeValuesManager.s10)),
                                  child: snapshot.data?.flagImage ??
                                      const CountryCode(
                                        name: "EG",
                                        code: "EG",
                                        dialCode: "+20",
                                      ).flagImage),
                            );
                          })),
                  const SizedBox(
                    width: SizeValuesManager.s10,
                  ),
                  Expanded(
                    flex: 4,
                    child: StreamBuilder<bool>(
                        stream: _registerViewModel.isPhoneNumberValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _phoneNumberEditingController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: StringManger.phoneNumber,
                              labelText: StringManger.phoneNumber,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : StringManger.phoneNumberError,
                            ),
                          );
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: SizeValuesManager.s14,
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(PaddingValuesManager.p8),
                  height: SizeValuesManager.s40,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.lightGrey),
                      borderRadius:
                          BorderRadius.circular(SizeValuesManager.s8)),
                  child: _getMediaWidget(context),
                ),
                onTap: () {
                  _showPicker(context);
                },
              ),
              const SizedBox(
                height: SizeValuesManager.s28,
              ),
              StreamBuilder<bool>(
                  stream: _registerViewModel.outputAreAllInputValid,
                  builder: (context, snapshots) {
                    return SizedBox(
                      width: double.infinity,
                      height: SizeValuesManager.s40,
                      child: ElevatedButton(
                        onPressed: (snapshots.data ?? false)
                            ? () async {
                                await _registerViewModel.register();
                              }
                            : null,
                        child: const Text(StringManger.register),
                      ),
                    );
                  }),
              const SizedBox(
                height: SizeValuesManager.s4,
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: PaddingValuesManager.p0)),
                ),
                child: Text(
                  StringManger.alreadyHaveAccount,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: SizeValuesManager.s28,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMediaWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            StringManger.profilePhoto,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Flexible(
          flex: 1,
          child: StreamBuilder<File>(
            stream: _registerViewModel.profilePhoto,
            builder: (context, snapshot) {
              return _getPickedImage(
                snapshot.data,
              );
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: SvgPicture.asset(ImageAsset.photoCamera),
        ),
      ],
    );
  }

  Widget _getPickedImage(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return const SizedBox();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.arrow_back_ios),
                title: const Text(StringManger.gallery),
                trailing: const Icon(Icons.photo),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_back_ios),
                title: const Text(StringManger.camera),
                trailing: const Icon(Icons.camera_alt_outlined),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
        });
  }

  _pickImage(ImageSource source) async {
    var value = await _imagePicker.pickImage(source: source);
    _registerViewModel.setProfilePhoto(File(value?.path ?? ""));
  }
}
