import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fapp1/blocs/covid_bloc/covid_bloc.dart';
import 'package:fapp1/models/covid_model.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({Key? key}) : super(key: key);
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final CovidBloc _newsBloc = CovidBloc();

  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('COVID-19 List')),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return _buildLoading();
              } else if (state is CovidLoading) {
                return _buildLoading();
              } else if (state is CovidLoaded) {
                return _buildCard(context, state.covidModel);
              } else if (state is CovidError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CovidModel model) {
    return ListView.builder(
        itemCount: model.countries!.length,
        itemBuilder: (context, index) => SwipeActionCell(

            ///this key is necessary
            key: ObjectKey(model.countries![index]),
            trailingActions: <SwipeAction>[
              SwipeAction(

                  ///this is the same as iOS native
                  performsFirstActionWithFullSwipe: true,
                  title: "delete",
                  onTap: (CompletionHandler handler) async {
                    model.countries!.removeAt(index);
                    setState(() {});
                  },
                  color: Color.fromARGB(255, 19, 142, 224)),
            ],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Country: ${model.countries![index].country}"
                  ", Confirmed: ${model.countries![index].totalConfirmed}"
                  ", Deaths: ${model.countries![index].totalDeaths}"),
            )));
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
