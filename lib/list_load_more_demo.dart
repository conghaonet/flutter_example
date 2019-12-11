import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/list_footer.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => (runApp(ListLoadMoreDemo()));

class ListLoadMoreDemo extends StatefulWidget {
  final int pageSize = 20;
  final int initId = 500;

  @override
  _ListLoadMoreDemoState createState() => _ListLoadMoreDemoState();
}

class _ListLoadMoreDemoState extends State<ListLoadMoreDemo> {
  int _pageNo;
  String _stateText = "加载中。。。";

  @override
  void initState() {
    super.initState();
    _pageNo = 1;
  }

  Future<void> _refreshData() async {
    return Future.delayed(Duration(seconds: 2)).then((value){
      setState(() {
        _pageNo = 1;
      });
    });
  }

  Future<void> _loadMoreData() async {
    return Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        _pageNo++;
      });
    }).whenComplete((){
      Fluttertoast.showToast(msg: '第$_pageNo页加载完成');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  if(index < this._pageNo * widget.pageSize) {
                    return _buildItem(index);
                  } else {
                    _loadMoreData();
                    return ListFooter(_stateText);
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 8,
                    color: Colors.transparent,
                  );
                },
                itemCount: this._pageNo * widget.pageSize + 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          Text('ID: $index'),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Image.network(
              'https://picsum.photos/id/${widget.initId + index}/300/100',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
