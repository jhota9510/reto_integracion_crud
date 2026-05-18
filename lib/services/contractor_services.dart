import 'dart:async';
import '../models/contractor_model.dart';

class ContractorServices {
  static final List<ContractorModel> _contractors = [];

  Future<List<ContractorModel>> getContractors() async {
    return _contractors;
  }

  Future<void> addContractor(ContractorModel contractor) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    _contractors.add(contractor);
  }

  Future<void> updateContractor(ContractorModel updatedContractor) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    final index = _contractors.indexWhere(
      (contractor) => contractor.id == updatedContractor.id,
    );

    if (index != -1) {
      _contractors[index] = updatedContractor;
    }
  }

  Future<void> deleteContractor(String id) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    _contractors.removeWhere(
      (contractor) => contractor.id == id,
    );
  }
}
