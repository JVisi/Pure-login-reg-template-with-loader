import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingHandler<T> extends StatefulWidget {
  final Future<T> Function() future;
  final Widget Function(T data) succeeding;

  LoadingHandler({@required this.future, @required this.succeeding});

  @override
  LoadingHandlerState<T> createState() => LoadingHandlerState();
}

class LoadingHandlerState<T> extends State<LoadingHandler<T>> {
  Future<T> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = widget.future();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<T>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) =>
            SnapshotManager<T>(
                snapshot: snapshot,
                onError: <T>(T error) =>
                    showErrorWidget(error.toString(), Icons.error),
                onSuccess: (T data) => widget.succeeding(data),
                onWait: showLoadingWidget(null, null, null)));
  }

  refresh() {
    setState(() {
      this._future = widget.future();
    });
  }
  Widget showErrorWidget(String name, IconData icon){
    return Scaffold(
        body: Column(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Icon(icon != null ? icon : Icons.warning,color: Colors.red,),
            Text(name != null ? name : "Error"),
            RaisedButton(
              child: Text("RETRY"),
              onPressed: refresh,
            ),
            Spacer(
              flex: 2,
            )
          ],
        ));
  }
  Widget showLoadingWidget(String name, String desc, IconData icon) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Spacer(
          flex: 1,
        ),
        SpinKitWave(
          color: Colors.blue,
          size: 50.0,
        ),
        Icon(icon != null ? icon : Icons.hourglass_empty),
        Text(name != null ? name : "Now Loading..."),
        Text(desc != null ? desc : ""),
        Spacer(
          flex: 2,
        )
      ],
    ));
  }
}

class SnapshotManager<T> extends StatelessWidget {
  final AsyncSnapshot<T> snapshot;
  final Widget Function<T>(T data) onError;
  final Widget onWait;
  final Widget Function(T data) onSuccess;

  SnapshotManager(
      {@required this.snapshot,
      @required this.onError,
      @required this.onSuccess,
      @required this.onWait});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (this.snapshot.connectionState == ConnectionState.waiting) return onWait;
    if (snapshot.hasData) {
      return this.onSuccess(snapshot.data);
    }
    return this.onError(snapshot.data);
  }
}
