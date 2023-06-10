import 'package:flutter/material.dart';

class ShowError extends StatelessWidget{

  final void Function() reload;
  final String error;

  const ShowError({super.key, required this.reload, required this.error});

  @override
  Widget build(BuildContext context) {
    print(error);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Une erreur s'est produite, veuillez réessayer"),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: (){
              reload();
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }

}