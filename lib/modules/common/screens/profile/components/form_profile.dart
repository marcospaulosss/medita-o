import 'package:cinco_minutos_meditacao/modules/authentication/shared/helpers/validators.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
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
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  int? _selectedDay;
  int? _selectedMonth;
  int? _selectedYear;

  final List<String> listGender = ['Masculino', 'Feminino'];
  String? selectedValueGender = 'Feminino';

  List<String> listCountries = ['Brazil'];
  String? selectedValueCounty = 'Brazil';
  int? selectedIdCounty = 0;

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

    widget.profileModel.countryResponse!.countries!.forEach((element) {
      if (element.name == selectedValueCounty) {
        selectedIdCounty = element.id;
        widget.onSelectedCountry(selectedIdCounty);
      }
    });

    if (widget.profileModel.userResponse?.birthdate != null) {
      _selectedDay = DateTime.now().day;
      _selectedMonth = DateTime.now().month;
      _selectedYear = DateTime.now().year;
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
                  child: _buildDropBox(
                    label: CommonStrings.of(context).whereYouLive,
                    list: listCountries,
                    selectedValue: selectedValueCounty,
                    onChanged: (String value) {
                      widget.profileModel.countryResponse!.countries!
                          .forEach((element) {
                        if (element.name == value) {
                          widget.onSelectedCountry(element.id);

                          setState(() {
                            selectedIdCounty = element.id;
                            selectedValueCounty = value;
                          });
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: _buildDropBox(
                      list: listStates,
                      selectedValue: selectedValueStates,
                      onChanged: (String value) {
                        widget.profileModel.statesResponse!.states!
                            .forEach((element) {
                          if (element.name == value) {
                            setState(() {
                              selectedIdState = element.id;
                              selectedValueStates = value;
                            });
                          }
                        });
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
              widget.onRegister(
                nameController.text,
                emailController.text,
                lastNameController.text,
              );
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
}
