import 'package:flutter/material.dart';
import 'package:msf/data/model/list/mock_bloodBoners_list.dart';
import 'package:msf/widgets/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonersScreen extends StatefulWidget {
  const BloodDonersScreen({Key? key}) : super(key: key);

  @override
  _BloodDonersScreenState createState() => _BloodDonersScreenState();
}

class _BloodDonersScreenState extends State<BloodDonersScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood Doners'),
      ),
      body:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchView(onTextChange: (String ) { },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: BloodDonersEntries.length,
                    itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text('${BloodDonersEntries[index].name}'),
                        subtitle: Text('${BloodDonersEntries[index].address}'),
                        trailing: IconButton(
                          iconSize: 18,
                          icon: const Icon(Icons.call),
                          color: theme.colorScheme.secondary,
                          onPressed:() {
                            launch(('tel://${BloodDonersEntries[index].phoneNo}'));
                          },
                        ),

                      ),
                    );
                  },

                  )
                ),

              ],
            ),
      );
  }
}
