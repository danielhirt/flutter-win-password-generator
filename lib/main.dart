import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'random_password_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _isWithLetters = true;
  final bool _isWithUppercase = true;
  final bool _isWithNumbers = true;
  final bool _isWithSpecial = true;
  final Color _color = Colors.blue;
  final TextEditingController _passwordLength = TextEditingController();
  final password = RandomPasswordGenerator();

  double _numberCharPassword = 16;
  String newPassword = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Random Password Generator'),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            TextButton(
                onPressed: () {
                  if (_passwordLength.text.trim().isNotEmpty) {
                    _numberCharPassword =
                        double.parse(_passwordLength.text.trim());
                  }

                  newPassword = password.randomPassword(
                      letters: _isWithLetters,
                      numbers: _isWithNumbers,
                      passwordLength: _numberCharPassword,
                      specialChar: _isWithSpecial,
                      uppercase: _isWithUppercase);

                  setState(() {});
                },
                child: Container(
                  color: Colors.redAccent,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Generate Password',
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            if (newPassword.isNotEmpty)
              const SizedBox(
                height: 20,
              ),
            const Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Your password:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )),
            Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectableText(
                  newPassword,
                  style: TextStyle(
                      color: _color, fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            )),
            const SizedBox(
              height: 40,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                icon: const Icon(Icons.copy),
                iconSize: 50.0,
                onPressed: _copyToClipboard,
              ),
            )),
            const Text('Copy to clipboard',
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ],
        )),
      ),
    );
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: newPassword));
  }
}
