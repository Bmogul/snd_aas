import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({
    Key? key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.goBack
  }) : super(key: key);

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback goBack;

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleEmailLogin() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      // Navigate to onboarding after successful login
      widget.onLoginPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth >= constraints.maxHeight;

        final headerSection = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 80, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text("Welcome Back ", style: theme.textTheme.displayMedium),
            Text("Choose login method", style: theme.textTheme.titleMedium),
          ],
        );

        final actionSection = Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Social login buttons
              SizedBox(
                width: isLandscape ? size.width * .3 : size.width * .7,
                child: OutlinedButton.icon(
                  onPressed: widget.onLoginPressed,
                  icon: FaIcon(FontAwesomeIcons.google, size: 20),
                  label: Text("Continue with Google"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: theme.colorScheme.outline),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: isLandscape ? size.width * .3 : size.width * .7,
                child: ElevatedButton.icon(
                  onPressed: widget.onRegisterPressed,
                  icon: FaIcon(FontAwesomeIcons.apple, size: 20),
                  label: Text("Continue with Apple"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Divider
              SizedBox(
                width: isLandscape ? size.width * .3 : size.width * .7,
                child: Row(
                  children: [
                    Expanded(child: Divider(color: theme.colorScheme.outline)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR", style: theme.textTheme.bodySmall),
                    ),
                    Expanded(child: Divider(color: theme.colorScheme.outline)),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Email login form
              Text(
                "Sign in with Email",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: isLandscape ? size.width * .3 : size.width * .7,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: isLandscape ? size.width * .3 : size.width * .7,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: isLandscape ? size.width * .3 : size.width * .7,
                child: ElevatedButton(
                  onPressed: _handleEmailLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("Sign In"),
                ),
              ),
            ],
          ),
        );
        return Stack(
          children: [
            isLandscape
                ? Row(
                    children: [
                      Expanded(
                        child: Center(child: headerSection),
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: actionSection,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          headerSection,
                          SizedBox(height: size.height * .1),
                          actionSection,
                        ],
                      ),
                    ),
                  ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: widget.goBack,
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ],
        );
      },
    );
  }
}
