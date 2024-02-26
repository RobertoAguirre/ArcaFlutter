import 'package:flutter/material.dart';
import 'invoicecategory.dart';
import 'user_profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arca Digital'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Configurar'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfileScreen()),
                    );
                },
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: const [
                  InvoiceCategory(
                    icon: Icons.outbond,
                    label: 'Clientes',
                    sublabel: 'Facturas emitidas',
                  ),
                  InvoiceCategory(
                    icon: Icons.flash_on,
                    label: 'Proveedores',
                    sublabel: 'Facturas recibidas',
                  ),
                  InvoiceCategory(
                    icon: Icons.whatshot,
                    label: 'Facturar',
                    sublabel: 'Generar Factura',
                  ),
                  InvoiceCategory(
                    icon: Icons.wifi,
                    label: 'Sincronizar',
                    sublabel: 'Descarga Masiva',
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Credit balance available'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Handle the tap
              },
            ),
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Reminders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Transactions',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
