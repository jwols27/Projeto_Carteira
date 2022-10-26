import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_carteira/features/movement/daos/saida_dao.dart';

import '../models/saida_model.dart';

part 'saida_store.g.dart';

// This is the class used by rest of your codebase
class SaidaStore = _SaidaStore with _$SaidaStore;

// The store-class
abstract class _SaidaStore with Store {
  final SaidaDao _saidaDao = SaidaDao();

  @observable
  List<SaidaModel> saidas = [];

  @observable
  bool saidaLoaded = true;

  @action
  loadSaidas(int personId, {String initialDate = '', String finalDate = ''}) async {
    saidaLoaded = false;
    saidas = await _saidaDao.getSaidas(personId, initialDate: initialDate, finalDate: finalDate);
    saidaLoaded = true;
  }

  @action
  emptySaidas() {
    saidas = [];
  }
}