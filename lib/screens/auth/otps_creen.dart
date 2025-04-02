import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'userregistrationscreen.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Estado para mostrar el indicador de carga

  void _verifyCode() async {
    setState(() => _isLoading = true); // Activar carga
    String smsCode = _otpController.text.trim();

    if (smsCode.isEmpty || smsCode.length < 6) {
      Fluttertoast.showToast(msg: "Ingrese un código válido de 6 dígitos");
      setState(() => _isLoading = false);
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserRegistrationScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Código incorrecto, intenta de nuevo";
      if (e.code == 'invalid-verification-code') {
        errorMessage =
            "Código inválido, revisa el mensaje y vuelve a intentarlo";
      }
      Fluttertoast.showToast(msg: errorMessage);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }

    setState(() => _isLoading = false); // Desactivar carga
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verificación OTP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              autofocus: true, // Autoenfoque
              decoration: const InputDecoration(
                labelText: 'Ingrese el código',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _verifyCode(),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _verifyCode,
                  child: const Text('Verificar'),
                ),
          ],
        ),
      ),
    );
  }
}
