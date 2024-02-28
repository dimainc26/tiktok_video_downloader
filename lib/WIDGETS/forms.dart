import 'package:tikidown/CORE/core.dart';

// Nom prenom etc.
class HighFormField extends StatelessWidget {
  final String img = "images/";

  const HighFormField({
    required this.hoverText,
    required this.title,
    required this.icon,
    required this.isPassword,
    // required this.initialValue,
    // required this.onChanged,
    required this.validator,
    required this.keyboardType,
    required this.xcontroller,
    Key? key,
  }) : super(key: key);

  // final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final String hoverText;
  final String title;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  // final String? initialValue;
  final TextEditingController xcontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: TextFormField(
        // initialValue: initialValue,

        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          letterSpacing: .8,
          fontStyle: FontStyle.normal,
        ),
        keyboardType: keyboardType,
        controller: xcontroller,
        // autofocus: false,
        // onChanged: onChanged,
        validator: validator,
        // inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: .8,
            fontStyle: FontStyle.normal,
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: primaryColor)),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(icon),
          hintText: hoverText,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: .8,
            fontStyle: FontStyle.normal,
          ),
        ),
        obscureText: isPassword,
      ),
    );
  }
}

// Numero recharge montant
class RechargeFormField extends StatelessWidget {
  final String img = "images/";

  const RechargeFormField({
    required this.hoverText,
    required this.title,
    required this.icon,
    // required this.onChanged,
    required this.validator,
    required this.xcontroller,
    required this.inputFormatters,
    Key? key,
  }) : super(key: key);

  // final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final String hoverText;
  final String title;
  final IconData icon;
  final TextEditingController xcontroller;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34.0),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          letterSpacing: .8,
          fontStyle: FontStyle.normal,
        ),
        keyboardType: TextInputType.number,
        controller: xcontroller,
        autofocus: false,
        // onChanged: onChanged,
        validator: validator,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: .8,
            fontStyle: FontStyle.normal,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.green.shade800)),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.green.shade800,
              width: 2,
            ),
          ),
          prefixIcon: Icon(icon),
          hintText: hoverText,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: .8,
            fontStyle: FontStyle.normal,
          ),
        ),
        obscureText: false,
      ),
    );
  }
}
