import 'package:ecom_boni_user/models/customer_model.dart';
import 'package:ecom_boni_user/pages/order_confirmation_page.dart';
import 'package:ecom_boni_user/provider/customer_provider.dart';
import 'package:ecom_boni_user/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerInfoPage extends StatefulWidget {
  const CustomerInfoPage({super.key});
  static const String routeName = '/customaer_info';

  @override
  State<CustomerInfoPage> createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  final _searchPhoneController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _customerAddressController = TextEditingController();
  CustomerModel? _customerModel = CustomerModel();
  late CustomerProvider _customerProvider;
  @override
  void didChangeDependencies() {
    _customerProvider = Provider.of<CustomerProvider>(context);
    super.didChangeDependencies();
  }

  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Infomation',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () => _saveCustomerInfomation(),
              child: const Text(
                'NEXT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _findCustomerSection(),
              const SizedBox(
                height: 50,
              ),
              _buildFormSection(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchPhoneController.dispose();
    _customerNameController.dispose();
    _customerAddressController.dispose();
    _customerEmailController.dispose();
    _customerPhoneController.dispose();
  }

  Widget _findCustomerSection() {
    return Column(
      children: [
        const Text(
          'Existing Customer?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _searchPhoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Phone Number',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () => _findExistingCustomer(),
                  icon: const Icon(Icons.search))),
        ),
      ],
    );
  }

  void _findExistingCustomer() async {
    FocusScope.of(context).unfocus();
    if (_searchPhoneController.text.isEmpty) {
      showMessage(context, 'Provide a phone number');
      return;
    }
    final model =
        await _customerProvider.findCustomer(_searchPhoneController.text);
    if (model != null) {
      _customerModel = model;
      // ignore: use_build_context_synchronously
      showMessage(context, ' found');
      setState(() {
        _customerNameController.text = _customerModel!.customerName!;
        _customerPhoneController.text = _customerModel!.customerPhone!;
        _customerEmailController.text = _customerModel!.customerEmail!;
        _customerAddressController.text = _customerModel!.customerAddress!;
      });
    } else {
      // ignore: use_build_context_synchronously
      showMessage(context, 'not found');
    }
  }

  Widget _buildFormSection() {
    return Form(
      key: _fromKey,
      child: Card(
        child: Column(
          children: [
            const Text(
              'New Customer?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This filed is empty';
                }
                return null;
              },
              onSaved: (value) {
                _customerModel!.customerName = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _customerPhoneController,
              decoration: const InputDecoration(
                hintText: 'Phone',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This filed is empty';
                }
                return null;
              },
              onSaved: (value) {
                _customerModel!.customerPhone = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _customerEmailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This filed is empty';
                }
                return null;
              },
              onSaved: (value) {
                _customerModel!.customerEmail = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _customerAddressController,
              decoration: const InputDecoration(
                hintText: 'Street Address',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This filed is empty';
                }
                return null;
              },
              onSaved: (value) {
                _customerModel!.customerAddress = value!;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveCustomerInfomation() async {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState!.save();
      if (_customerModel!.customerId == null) {
        final customerId = await _customerProvider.addCustomer(_customerModel!);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, OrderConfirmationPage.routeName,
            arguments: customerId);
      } else {
        await _customerProvider.updateCustomer(_customerModel!);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, OrderConfirmationPage.routeName,
            arguments: _customerModel!.customerId);
      }
    }
  }
}
