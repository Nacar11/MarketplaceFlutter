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
            "Continue with Google",
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

class LargeBlackButton extends StatelessWidget {
  final Function()? onPressed;
  final bool isDisabled;
  final String text;
  final double fontsize;
  final EdgeInsetsGeometry padding; // Make padding required
  final EdgeInsetsGeometry margin;

  const LargeBlackButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.fontsize,
    required this.padding,
    required this.margin,
    this.isDisabled = false, // Default to not disabled
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed, // Conditionally set onTap
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey
              : Colors.black, // Change the background color
        ),
        child: Center(
          child: Text(
            isDisabled ? '' : text,
            style: TextStyle(
              color: isDisabled
                  ? Colors.black
                  : Colors.white, // Change the text color
              fontWeight: FontWeight.bold,
              fontSize: fontsize,
            ),
          ),
        ),
      ),
    );
  }
}

class LargeWhiteButton extends StatelessWidget {
  final Function()? onPressed;
  final bool isDisabled;
  final String text;
  final EdgeInsetsGeometry margin;

  const LargeWhiteButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.isDisabled = false,
      this.margin =
          const EdgeInsets.symmetric(horizontal: 10) // Default to not disabled
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed, // Conditionally set onTap
      child: Container(
        width: 150,
        height: 60,
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: isDisabled
              ? Colors.grey
              : Colors.white, // Change the background color
        ),
        child: Center(
          child: Text(
            isDisabled ? '' : text,
            style: TextStyle(
              color: isDisabled
                  ? Colors.black
                  : Colors.black, // Change the text color
              fontWeight: FontWeight.bold,
              fontSize: 20,
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

class ExpansiontileButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const ExpansiontileButton({
    Key? key,
    required this.onTap,
    required this.text, // New parameter to disable the button
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Customize the card elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              const Icon(Icons.expand_more),
            ],
          ),
        ),
      ),
    );
  }
}
