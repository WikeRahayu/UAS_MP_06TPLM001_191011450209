import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/berita_cubit.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({super.key});

  @override
  _BeritaScreenState createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  final BeritaCubit beritaCubit = BeritaCubit();

  @override
  void initState() {
    beritaCubit.getDataBerita();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('191011450209 - WIKE RAHAYU')],
        ),
      ),
      body: BlocBuilder<BeritaCubit, BeritaState>(
          bloc: beritaCubit,
          builder: (context, state) {
            if (state is BeritaInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              itemCount: beritaCubit.beritaModel.data?.posts?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Row(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            beritaCubit
                                .beritaModel.data!.posts![index].thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  beritaCubit
                                      .beritaModel.data!.posts![index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 5,
                                    top: 5,
                                  ),
                                  child: Text(
                                    beritaCubit.beritaModel.data!.posts![index]
                                        .pubDate!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Text(
                                  beritaCubit.beritaModel.data!.posts![index]
                                      .description!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
