import 'package:amnak/features/personal_request_types/provider/pesonal_request_provider_types.dart';
import 'package:amnak/features/personal_request_detail/view/personal_request_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalRequestTypesScreen extends StatefulWidget {
  const PersonalRequestTypesScreen({super.key});

  @override
  State<PersonalRequestTypesScreen> createState() => _PersonalRequestTypesScreenState();
}

class _PersonalRequestTypesScreenState extends State<PersonalRequestTypesScreen> {
  @override
  void initState() {
    super.initState();
    PersonalRequestTypesProvider personalRequestProvider =
    Provider.of<PersonalRequestTypesProvider>(context, listen: false);
    personalRequestProvider.fetchPersonalRequestTypes();
  }

  @override
  Widget build(BuildContext context) {
    final personalRequestProvider = Provider.of<PersonalRequestTypesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Request Types'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: personalRequestProvider.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : personalRequestProvider.personalRequestTypeModel == null
            ? const Center(
          child: Text(
            'Failed to load data',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (personalRequestProvider.personalRequestTypeModel!.messages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  personalRequestProvider.personalRequestTypeModel!.messages.join(', '),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ),
            Expanded(
              child: personalRequestProvider.personalRequestTypeModel!.data.isEmpty
                  ? const Center(
                child: Text(
                  'No request types available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: personalRequestProvider.personalRequestTypeModel!.data.length,
                itemBuilder: (context, index) {
                  final datum = personalRequestProvider.personalRequestTypeModel!.data[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 2,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalRequestDetailScreen( requestId: datum.id!.toInt(),),));
                      },
                      title: Text(
                        datum.name ?? 'Unnamed',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Created: ${datum.createdAt != null ? DateFormat('yyyy-MM-dd').format(datum.createdAt!) : 'N/A'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      leading: CircleAvatar(
                        child: Text(
                          datum.id?.toString() ?? '#',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}