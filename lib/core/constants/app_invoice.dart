import 'package:qr_code_app/models/category.dart';
import 'package:qr_code_app/models/district.dart';
import 'package:qr_code_app/models/invoice_model.dart';
import 'package:qr_code_app/models/price.dart';
import 'package:qr_code_app/models/timestamp.dart';

class AppInvoice {
  static List<Invoice> invoiceList = [
    Invoice(
      id: 1,
      categoryId: 2,
      price: Price(normalPrice: 2000, formatedPrice: '200,000'),
      userId: 2,
      status: 1,
      category: Category(
        id: 1,
        name: 'Toko/Kios',
        description: 'description',
        price: 20000,
        status: '1',
        type: 'Month',
        parentId: 1,
        district: District(id: 1, name: 'Simalungun'),
        createdAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
        updatedAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
      ),
      address: 'address',
      subDistrictName: 'subDistrictName',
      date: 'date',
      createdAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
      updatedAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
    ),
    Invoice(
      id: 2,
      categoryId: 2,
      price: Price(normalPrice: 2000, formatedPrice: '200,000'),
      userId: 2,
      status: 1,
      category: Category(
        id: 1,
        name: 'Toko/Kios',
        description: 'description',
        price: 20000,
        status: '1',
        type: 'Month',
        parentId: 1,
        district: District(id: 1, name: 'Simalungun'),
        createdAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
        updatedAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
      ),
      address: 'address',
      subDistrictName: 'subDistrictName',
      date: 'date',
      createdAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
      updatedAt: TimeStamp(date: 'date', formatedDate: 'formatedDate'),
    ),
  ];
}
