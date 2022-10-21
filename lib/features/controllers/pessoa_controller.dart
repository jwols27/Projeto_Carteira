import 'package:flutter/cupertino.dart';
import 'package:projeto_carteira/features/models/pessoa_model.dart';
import 'package:projeto_carteira/sql/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../DAOs/pessoa_dao.dart';

class PessoaController {
  Future<Database?> get db => DatabaseHelper.getInstance().db;
  final PessoaDao _pessoaDao = PessoaDao();

  Future<bool> insertPessoa(PessoaModel pessoa) async {
    List<PessoaModel> check = await _pessoaDao.query("SELECT * FROM pessoas WHERE email = ?;", [pessoa.email]);

    if (check.isEmpty) {
      await _pessoaDao.save(pessoa);
      return false;
    } else {
      print('${check.first} already exists.');
      return true;
    }
  }

  Future<List<PessoaModel>> logInPessoa(String email, String senha) async {
    return await _pessoaDao.query("SELECT * from pessoas WHERE email = ? AND senha = ?", [email, senha]);
  }

  Future<PessoaModel> findPessoaByID(int id) async {
    return await _pessoaDao.getUserByID(id);
  }

  Future<List<PessoaModel>> findPessoaByEmail(String email) async {
    return await _pessoaDao.query("SELECT * from pessoas WHERE email = ?", [email]);
  }

  deletePessoa(int id) async {
    await _pessoaDao.delete(id, 'codigo');
  }

  updatePessoaField(int id, String column, String newer) {
    _pessoaDao.update(id, column, newer);
  }

  // Updates both instance and database
  updatePessoaWhole(PessoaModel pessoa, PessoaModel tempPessoa) {
    //Instance
    pessoa
      ..nome = tempPessoa.nome
      ..email = tempPessoa.email
      ..senha = tempPessoa.senha
      ..minimo = tempPessoa.minimo
      ..saldo = tempPessoa.saldo
      ..tipo = tempPessoa.tipo;
    //Database
    _pessoaDao.updateUser(pessoa);
  }
}
