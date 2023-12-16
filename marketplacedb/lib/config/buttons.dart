import 'package:flutter/material.dart';

class SignUpProcessContinueFAB extends StatelessWidget {
  final Function()? onPressed;
  final bool isDisabled;
  final String text;
  final bool isLoading;

  const SignUpProcessContinueFAB({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isDisabled = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled || isLoading
            ? Colors.grey
            : const Color.fromRGBO(116, 78, 255, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Adjust the font size as needed
                ),
              ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final Function()? onTap;

  const GoogleButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define responsive values based on screen size

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius value as needed
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 24,
              height: 24,
              image: AssetImage('flutter_images/googleIcon.png'),
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10), // Adjust the space between icon and text
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Continue with Google",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FBButton extends StatelessWidget {
  final Function()? onTap;

  const FBButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: const Color(0xFF1877F2),
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius value as needed
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.facebook, // Replace this with your desired Facebook icon
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 10), // Adjust the space between icon and text
            Text(
              "Continue with Facebook",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
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
  final bool isLoading;

  const LargeBlackButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isDisabled = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: 65,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isDisabled || isLoading ? Colors.grey : Colors.black,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 300,
                    ),
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
