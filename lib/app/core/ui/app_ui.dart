
import 'package:flutter/material.dart';

class AppUI {
  
  AppUI._();

  static final ThemeData theme = ThemeData(
    primaryColor: const Color(0xFF007D21), //cor primário de todo o app
    primaryColorDark: const Color(0xFF00343F), //cor dos títulos do app
    fontFamily: 'mplus1', //fonte do texto do projeto, conforme adicionado no pubspec
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF007D21), //cor de fundo dos botoes do app
        textStyle: const TextStyle(fontFamily: 'mplus1'), //fonte dos textos dos botões
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black, //cor para quando o botão estiver selecionado
      selectedIconTheme: const IconThemeData(color: Colors.black), //cor do icone quando selecionado
      selectedLabelStyle: textbold, //estilo do texto para quando  botão estiver selecionado

      unselectedItemColor: Colors.grey[400], //cor para quando o botão não estiver selecionado
      unselectedIconTheme: IconThemeData(color: Colors.grey[400]), //cor do icone quando não selecionado
    ),
  );

  static const TextStyle textbold = TextStyle(fontWeight: FontWeight.bold);
}