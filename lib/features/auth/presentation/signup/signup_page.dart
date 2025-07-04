import 'dart:io';

import 'package:dio/dio.dart';
import 'package:amnak/core/view/widgets/custom_dropdown_field.dart';
import 'package:amnak/core/view/widgets/custom_image_form_fileld.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/core/view/widgets/rounded_container.dart';
import 'package:amnak/features/auth/presentation/cubit.dart';
import 'package:intl/intl.dart';

import '../../../../../export.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = sl<AuthCubit>();

  final fNameTextController = TextEditingController();
  final lNameTextController = TextEditingController();

  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final idTextController = TextEditingController();
  final qualificationsTextController = TextEditingController();

  final birthDateTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final experienceYearsTextController = TextEditingController();
  final passTextController = TextEditingController();

  late double inputWidth;
  late String gender = '';

  final formKey = GlobalKey<FormState>();
  File? image;

  @override
  void initState() {
    super.initState();
    inputWidth = (1.sw - 40) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(hasNotifications: false),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      context.t.registerNew,
                      style: context.textTheme.headlineMedium,
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: inputWidth,
                          child: TextInput(
                            autofillHints: const [AutofillHints.name],
                            controller: fNameTextController,
                            inputType: TextInputType.name,
                            hint: context.t.firstName,
                            validate: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : context.t.required;
                            },
                          ),
                        ),
                        SizedBox(
                          width: inputWidth,
                          child: TextInput(
                            autofillHints: const [AutofillHints.name],
                            controller: lNameTextController,
                            inputType: TextInputType.name,
                            hint: context.t.lastName,
                            validate: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : context.t.required;
                            },
                          ),
                        ),
                      ],
                    ),
                    10.heightBox,
                    TextInput(
                      autofillHints: const [AutofillHints.email],
                      controller: emailTextController,
                      inputType: TextInputType.emailAddress,
                      hint: context.t.email,
                      validate: (value) {
                        return isEmail(value) ? null : context.t.msErrorEmail;
                      },
                    ),
                    10.h.heightBox,
                    PasswordInput(
                      controller: passTextController,
                      hint: context.t.password,
                      validate: (value) {
                        return passTextController.text.length > 4
                            ? null
                            : context.t.enterValidPass;
                      },
                    ),
                    10.heightBox,
                    TextInput(
                      controller: phoneTextController,
                      inputType: TextInputType.phone,
                      hint: context.t.phone,
                      validate: (value) {
                        return value!.length > 1 ? null : context.t.required;
                      },
                    ),
                    10.heightBox,
                    TextInput(
                      controller: idTextController,
                      inputType: TextInputType.number,
                      hint: context.t.idNumber,
                      validate: (value) {
                        return value!.length > 1 ? null : context.t.required;
                      },
                    ),
                    10.h.heightBox,
                    TextInput(
                      controller: qualificationsTextController,
                      hint: context.t.qualifications,
                      validate: (value) {
                        return value!.length > 1 ? null : context.t.required;
                      },
                    ),
                    10.h.heightBox,
                    TextInput(
                      controller: weightTextController,
                      inputType: TextInputType.number,
                      hint: context.t.enterWeight,
                      validate: (value) {
                        return value!.isNotEmpty ? null : context.t.required;
                      },
                    ),
                    10.h.heightBox,
                    TextInput(
                      controller: heightTextController,
                      inputType: TextInputType.number,
                      hint: context.t.enterLength,
                      validate: (value) {
                        return value!.isNotEmpty ? null : context.t.required;
                      },
                    ),
                    10.h.heightBox,
                    TextInput(
                      controller: experienceYearsTextController,
                      inputType: TextInputType.number,
                      hint: context.t.numberOfExperienceYears,
                      validate: (value) {
                        return value!.isNotEmpty ? null : context.t.required;
                      },
                    ),
                    10.h.heightBox,
                    CustomDropdownFormField<String>(
                      hint: context.t.enterGender,
                      validator: (value) =>
                          value == null ? context.t.required : null,
                      onChanged: (value) {
                        gender = value!;
                      },
                      items: [context.t.male, context.t.female],
                    ),
                    10.h.heightBox,
                    TextInput(
                      disableInput: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().subtract(const Duration(
                            days: 365 * 20,
                          )),
                          firstDate: DateTime(1930),
                          lastDate: DateTime.now().subtract(const Duration(
                            days: 365 * 10,
                          )),
                        );
                        if (date != null) {
                          birthDateTextController.text =
                              DateFormat('yyyy-MM-dd').format(date);
                        }
                      },
                      controller: birthDateTextController,
                      hint: context.t.birthDate,
                      validate: (value) =>
                          value!.isNotEmpty ? null : context.t.required,
                    ),
                    10.h.heightBox,
                    CustomImageFormField(
                      title: context.t.idImage,
                      validator: (value) =>
                          image != null ? null : context.t.required,
                      onChanged: (value) => image = value,
                    ),
                    10.h.heightBox,
                    RoundedCornerLoadingButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          FormData formData;
                          String? fileName = image?.path.split('/').last;
                          formData = FormData.fromMap({
                            'latitude':  0.0,
                            'longitude':  0.0,
                            'email': emailTextController.text,
                            'password': passTextController.text,
                            'password_confirmation': passTextController.text,
                            'first_name': fNameTextController.text,
                            'last_name': lNameTextController.text,
                            'phone': phoneTextController.text,
                            'national_id': idTextController.text,
                            'qualifications': qualificationsTextController.text,
                            'weight': weightTextController.text,
                            "date_of_birth": birthDateTextController.text,
                            'height': heightTextController.text,
                            'no_experience_years':
                                experienceYearsTextController.text,
                            'gender': gender,
                            'id_image': [
                              await MultipartFile.fromFile(image!.path,
                                  filename: fileName)
                            ],
                          });
                          final res = await controller.signup(formData);
                          if (res != null) {
                            context.goNamed(Routes.home);
                          }
                        }
                      },
                      text: context.t.register,
                    ),
                    30.h.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
