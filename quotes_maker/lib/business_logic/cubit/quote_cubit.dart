import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quotes_maker/model/quote_model.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final _random = new Random();

  late QuoteModel quotes;
  late int image_id;
  late String image_author;

  QuoteCubit() : super(QuoteInitial());

  String refreshImageUrl() {
    image_id = _random.nextInt(1000);

    if (quotes.isBlur && quotes.isGrayscale) {
      return "https://picsum.photos/id/${image_id}/720/1280?grayscale&blur=7";
    }

    if (quotes.isBlur) {
      return "https://picsum.photos/id/${image_id}/720/1280?blur=7";
    }

    if (quotes.isGrayscale) {
      return "https://picsum.photos/id/${image_id}/720/1280?grayscale";
    }

    return "https://picsum.photos/id/${image_id}/720/1280";
  }

  void reloadImageUrl() {
    if (quotes.isBlur && quotes.isGrayscale) {
      print("blur and gray");
      quotes.url =
          "https://picsum.photos/id/${image_id}/720/1280?grayscale&blur=7";
      return;
    }

    if (quotes.isBlur) {
      print("blur only");
      quotes.url = "https://picsum.photos/id/${image_id}/720/1280?blur=7";
      return;
    }

    if (quotes.isGrayscale) {
      print("bw only");
      quotes.url = "https://picsum.photos/id/${image_id}/720/1280?grayscale";
      return;
    }

    if (!quotes.isBlur && !quotes.isGrayscale) {
      print("no blur and gray");
      quotes.url = "https://picsum.photos/id/${image_id}/720/1280";
      return;
    }
  }

  Future<String> initImageUrl() async {
    bool isValid = false;

    while (!isValid) {
      image_id = _random.nextInt(1000);
      isValid = await verifyImage(image_id);
    }
    return "https://picsum.photos/id/${image_id}/720/1280?grayscale&blur=5";
  }

  Future<bool> verifyImage(int id) async {
    var response = await http.get(Uri.https('picsum.photos', '/id/$id/info'));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var author = jsonResponse['author'];
      print('Author : $author.');
      this.image_author = "Photo: " + author;
      return true;
    } else {
      return false;
    }
  }

  void init() async {
    this.quotes = new QuoteModel(
      url: await initImageUrl(),
      caption: "Your inspiring quotes belong here :)",
      textSize: 22,
      footerSize: 16,
      isBold: true,
      isItalic: true,
      isGrayscale: true,
      isBlur: true,
      isShadow: true,
      isCredit: true,
      image_author: image_author,
    );

    emit(RefreshQuote(this.quotes));
  }

  void changeCaption(String newCaption) {
    this.quotes.caption = newCaption;

    emit(RefreshQuote(this.quotes));
  }

  void changeFooter(String newCaption) {
    image_author = newCaption;
    this.quotes.image_author = newCaption;

    emit(RefreshQuote(this.quotes));
  }

  void changeTextSize(int newSize) {
    this.quotes.textSize = newSize;

    emit(RefreshQuote(this.quotes));
  }

  void changeFooterSize(int newSize) {
    this.quotes.footerSize = newSize;

    emit(RefreshQuote(this.quotes));
  }

  void changeBoldProps(bool newValue) {
    this.quotes.isBold = newValue;

    emit(RefreshQuote(this.quotes));
  }

  void changeItalicProps(bool newValue) {
    this.quotes.isItalic = newValue;

    emit(RefreshQuote(this.quotes));
  }

  void changeShadowProps(bool newValue) {
    this.quotes.isShadow = newValue;

    emit(RefreshQuote(this.quotes));
  }

  void changeIsCreditProps(bool newValue) {
    this.quotes.isCredit = newValue;

    emit(RefreshQuote(this.quotes));
  }

  void changeBackground() async {
    this.quotes.isBlur = true;
    this.quotes.isGrayscale = true;
    emit(QuoteInitial());
    this.quotes.url = await initImageUrl();
    this.quotes.image_author = this.image_author;
    emit(RefreshQuote(this.quotes));
  }

  void updateBlackWhiteBackground(bool newValue) async {
    this.quotes.isGrayscale = newValue;
    reloadImageUrl();
    await verifyImage(image_id);
    this.quotes.image_author = image_author;
    emit(RefreshQuote(this.quotes));
  }

  void updateBlurBackground(bool newValue) async {
    this.quotes.isBlur = newValue;
    reloadImageUrl();
    await verifyImage(image_id);
    this.quotes.image_author = image_author;
    emit(RefreshQuote(this.quotes));
  }
}
