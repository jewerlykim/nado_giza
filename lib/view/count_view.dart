import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nado_giza/viewModel/count_viewmodel.dart';

class CountView extends StatelessWidget {
  const CountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나도 기자'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<CountViewModel>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You have pushed the button this many times:'),
                Text(
                  '${provider.count}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                FloatingActionButton(
                  onPressed: provider.increment,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
