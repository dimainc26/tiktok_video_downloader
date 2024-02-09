// ignore_for_file: file_names

import 'dart:math';

class GenerateRandom {
  final int _randomLength = 4;
  final DateTime _dateTime = DateTime.now();

  GenerateRandom();

  // Getters
  int get randomLength => _randomLength;
  DateTime get dateTime => _dateTime;

  // Setters
  // set randomLength(int value) => _randomLength = value;
  // set dateTime(DateTime value) => _dateTime = value;

  // Methodes

  // Its generates a string whose length is equal to *length
  String generateString() {
    String generateString = "";

    for (var i = 0; i < _randomLength; i++) {
      generateString += Random().nextInt(10).toString();
    }
    return generateString;
  }

  // Its converts a DateTime *date to Sring
  String convertDateToString(DateTime date) {
    String convertedDate = date
        .toString()
        .split("-")
        .join("")
        .split(":")
        .join("")
        .split(".")
        .join("")
        .split(" ")
        .join("");
    return convertedDate;
  }
}
