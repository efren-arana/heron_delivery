import 'package:flutter/material.dart';

class FormService {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  bool validate() {
    return formKey.currentState.validate();
  }

  void save() {
    formKey.currentState.save();
  }

  void reset() {
    formKey.currentState.reset();
  }
}
