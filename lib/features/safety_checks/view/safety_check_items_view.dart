import 'package:amnak/features/safety_check_details/view/safety_check_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/safety_check_items_provider.dart';



class SafetyCheckItemsScreen extends StatefulWidget {

  const SafetyCheckItemsScreen({super.key});

  @override
  State<SafetyCheckItemsScreen> createState() => _SafetyCheckItemsScreenState();
}

class _SafetyCheckItemsScreenState extends State<SafetyCheckItemsScreen> {
  @override
  void initState() {
    super.initState();
    SafetyCheckItemsProvider safetyCheckProvider =
    Provider.of<SafetyCheckItemsProvider>(context, listen: false);
    safetyCheckProvider.fetchSafetyCheck();
  }

  @override
  Widget build(BuildContext context) {
    final safetyCheckProvider = Provider.of<SafetyCheckItemsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Check Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: safetyCheckProvider.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : safetyCheckProvider.safetyCheckModel == null
            ? const Center(
          child: Text(
            'Failed to load safety check details',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (safetyCheckProvider.safetyCheckModel!.messages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  safetyCheckProvider.safetyCheckModel!.messages.join(', '),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ),
            Expanded(
              child: safetyCheckProvider.safetyCheckModel!.data.isEmpty
                  ? const Center(
                child: Text(
                  'No safety checks available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: safetyCheckProvider.safetyCheckModel!.data.length,
                itemBuilder: (context, index) {
                  final datum = safetyCheckProvider.safetyCheckModel!.data[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        // Navigate to details page if needed
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SafetyCheckDetailsScreen(safetyCheckId: datum.id.toString(),)));
                      },
                      title: Text(
                        datum.name ?? 'Unnamed',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Active: ${datum.active == 1 ? 'Yes' : 'No'}',
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