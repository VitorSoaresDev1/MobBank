import 'package:mobbank/http/webclients/deposit_webclient.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/deposit.dart';

class DepositService {
  final DepositWebClient _depositWebClient = locator<DepositWebClient>();

  Future<List<Deposit>> getAccountDeposits(int id) async =>
      await _depositWebClient.findAllByAccountId(id);

  Future<Deposit> saveDeposit(Deposit deposit) async {
    return await _depositWebClient.save(deposit);
  }

  Future<List<Deposit>> getReceivedDeposits(String numeroConta) async {
    return await _depositWebClient.findIncomes(int.tryParse(numeroConta));
  }
}
