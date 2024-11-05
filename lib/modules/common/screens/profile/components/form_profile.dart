import 'package:cinco_minutos_meditacao/modules/authentication/shared/helpers/validators.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
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

  /// - [key] : Chave de identificação do widget
  /// - [onRegister] : Mensagem de erro de e-mail inválido
  /// construtor
  FormProfile({super.key, required this.onRegister});

  @override
  State<FormProfile> createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  /// Chave do formulário
  final _formKey = GlobalKey<FormState>();

  /// Controlador do campo de texto de e-mail
  final TextEditingController emailController = TextEditingController();

  /// Controlador do campo de texto de nome
  final TextEditingController nameController = TextEditingController();

  /// Controlador do campo de texto de nome
  final TextEditingController lastNameController = TextEditingController();

  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  int _selectedDay = 14;
  int _selectedMonth = 2;
  int _selectedYear = 1993;

  final List<String> listGender = [
    'Masculino',
    'Feminino',
  ];
  String? selectedValueGender = "Feminino";

  final List<String> listState = [
    'BR',
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Distrito Federal',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Roraima',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins',
  ];
  String? selectedValueStates = "BR";

  @override
  void initState() {
    super.initState();
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
            TextFieldInput(
              hintText: CommonStrings.of(context).profileFormName,
              controller: nameController,
              keyboardType: TextInputType.text,
              label: AuthenticationStrings.of(context).name,
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              border: buildOutlineInputBorderDefault(),
              labelStyle: buildTextStyleDefault(),
              validator: (value) => Validators.required(context, value),
            ),
            const SizedBox(height: 9),
            TextFieldInput(
              hintText: CommonStrings.of(context).profileFormLastName,
              controller: lastNameController,
              keyboardType: TextInputType.text,
              label: CommonStrings.of(context).profileFormLastName,
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              border: buildOutlineInputBorderDefault(),
              labelStyle: buildTextStyleDefault(),
              validator: (value) => Validators.required(context, value),
            ),
            const SizedBox(height: 9),
            TextFieldInput(
              hintText: AuthenticationStrings.of(context).exampleEmail,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              label: AuthenticationStrings.of(context).email,
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              border: buildOutlineInputBorderDefault(),
              labelStyle: buildTextStyleDefault(),
              validator: (value) => Validators.email(context, value),
            ),
            const SizedBox(height: 9),
            buildDropBoxNasc(),
            const SizedBox(height: 9),
            buildDropBox("Gênero", listGender, selectedValueGender,
                (String value) {
              setState(() {
                selectedValueGender = value;
              });
            }),
            const SizedBox(height: 9),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: buildDropBox(
                      "Onde Reside", listState, selectedValueStates,
                      (String value) {
                    setState(() {
                      selectedValueStates = value;
                    });
                  }),
                ),
                const SizedBox(width: 7),
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: buildDropBox(null, listGender, selectedValueGender,
                      (String value) {
                    setState(() {
                      selectedValueGender = value;
                    });
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildQuestionsLogin(),
          ],
        ),
      ),
    );
  }

  Column buildDropBox(String? title, List<String> list, String? selectedValue,
      Function onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: buildTextStyleDefault(),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          decoration: buildBoxDecorationDropBoxDefault(),
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
              style: buildTextStyleDropBoxDefault(),
              onChanged: (String? newValue) => onChange(newValue!),
              items: list
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: buildTextStyleDropBoxDefault(),
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

  TextStyle buildTextStyleDropBoxDefault() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.brainstemGrey,
    );
  }

  BoxDecoration buildBoxDecorationDropBoxDefault() {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.brainstemGrey,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.white,
    );
  }

  Column buildDropBoxNasc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data de Nascimento",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.frankBlue,
          ),
        ),
        const SizedBox(height: 5),
        DropdownDatePicker(
          locale: "pt_BR",
          dateformatorder: OrderFormat.DMY,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.brainstemGrey,
          ),
          hintDay: 'Dia',
          hintMonth: 'Mês',
          hintYear: 'Ano',
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
            border: buildOutlineInputBorderDefault(),
          ),
          isFormValidator: true,
          startYear: 1900,
          endYear: 2020,
          width: 7,
          // selectedDay: _selectedDay,
          // selectedMonth: _selectedMonth,
          // selectedYear: _selectedYear,
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
          }, // optional
        ),
      ],
    );
  }

  TextStyle buildTextStyleDefault() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.frankBlue,
    );
  }

  OutlineInputBorder buildOutlineInputBorderDefault() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.brainstemGrey,
        width: 1,
      ),
    );
  }

  Column buildQuestionsLogin() {
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
            color: AppColors.blueMana,
          ),
          label: Text(
            AuthenticationStrings.of(context).createAccount,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.brilliance2,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
