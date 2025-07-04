import 'dart:io';

import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/core/view/widgets/profile_img_picker.dart';
import 'package:amnak/features/auth/presentation/settings/profile/profile_cubit.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../../../../../export.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final cubit = sl<ProfileCubit>();

  final GlobalKey<FormState> formKey = GlobalKey();
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final noExperienceYears = TextEditingController();
  final phoneTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final idTextController = TextEditingController();
  final birthDateTextController = TextEditingController();
  final qualificationsTextController = TextEditingController();
  File? profileImage;

  @override
  void initState() {
    super.initState();
    cubit.get();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    nameTextController.dispose();
    lastNameTextController.dispose();
    noExperienceYears.dispose();
    phoneTextController.dispose();
    weightTextController.dispose();
    heightTextController.dispose();
    idTextController.dispose();
    birthDateTextController.dispose();
    qualificationsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: CustomCubitBuilder<UserModel>(
                cubit: cubit,
                tryAgain: () => cubit.get(),
                onSuccess: (context, state) {
                  final user = state.data!;
                  nameTextController.text = user.firstName ?? '';
                  lastNameTextController.text = user.lastName ?? '';
                  emailTextController.text = user.email ?? '';
                  phoneTextController.text = (user.phone ?? '')
                      .replaceAll('+966', '')
                      .replaceAll('966', '');
                  idTextController.text = user.nationalId.toString();
                  weightTextController.text = user.weight.toString();
                  heightTextController.text = user.height.toString();
                  birthDateTextController.text = user.dateOfBirth ?? '';
                  qualificationsTextController.text =
                      user.qualificationsDescriptions ?? '';
                  noExperienceYears.text = user.noExperienceYears.toString();
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            context.t.personal_info,
                            style: context.textTheme.headlineMedium,
                          ),
                          12.h.heightBox,
                          ProfileImgPicker(
                            url: user.profileImage,
                            isEditable: true,
                            onChange: (file) async {
                              profileImage = file;
                            },
                          ),
                          12.h.heightBox,
                          TextInput(
                            autofillHints: const [AutofillHints.name],
                            controller: nameTextController,
                            inputType: TextInputType.name,
                            hint: context.t.firstName,
                            validate: (value) =>
                                value!.isNotEmpty ? null : context.t.required,
                          ),
                          12.h.heightBox,
                          TextInput(
                            autofillHints: const [AutofillHints.name],
                            controller: lastNameTextController,
                            inputType: TextInputType.name,
                            hint: context.t.lastName,
                            validate: (value) =>
                                value!.isNotEmpty ? null : context.t.required,
                          ),
                          12.h.heightBox,
                          TextInput(
                            controller: idTextController,
                            inputType: TextInputType.text,
                            hint: context.t.id,
                            validate: (value) =>
                                value!.isNotEmpty ? null : context.t.required,
                          ),
                          12.h.heightBox,
                          TextInput(
                            disableInput: true,
                            borderColor: kGreyShade,
                            autofillHints: const [AutofillHints.email],
                            controller: emailTextController,
                            inputType: TextInputType.emailAddress,
                            hint: context.t.email,
                            validate: (value) => value!.contains('@')
                                ? null
                                : context.t.msErrorEmail,
                          ),
                          12.h.heightBox,
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: TextInput(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('+966',
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                              ),
                              disableInput: false,
                              autofillHints: const [
                                AutofillHints.telephoneNumber
                              ],
                              controller: phoneTextController,
                              inputType: TextInputType.phone,
                              hint: context.t.phone,
                              validate: (value) =>
                                  value!.isNotEmpty ? null : context.t.required,
                            ),
                          ),
                          12.h.heightBox,
                          TextInput(
                            controller: weightTextController,
                            inputType: TextInputType.number,
                            hint: context.t.enterWeight,
                            validate: (value) =>
                                value!.isNotEmpty ? null : context.t.required,
                          ),
                          12.h.heightBox,
                          TextInput(
                            controller: heightTextController,
                            inputType: TextInputType.number,
                            hint: context.t.enterLength,
                            validate: (value) =>
                                value!.isNotEmpty ? null : context.t.required,
                          ),
                          12.h.heightBox,
                          TextInput(
                            controller: qualificationsTextController,
                            hint: context.t.qualifications,
                            validate: (value) =>
                                value!.isNotEmpty ? null : context.t.required,
                          ),
                          12.h.heightBox,
                          TextInput(
                            controller: noExperienceYears,
                            hint: context.t.numberOfExperienceYears,
                            validate: (value) =>
                                value!.isNotEmpty ? null : context.t.required,
                          ),
                          12.h.heightBox,
                          TextInput(
                            disableInput: true,
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.now().subtract(const Duration(
                                  days: 365 * 20,
                                )),
                                firstDate: DateTime(1930),
                                lastDate:
                                    DateTime.now().subtract(const Duration(
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
                          12.h.heightBox,
                          RoundedCornerLoadingButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.uploadProfileImage(profileImage, {
                                  'first_name': nameTextController.text.trim(),
                                  'last_name':
                                      lastNameTextController.text.trim(),
                                  'phone': phoneTextController.text.trim(),
                                  'qualifications':
                                      qualificationsTextController.text.trim(),
                                  'date_of_birth':
                                      birthDateTextController.text.trim(),
                                  'weight':
                                      weightTextController.text.trim().toInt,
                                  'height':
                                      heightTextController.text.trim().toInt,
                                  'national_id': idTextController.text.trim(),
                                  'no_experience_years':
                                      noExperienceYears.text.trim(),
                                });
                              }
                            },
                            text: context.t.updateAccount,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
