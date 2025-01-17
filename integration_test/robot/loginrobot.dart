import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class Loginrobot{
  final WidgetTester tester;
  Loginrobot(this.tester);
   Future<void> setTextFieldEmail() async {
    final emailTextFieldFinder = find.byKey(const Key('emaillogin'));
    expect(emailTextFieldFinder, findsOneWidget);
    await tester.ensureVisible(emailTextFieldFinder);
    await tester.enterText(emailTextFieldFinder, "mucharomtzaka@yahoo.co.id");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  } 

   Future<void> setTextFieldPassword() async {
    final passwordTextFieldFinder = find.byKey(const Key('passwordlogin'));
    expect(passwordTextFieldFinder, findsOneWidget);
    await tester.ensureVisible(passwordTextFieldFinder);
    await tester.enterText(passwordTextFieldFinder, "12345678");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> clickNavigationLoginButton() async {
    final loginButtonFinder = find.byKey(const Key('btnLogin'),skipOffstage: true);
    expect(loginButtonFinder, findsOneWidget);
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickNavigationRegisterButton() async {
    final registerButtonFinder = find.byKey(const Key('btnRegister'));
     expect(registerButtonFinder, findsOneWidget);
    await tester.ensureVisible(registerButtonFinder);
    await tester.tap(registerButtonFinder);
    await tester.pumpAndSettle();
  }
}