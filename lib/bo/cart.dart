import 'dart:ffi';

import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  final _listArticles = <Article>[];
  List<Article> get listArticles => _listArticles;

  String getTotalPrice() =>"${listArticles.fold(0, (prev, art) => prev + art.prix)/100}€";
  int getIntTotalPrice() => listArticles.fold(0, (prev, art) => prev + art.prix);

  void add(Article article){
    _listArticles.add(article);
    notifyListeners();
  }
  void remove(Article article){
    _listArticles.remove(article);
    notifyListeners();
  }
}