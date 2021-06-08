import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:task_app/providers/auth.dart';
import 'package:task_app/screens/counter.dart';

enum FormType { login, register }

class MyAuthPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = "";
  String _pass = "";
  FormType _formType = FormType.login;
  // var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_emailListener);
    _passwordController.addListener(_passwordListener);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _emailListener() {
    if (_emailController.text.isEmpty) {
      _email = "";
    } else {
      print("#######################################" + _emailController.text);

      _email = _emailController.text;
    }
  }

  void _passwordListener() {
    if (_passwordController.text.isEmpty) {
      _pass = "";
    } else {
      print(
          "#######################################" + _passwordController.text);
      _pass = _passwordController.text;
      print("_pass=" + _pass);
    }
  }

  void _changeForm() async {
    setState(() {
      if (_formType == FormType.login) {
        _formType = FormType.register;
      } else {
        _formType = FormType.login;
      }
    });
  }

  Future<void> _submit() async {
    // if (!_formKey.currentState.validate()) {
    //   // Invalid!
    //   return;
    // }
    // _formKey.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
    if (_formType == FormType.login) {
      // Log user in
    } else {
      print(
          "############################################################################### pass:" +
              _pass);
      print(
          "############################################################################### email:" +
              _email);

      await Provider.of<Auth>(context, listen: false).signUp(_email, _pass);
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  void _passReset() {
    //TODO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Sup App"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textFields(),
            _buttons(),
          ],
        ),
      ),
    );
  }

  Widget _textFields() {
    return new Container(
      child: Column(
        children: [
          new Container(
            width: 300,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _emailController,
              decoration: InputDecoration(labelText: "email"),
            ),
          ),
          new Container(
            width: 300,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _passwordController,
              decoration: InputDecoration(labelText: "password"),
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    if (_formType == FormType.login) {
      return Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Counter()));
                },
                child: Text("Login")),
            TextButton(
              onPressed: _changeForm,
              child: Text("Dont have an account? \nClick here!"),
            ),
            TextButton(
              onPressed: null,
              child: Text("reset password"),
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _submit,
              child: Text("Register"),
            ),
            TextButton(
              onPressed: _changeForm,
              child: Text("Click here to login"),
            )
          ],
        ),
      );
    }
  }
}
