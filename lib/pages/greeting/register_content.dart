import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({
    Key? key,
    required this.goBack,
    required this.onGooglePressed,
    required this.onApplePressed,
  }) : super(key: key);

  final VoidCallback goBack;
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _productKeyController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _productKeyController.dispose();
    super.dispose();
  }

  void _handleEmailRegistration() {
    if (_formKey.currentState!.validate()) {
      // Handle registration logic here
      print('Full Name: ${_fullNameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Product Key: ${_productKeyController.text}');
      // Navigate to onboarding after successful registration
      widget.onGooglePressed(); // Reusing this callback to go to onboarding
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
            Text("Create Account", style: theme.textTheme.displayMedium),
            Text("Register your product", style: theme.textTheme.titleMedium),
          ],
        );

        final actionSection = SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Product Key Section (Required for all methods)
                Container(
                  width: isLandscape ? size.width * .3 : size.width * .7,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.key,
                        color: theme.colorScheme.primary,
                        size: 32,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Product Key Required",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _productKeyController,
                        decoration: InputDecoration(
                          labelText: 'Enter Product Key',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your product key';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Sign in method text
                Text(
                  "Choose your sign-in method",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 16),

                // Social login buttons
                SizedBox(
                  width: isLandscape ? size.width * .3 : size.width * .7,
                  child: OutlinedButton.icon(
                    onPressed: widget.onGooglePressed,
                    icon: FaIcon(FontAwesomeIcons.google, size: 20),
                    label: Text("Continue with Google"),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: theme.colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: isLandscape ? size.width * .3 : size.width * .7,
                  child: ElevatedButton.icon(
                    onPressed: widget.onApplePressed,
                    icon: FaIcon(FontAwesomeIcons.apple, size: 20),
                    label: Text("Continue with Apple"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Divider
                SizedBox(
                  width: isLandscape ? size.width * .3 : size.width * .7,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(color: theme.colorScheme.outline),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("OR", style: theme.textTheme.bodySmall),
                      ),
                      Expanded(
                        child: Divider(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Email registration form
                Text(
                  "Sign up with Email",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: isLandscape ? size.width * .3 : size.width * .7,
                  child: TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
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
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: isLandscape ? size.width * .3 : size.width * .7,
                  child: ElevatedButton(
                    onPressed: _handleEmailRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Create Account"),
                  ),
                ),
              ],
            ),
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
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: actionSection,
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
                          SizedBox(height: size.height * .05),
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
