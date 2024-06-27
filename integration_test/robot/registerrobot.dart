
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class Registerrobot{
  final WidgetTester tester;
  Registerrobot(this.tester);
   Future<void> setTextFieldEmail() async {
    final emailTextFieldFinder = find.byKey(const Key('emailRegister'));
    await tester.ensureVisible(emailTextFieldFinder);
    await tester.enterText(emailTextFieldFinder, "mucharomtzaka@yahoo.co.id");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  } 

  Future<void> setTextFieldUsername() async {
    final usernameTextFieldFinder = find.byKey(const Key('usernameRegister'));
    await tester.ensureVisible(usernameTextFieldFinder);
    await tester.enterText(usernameTextFieldFinder, "mucharomtzaka");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

   Future<void> setTextFieldPassword() async {
    final passwordTextFieldFinder = find.byKey(const Key('passwordRegister'));
    await tester.ensureVisible(passwordTextFieldFinder);
    await tester.enterText(passwordTextFieldFinder, "12345678");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> setConfirmPassword() async {
    final passwordConfirmTextFieldFinder = find.byKey(const Key('confirmRegister'));
    await tester.ensureVisible(passwordConfirmTextFieldFinder);
    await tester.enterText(passwordConfirmTextFieldFinder, "12345678");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> clickNavigationRegisterButtonet() async {
    final registerButtonFinder = find.byKey(const Key('btnRegistertext'));
    await tester.ensureVisible(registerButtonFinder);
    await tester.tap(registerButtonFinder);
  }

  Future<void> clickNavigationLoginButtonet() async {
    final registerButtonFinder = find.byKey(const Key('LoginRegister'));
    await tester.ensureVisible(registerButtonFinder);
    await tester.tap(registerButtonFinder);
    await tester.pumpAndSettle();
  }

}