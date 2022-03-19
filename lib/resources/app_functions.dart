import 'package:translator/translator.dart';

Future<List<String>> translate(String text)async{
  GoogleTranslator translator = GoogleTranslator();
  List<String> translatedText = ['$text'];
  await translator.translate(text,from: 'en', to: 'hi').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'bn').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'ta').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'te').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'mr').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'gu').then((value) => translatedText.add(value.toString()));
  //await translator.translate(text,from: 'en', to: 'or').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'pa').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'kn').then((value) => translatedText.add(value.toString()));
  await translator.translate(text,from: 'en', to: 'ml').then((value) => translatedText.add(value.toString()));
  return translatedText;
}