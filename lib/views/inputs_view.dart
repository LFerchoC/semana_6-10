import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// ignore: unused_import
import 'package:switch_theme_app/widgets/text_field.dart';

class InputsView extends StatefulWidget {
  const InputsView({super.key});

  @override
  State<InputsView> createState() => _InputsViewState();
}

class _InputsViewState extends State<InputsView> {
  bool envioValue = false;
  bool visibleValue = false;

  final textCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final descrCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final cateCtrl = TextEditingController();
  List categoria = [
    "Escritorio",
    "Laptop",
    "Accesorio",
    "Periferico",
    "Material",
  ];
  final provCtrl = TextEditingController();
  final imgCtrl = TextEditingController();
  final imageUrlCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Ingreso de productos'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset('assets/Inventory.json', height: 300, width: 300),
            //nombre
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: nameCtrl,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                  border: OutlineInputBorder(),
                  focusColor: Theme.of(context).colorScheme.inversePrimary,

                  hintText: 'Laptop - Telefono - Audifonos - tintas - mouse',
                ),
              ),
            ),

            //descripcion
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: descrCtrl,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Descripción'),
                  border: OutlineInputBorder(),
                  focusColor: Theme.of(context).colorScheme.inversePrimary,
                  hintText: 'Especificaciones',
                ),
              ),
            ),

            //ingreso y precio
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: stockCtrl,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Ingreso'),
                        border: OutlineInputBorder(),
                        focusColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        hintText: 'Cantidad a ingresar',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: priceCtrl,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Precio'),
                        border: OutlineInputBorder(),
                        focusColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        hintText: '20.00',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //categoria - proveedor
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cateCtrl,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text('Categoria'),
                        border: OutlineInputBorder(),
                        focusColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        hintText:
                            'Escritorio, Laptop, Accesorio, Periferico, Material',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: provCtrl,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text('Proveedor'),
                        border: OutlineInputBorder(),
                        focusColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                        hintText: 'Entidad que proveé',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Imagen URL
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: imgCtrl,
                obscureText: false,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  label: Text('URL Imagen'),
                  border: OutlineInputBorder(),
                  focusColor: Theme.of(context).colorScheme.inversePrimary,
                  hintText: 'DIreccion de la Imagen',
                ),
              ),
            ),

            SwitchListTile(
              title: Text('Disponible para envio'),
              value: envioValue,
              onChanged: (value) {
                setState(() => envioValue = value);
              },
            ),

            SwitchListTile(
              title: Text('Producto visible en la tienda'),
              value: visibleValue,
              onChanged: (value) {
                setState(() => visibleValue = value);
              },
            ),
            /*ElevatedButton(onPressed: () {}, child: Text('Elevated Button')),
            FilledButton(onPressed: () {}, child: Text("Filled Button")),
            TextButton(onPressed: () {}, child: Text('Text Button')),
            //CloseButton(),*/
            BackButton(),
          ],
        ),
      ),
    );
  }
}
