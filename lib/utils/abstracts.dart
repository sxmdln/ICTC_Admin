import 'package:flutter/material.dart';

abstract class WidgetView<model, controller> extends StatelessWidget {
  final controller state;

  model get widget => (state as State).widget as model;

  const WidgetView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}

abstract class StatelessView<model> extends StatelessWidget {
  final model widget;

  const StatelessView(this.widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}