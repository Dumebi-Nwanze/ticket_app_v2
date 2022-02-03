import 'package:flutter/material.dart';

snackBar(BuildContext context, String info) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: info == "success"
          ? const Text(
              "Success",
              style: TextStyle(
                fontFamily: "AvenirNext",
              ),
            )
          : Text(
              info,
              style: const TextStyle(
                fontFamily: "AvenirNext",
              ),
            ),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}
