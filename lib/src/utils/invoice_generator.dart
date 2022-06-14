import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;

import '../extensions/extension.dart';
import '../models/models.dart';

class InvoiceGenerator {
  Future<File> generate({required Order order}) async {
    final document = pdf.Document()..addPage(_getPage(order));

    final byteList = await document.save();

    return _savePdfFile(order.id, byteList);
  }

  pdf.Page _getPage(Order order) {
    return pdf.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return _buildInvoice(order: order);
      },
    );
  }

  Future<File> _savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = '${output.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
    return file;
  }

  pdf.Widget _buildInvoice({required Order order}) {
    return pdf.Column(
      children: [
        _buildInvoiceData(order: order),
        _buildDevider(),
        _buildCustomerData(customer: order.customer),
        _buildDevider(),
        _buildTable(
          items: order.items,
          price: order.price,
          deliverer: order.deliverer,
        ),
        pdf.SizedBox(height: 8),
        _buildTableSummary(price: order.price),
      ],
    );
  }

  pdf.Widget _buildInvoiceData({required Order order}) {
    return pdf.Column(
      children: [
        _buildRow(name: 'Numer:', data: order.id),
        pdf.SizedBox(height: 16),
        _buildRow(
          name: 'Data wystawienia:',
          data: DateTime.now().toSimpleString(),
        ),
        //_buildRow(name: 'Miejscowosc:', data: 'Makoszyce')
      ],
    );
  }

  pdf.Widget _buildRow({required String name, required String data}) {
    return pdf.Row(
      children: [
        pdf.Text(
          name,
          style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
        ),
        pdf.SizedBox(width: 16),
        pdf.Text(data),
      ],
    );
  }

  pdf.Widget _buildDevider() {
    return pdf.Padding(
      padding: const pdf.EdgeInsets.symmetric(vertical: 16),
      child: pdf.Divider(height: 1),
    );
  }

  pdf.Widget _buildSellerCustomerRow({required Customer customer}) {
    return pdf.Row(
      crossAxisAlignment: pdf.CrossAxisAlignment.start,
      children: [
        pdf.Flexible(child: _buildSellerData()),
        pdf.Flexible(child: _buildCustomerData(customer: customer)),
      ],
    );
  }

  pdf.Widget _buildSellerData() {
    return pdf.Column(
      children: [
        pdf.Text(
          'Sprzedawca',
          style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
        ),
        pdf.SizedBox(height: 12),
        pdf.Text(
          'Decor Sklep Internetowy Katarzyna Boryczka',
          style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
        ),
        pdf.SizedBox(height: 4),
        pdf.Text(
          'Makoszyce 73C',
          style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
        ),
        pdf.Text(
          '63-507 Kobyla Gora, Polska',
          style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
        ),
        pdf.SizedBox(height: 4),
        pdf.Text(
          'NIP: 6191828746',
          style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
        ),
      ],
    );
  }

  pdf.Widget _buildCustomerData({required Customer customer}) {
    return pdf.Row(
      children: [
        pdf.Column(
          crossAxisAlignment: pdf.CrossAxisAlignment.start,
          children: [
            pdf.Text(
              'Nabywca',
              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
            ),
            pdf.SizedBox(height: 12),
            pdf.Text(
              customer.name,
              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
            ),
            pdf.SizedBox(height: 4),
            pdf.Text(
              customer.address,
              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
            ),
            pdf.SizedBox(height: 4),
            pdf.Text(
              'tel: ${customer.phone}',
              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
            ),
            pdf.SizedBox(height: 4),
            pdf.Text(
              'email: ${customer.email}',
              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  pdf.Widget _buildTable({
    required List<OrderItem> items,
    required double price,
    required OrderDeliverer deliverer,
  }) {
    return pdf.Table(
      border: pdf.TableBorder.all(),
      children: [
        _buildTableHeader(),
        ...List.generate(
          items.length,
          (index) => _buildTableRow(index: index + 1, item: items[index]),
        ),
        _buildTableDelivererRow(index: items.length, deliverer: deliverer),
      ],
    );
  }

  pdf.Widget _buildTableCell(
    String value, {
    pdf.TextAlign textAlign = pdf.TextAlign.right,
  }) =>
      pdf.Padding(
        padding: const pdf.EdgeInsets.all(4),
        child: pdf.Text(value, textAlign: textAlign),
      );

  pdf.TableRow _buildTableHeader() {
    return pdf.TableRow(
      decoration: pdf.BoxDecoration(color: PdfColor.fromHex('#C0C0C0')),
      repeat: true,
      children: [
        _buildTableCell('LP', textAlign: pdf.TextAlign.left),
        _buildTableCell('Nazwa towaru', textAlign: pdf.TextAlign.left),
        _buildTableCell('Ilosc'),
        _buildTableCell('Cena'),
        _buildTableCell('Wartosc'),
      ],
    );
  }

  pdf.TableRow _buildTableRow({required int index, required OrderItem item}) {
    return pdf.TableRow(
      children: [
        _buildTableCell('$index', textAlign: pdf.TextAlign.left),
        _buildTableCell(item.productName, textAlign: pdf.TextAlign.left),
        _buildTableCell('${item.quantity} szt'),
        _buildTableCell('${item.price}'),
        _buildTableCell('${(item.quantity * item.price).toPrice()}'),
      ],
    );
  }

  pdf.TableRow _buildTableDelivererRow({
    required int index,
    required OrderDeliverer deliverer,
  }) {
    return pdf.TableRow(
      children: [
        _buildTableCell('$index', textAlign: pdf.TextAlign.left),
        _buildTableCell('$deliverer', textAlign: pdf.TextAlign.left),
        _buildTableCell('1'),
        _buildTableCell('${deliverer.price}'),
        _buildTableCell('${deliverer.price.toPrice()}'),
      ],
    );
  }

  pdf.Widget _buildTableSummary({
    required double price,
  }) {
    return pdf.Row(
      mainAxisAlignment: pdf.MainAxisAlignment.end,
      children: [
        pdf.Text(
          'Razem',
          style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
        ),
        pdf.SizedBox(width: 24),
        pdf.Text('${price.toPrice()} PLN'),
      ],
    );
  }

  pdf.Widget _buildFooter() {
    return pdf.Row(
      mainAxisAlignment: pdf.MainAxisAlignment.end,
      children: [
        pdf.Column(
          children: [
            pdf.Text(
              'Imie i nazwisko wystawcy',
              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
            ),
            pdf.SizedBox(height: 4),
            pdf.Text(
              'Katarzyna Boryczka',
              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
            ),
          ],
        ),
        pdf.SizedBox(width: 32),
      ],
    );
  }
}
