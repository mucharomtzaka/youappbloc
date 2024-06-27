
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robot/loginrobot.dart';
import 'package:myapp/main.dart' as app;

import 'robot/registerrobot.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Loginrobot loginrobot;
  Registerrobot registerrobot;
   group('end-to-end test', () {
    testWidgets('Login', (tester) async {

      app.main();

      await tester.pumpAndSettle();

      registerrobot = Registerrobot(tester);
      loginrobot = Loginrobot(tester);

      //test widget register
      await loginrobot.clickNavigationRegisterButton();

      await registerrobot.setTextFieldEmail();
      await registerrobot.setTextFieldUsername();
      await registerrobot.setTextFieldPassword();
      await registerrobot.setConfirmPassword();
      await registerrobot.clickNavigationRegisterButtonet();
      await registerrobot.clickNavigationLoginButtonet();

      //test widget login
      
      await loginrobot.setTextFieldEmail();
      await loginrobot.setTextFieldPassword();
      await loginrobot.clickNavigationLoginButton();
  
    });
   });
}