
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class Registerrobot{
  final WidgetTester tester;
  Registerrobot(this.tester);
   Future<void> setTextFieldEmail() async {
    final emailTextFieldFinder = find.byKey(const Key('emailRegister'));
    expect(emailTextFieldFinder, findsOneWidget);
    await tester.ensureVisible(emailTextFieldFinder);
    await tester.enterText(emailTextFieldFinder, "mucharomtzaka@yahoo.co.id");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  } 

  Future<void> setTextFieldUsername() async {
    final usernameTextFieldFinder = find.byKey(const Key('usernameRegister'));
     expect(usernameTextFieldFinder, findsOneWidget);
    await tester.ensureVisible(usernameTextFieldFinder);
    await tester.enterText(usernameTextFieldFinder, "mucharomtzaka");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

   Future<void> setTextFieldPassword() async {
    final passwordTextFieldFinder = find.byKey(const Key('passwordRegister'));
    expect(passwordTextFieldFinder, findsOneWidget);
    await tester.ensureVisible(passwordTextFieldFinder);
    await tester.enterText(passwordTextFieldFinder, "12345678");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> setConfirmPassword() async {
    final passwordConfirmTextFieldFinder = find.byKey(const Key('confirmRegister'));
    expect(passwordConfirmTextFieldFinder, findsOneWidget);
    await tester.ensureVisible(passwordConfirmTextFieldFinder);
    await tester.enterText(passwordConfirmTextFieldFinder, "12345678");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> clickNavigationRegisterButtonet() async {
    final registerButtonFinder = find.byKey(const Key('btnRegistertext'));
    expect(registerButtonFinder, findsOneWidget);
    await tester.ensureVisible(registerButtonFinder);
    await tester.tap(registerButtonFinder);
  }

  Future<void> clickNavigationLoginButtonet() async {
    final loginButtonFinder = find.byKey(const Key('LoginRegister'));
    expect(loginButtonFinder, findsOneWidget);
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();
  }

}