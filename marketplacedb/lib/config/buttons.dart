import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final Function()? onTap;
  const GoogleButton({
    Key? key, // Use Key? key instead of super.key
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: Text(
            "Continue with google",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class FBButton extends StatelessWidget {
  final Function()? onTap;
  const FBButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Color(0xFF1877F2)),
        child: const Center(
          child: Text(
            "Continue with Facebook",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  final VoidCallback onTap;
  const SignupButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.black),
        child: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class SigninButton extends StatelessWidget {
  final Function()? onPressed;
  const SigninButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.black),
        child: const Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class Continue extends StatelessWidget {
  final Function()? onTap;
  final bool isDisabled;

  const Continue({
    Key? key,
    required this.onTap,
    required this.isDisabled, // New parameter to disable the button
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          isDisabled ? null : onTap, // Disable the button if isDisabled is true
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey : const Color.fromARGB(255, 7, 7, 7),
        ),
        child: const Center(
          child: Text(
            "Continue",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Function()? onTap;

  const ListItem({
    Key? key,
    required this.onTap, // New parameter to disable the button
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Disable the button if isDisabled is true
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 7, 7, 7),
        ),
        child: const Center(
          child: Text(
            "List an Item and Start Selling",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
