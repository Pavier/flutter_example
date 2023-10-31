import 'package:easy_refresh/easy_refresh.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_test/PlatFormMethod.dart';
import 'package:get/get.dart';

import '../entity/item.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  final _data = List<Item>.empty(growable: true).obs;

  late final EasyRefreshController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data.addAll(_loadData());
    _controller = EasyRefreshController(
        controlFinishRefresh: true,
        controlFinishLoad: true
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("列表页面"),
        ),
        body: EasyRefresh.builder(
            controller: _controller,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onRefresh: () async{
              _refreshData();
            },
            onLoad: () async {
              _loadMoreData();
            },
            childBuilder: (context,physics){
              return Obx(() => ListView.builder(
                // prototypeItem: const ListTile(
                //   title: Text("1"),
                // ),
                  physics: physics,
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    // return ListTile(
                    //   title: Text('Item $index'),
                    // );
                    return InkWell(
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Image(image: NetworkImage(
                                      "https://img0.baidu.com/it/u=495057738,502974068&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"),
                                    width: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_data[index].title ?? "空数据",style: TextStyle(
                                          color: Colors.deepOrange
                                        ),),
                                        Text(_data[index].time.toString()),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                        onTap: (){
                          debugPrint("点击item");
                          // final Text textWidget = textKey.currentContext?.widget as Text;
                          // final String? textValue = textWidget.data;
                          final value = _data[index];
                          callNativeMethod("showToast", {"msg":"$value--$index"});

                        }
                    );
                  })
              );
            })
    );
  }

  List<Item> _loadData(){
    List<Item> data = List<Item>.empty(growable: true);
    generateWordPairs().take(20).forEach((element) {
      data.add(Item(title: element.asPascalCase));
    });
    return data;
  }

  void _refreshData(){
    Future.delayed(const Duration(seconds: 2)).then((value){
      _data.clear();
      _data.addAll(_loadData());
      _controller.finishRefresh();
      _controller.resetFooter();
    });
  }

  void _loadMoreData(){
    Future.delayed(const Duration(seconds: 2)).then((value){
      _data.addAll(_loadData());
      _controller.finishLoad(_data.length >= 100 ? IndicatorResult.noMore : IndicatorResult.success);
    });
  }
}

