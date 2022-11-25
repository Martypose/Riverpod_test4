import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

const names = [
  'John',
  'Paul',
  'George',
  'Ringo',
  'Alice',
  'Bob',
  'Charlie',
  'Dave',
  'Eve',
  'Fred',
  'Grace',
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(
      seconds: 1,
    ),
    (i) => i + 1,
  ),
);

final nameProvider =
    StreamProvider((ref) => ref.watch(tickerProvider.stream).map(
          (count) => names.getRange(
            0,
            count,
          ),
        ));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StreamProvider',
        ),
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  names.elementAt(index),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => const Text(
          'LLegamos al final de la lista de nombres',
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
