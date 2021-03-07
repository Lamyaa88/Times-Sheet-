import 'package:timessheet/file_export.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  String _errorMessage(String str) {
    switch (hint) {
      case 'Name':
        return 'Name is empty !';
      case 'Email':
        return 'Email is empty !';
      case 'Phone':
        return 'Phone is empty !';
      case 'Password':
        return 'Password is empty !';
    }
  }

  CustomTextField(
      {@required this.onClick, @required this.icon, @required this.hint});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(height: height*.09,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return _errorMessage(hint);
              // ignore: missing_return
            }
          },
          onSaved: onClick,
          obscureText: hint == 'Password' ? true : false,
          cursorColor: kMainColor,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: kMainColor),
            prefixIcon: Icon(
              icon,size:height*.03,
              color: kMainColor,
            ),
            filled: true,
            fillColor: kSecondaryColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}