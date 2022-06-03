import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/features/genderize/presentation/bloc/genderize_bloc.dart';
import 'package:genderize/features/genderize/presentation/widgets/genderize_controls.dart';
import 'package:genderize/features/genderize/presentation/widgets/genderize_display.dart';
import 'package:genderize/features/genderize/presentation/widgets/loading_widget.dart';
import 'package:genderize/features/genderize/presentation/widgets/message_display.dart';
import 'package:genderize/injection_container.dart';

class GenderizePage extends StatelessWidget {
  const GenderizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genderize'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<GenderizeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GenderizeBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 5),
              BlocBuilder<GenderizeBloc, GenderizeState>(
                builder: (context, state) {
                  if (state is GenderizeInitial) {
                    return MessageDisplay(
                        message: 'Ketikkan nama untuk prediksi gender');
                  } else if (state is GenderizeLoading) {
                    return LoadingWidget();
                  } else if (state is GenderizeLoaded) {
                    return GenderizeDisplay(genderize: state.genderize);
                  } else if (state is GenderizeError) {
                    return MessageDisplay(message: state.message);
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Placeholder(),
                  );
                },
              ),
              SizedBox(height: 10),
              GenderizeControls(),
            ],
          ),
        ),
      ),
    );
  }
}