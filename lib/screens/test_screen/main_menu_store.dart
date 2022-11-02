import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'main_menu_store.g.dart';

// ignore: library_private_types_in_public_api
class MainMenuStore = _MainMenuStore with _$MainMenuStore;

abstract class _MainMenuStore with Store {}
