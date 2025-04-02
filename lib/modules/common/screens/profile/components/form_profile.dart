import 'package:cinco_minutos_meditacao/modules/authentication/shared/helpers/validators.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/user_request.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/text_field_input.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';

class FormProfile extends StatefulWidget {
  /// Função de registro
  Function onRegister;

  /// Modelo da tela
  ProfileModel profileModel;

  /// Função de seleção de país
  Function onSelectedCountry;

  /// - [key] : Chave de identificação do widget
  /// - [onRegister] : Mensagem de erro de e-mail inválido
  /// - [profileModel] : Modelo da tela
  /// - [onSelectedCountry] : Função de seleção de país
  /// construtor
  FormProfile({
    super.key,
    required this.onRegister,
    required this.profileModel,
    required this.onSelectedCountry,
  });

  @override
  State<FormProfile> createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  int? _selectedDay;
  int? _selectedMonth;
  int? _selectedYear;

  final List<String> listGender = ['Masculino', 'Feminino'];
  String? selectedValueGender = 'Feminino';

  ValueNotifier<List<String>> countryNotifier = ValueNotifier([]);
  List<String> listCountries = ['Brazil'];
  String? selectedValueCounty = 'Brazil';
  int? selectedIdCounty = 0;

  ValueNotifier<List<String>> statesNotifier = ValueNotifier([]);
  List<String> listStates = ['São Paulo'];
  String? selectedValueStates = 'São Paulo';
  int? selectedIdState = 0;

  @override
  void initState() {
    parseData();

    super.initState();
  }

  void parseData() {
    nameController.text =
        widget.profileModel.userResponse?.name.split(" ").first ?? '';
    lastNameController.text =
        widget.profileModel.userResponse?.name.split(" ").last ?? '';
    emailController.text = widget.profileModel.userResponse?.email ?? '';

    listCountries = widget.profileModel.countryResponse!.countries!
        .map((item) => item.name as String)
        .toList();

    listStates = widget.profileModel.statesResponse!.states!
        .map((item) => item.name as String)
        .toList();

    if (widget.profileModel.userResponse!.state != null) {
      selectedValueCounty =
          widget.profileModel.userResponse!.state!.country.name;
      selectedIdCounty = widget.profileModel.userResponse!.state!.country.id;

      selectedValueStates = widget.profileModel.userResponse!.state!.name;
      selectedIdState = widget.profileModel.userResponse!.state!.id;
    } else {
      for (var element in widget.profileModel.countryResponse!.countries!) {
        if (element.name == selectedValueCounty) {
          selectedIdCounty = element.id;
        }
      }
      for (var element in widget.profileModel.statesResponse!.states!) {
        if (element.name == selectedValueStates) {
          selectedIdState = element.id;
        }
      }
    }

    statesNotifier.value = listStates;
    countryNotifier.value = listCountries;

    if (widget.profileModel.userResponse?.birthdate != null) {
      List<String> date =
          widget.profileModel.userResponse!.birthdate!.split("-");
      _selectedDay = int.parse(date[2]);
      _selectedMonth = int.parse(date[1]);
      _selectedYear = int.parse(date[0]);
    }

    if (widget.profileModel.userResponse?.genre != null) {
      selectedValueGender = widget.profileModel.userResponse!.genre;
    }
  }

  @override
  void didUpdateWidget(covariant FormProfile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.profileModel.statesResponse != null) {
      listStates = widget.profileModel.statesResponse!.states!
          .map((item) => item.name as String)
          .toList();

      selectedValueStates = listStates.first;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidate,
      child: Container(
        padding: const EdgeInsets.only(top: 21, bottom: 18),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              hintText: CommonStrings.of(context).profileFormName,
              controller: nameController,
              label: AuthenticationStrings.of(context).name,
              validator: (value) => Validators.required(context, value),
            ),
            const SizedBox(height: 9),
            _buildTextField(
              hintText: CommonStrings.of(context).profileFormLastName,
              controller: lastNameController,
              label: CommonStrings.of(context).profileFormLastName,
              validator: (value) => Validators.required(context, value),
            ),
            const SizedBox(height: 9),
            _buildTextField(
              hintText: AuthenticationStrings.of(context).exampleEmail,
              controller: emailController,
              label: AuthenticationStrings.of(context).email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validators.email(context, value),
            ),
            const SizedBox(height: 9),
            _buildDropBoxBirth(),
            const SizedBox(height: 9),
            _buildDropBox(
              label: CommonStrings.of(context).gender,
              list: listGender,
              selectedValue: selectedValueGender,
              onChanged: (String value) {
                setState(() {
                  selectedValueGender = value;
                });
              },
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ValueListenableBuilder<List<String>>(
                    valueListenable: countryNotifier,
                    builder: (BuildContext context, List<String> value,
                        Widget? child) {
                      return _buildDropBox(
                        label: CommonStrings.of(context).whereYouLive,
                        list: value,
                        selectedValue: selectedValueCounty,
                        onChanged: (String value) {
                          widget.profileModel.countryResponse!.countries!
                              .forEach((element) async {
                            if (element.name == value) {
                              List<String> states =
                                  await widget.onSelectedCountry(element.id);
                              updateStates(states);

                              selectedIdCounty = element.id;
                              selectedValueCounty = value;

                              List<String> listCountries = widget
                                  .profileModel.countryResponse!.countries!
                                  .map((item) => item.name as String)
                                  .toList();
                              updateCountry(listCountries, value);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: ValueListenableBuilder<List<String>>(
                      valueListenable: statesNotifier,
                      builder: (BuildContext context, List<String> states,
                          Widget? child) {
                        return _buildDropBox(
                          list: states,
                          selectedValue: selectedValueStates,
                          onChanged: (String value) {
                            for (var element in widget.profileModel.statesResponse!.states!) {
                              if (element.name == value) {
                                setState(() {
                                  selectedIdState = element.id;
                                  selectedValueStates = value;
                                });
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            _buildSave(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFieldInput(
      hintText: hintText,
      controller: controller,
      keyboardType: keyboardType,
      label: label,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      border: _buildOutlineInputBorderDefault(),
      labelStyle: _buildTextStyleDefault(),
      validator: validator,
    );
  }

  Widget _buildDropBox({
    String? label,
    required List<String> list,
    String? selectedValue,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label, style: _buildTextStyleDefault()),
          const SizedBox(height: 5),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          decoration: _buildBoxDecorationDropBoxDefault(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.brainstemGrey,
              ),
              borderRadius: BorderRadius.circular(12),
              dropdownColor: AppColors.white,
              iconSize: 24,
              elevation: 16,
              style: _buildTextStyleDropBoxDefault(),
              onChanged: (String? newValue) => onChanged(newValue!),
              items: list
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: _buildTextStyleDropBoxDefault(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropBoxBirth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CommonStrings.of(context).dateBirth,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.frankBlue,
          ),
        ),
        const SizedBox(height: 5),
        DropdownDatePicker(
          locale: CommonStrings.of(context).datePickerLocation,
          dateformatorder: OrderFormat.DMY,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.brainstemGrey,
          ),
          hintDay: CommonStrings.of(context).day,
          hintMonth: CommonStrings.of(context).month,
          hintYear: CommonStrings.of(context).year,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.brainstemGrey,
          ),
          boxDecoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          dayFlex: 2,
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            border: _buildOutlineInputBorderDefault(),
          ),
          isFormValidator: true,
          startYear: 1900,
          endYear: DateTime.now().year,
          width: 7,
          selectedDay: _selectedDay,
          selectedMonth: _selectedMonth,
          selectedYear: _selectedYear,
          onChangedDay: (value) {
            setState(() {
              _selectedDay = int.parse(value!);
            });
          },
          onChangedMonth: (value) {
            setState(() {
              _selectedMonth = int.parse(value!);
            });
          },
          onChangedYear: (value) {
            setState(() {
              _selectedYear = int.parse(value!);
            });
          },
        ),
      ],
    );
  }

  Widget _buildSave() {
    return Column(
      children: [
        IconLabelButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              UserRequest user = UserRequest(
                widget.profileModel.userResponse!.id,
                "${nameController.text} ${lastNameController.text}",
                emailController.text,
                selectedValueGender!,
                "$_selectedYear-$_selectedMonth-$_selectedDay",
                selectedIdState,
              );

              widget.onRegister(user);
            }
          },
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.blueMana,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.germanderSpeedwell,
          ),
          label: Text(
            CommonStrings.of(context).profileLabelButton,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _buildTextStyleDefault() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.frankBlue,
    );
  }

  OutlineInputBorder _buildOutlineInputBorderDefault() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.brainstemGrey,
        width: 1,
      ),
    );
  }

  TextStyle _buildTextStyleDropBoxDefault() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.brainstemGrey,
    );
  }

  BoxDecoration _buildBoxDecorationDropBoxDefault() {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.brainstemGrey,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.white,
    );
  }

  void updateStates(List<String> newStates) {
    selectedValueStates = newStates.first; // Atualize o valor selecionado
    statesNotifier.value = newStates; // Atualize o ValueNotifier
  }

  void updateCountry(List<String> newCountry, String country) {
    selectedValueCounty = country; // Atualize o ValueNotifier
    countryNotifier.value = newCountry; // Atualize o ValueNotifier
  }
}
