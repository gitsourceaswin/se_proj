import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/widgets/home.dart';
import 'package:ewallet/widgets/makepayment.dart';
import 'package:ewallet/widgets/tarnsaction.dart';
import 'package:flutter/material.dart';

class MyWidgetRecharge extends StatelessWidget {
  final String username;
   MyWidgetRecharge({required this.username});

  @override
  Widget build(BuildContext context) {
    final CollectionReference recharge_details = FirebaseFirestore.instance.collection('recharge_details');
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Wallet"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        elevation: 10,
      ),
      body: StreamBuilder(
        stream: recharge_details.snapshots(),
        builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot recharge_snap = snapshot.data!.docs[index];
                  if(username == recharge_snap['recharge_to']){
                    return Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                shadowColor: Colors.amber,
                color: Colors.blue,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        leading: Icon(Icons.arrow_back),
                        title: Column(
                          children: [
                            Column(
                              
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text("Amount " + recharge_snap['amount'].toString()),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(recharge_snap['Date']),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ] ,
                ),
              ),
            );
           }
           else{
            return Container();
           }
                  
                },
                );
            }
            return Container();
        },
        ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        currentIndex: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.deepPurple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt,color: Colors.deepPurple),
            label: 'Recharge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows,color: Colors.deepPurple),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment,color: Colors.deepPurple),
            label: 'Make Payment',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidgetHome(username: username)));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidgetTransaction(username: username)));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidgetMakePayment(username: username)));
          }
        },
      ),
    );
  }
}
