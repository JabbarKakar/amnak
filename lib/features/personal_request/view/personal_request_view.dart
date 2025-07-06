import 'package:amnak/core/api_client.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/personal_request/provider/personal_request_provider.dart';
import 'package:amnak/features/personal_request_detail/view/personal_request_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../i18n/strings.g.dart';

class PersonalRequestScreen extends StatefulWidget {
  const PersonalRequestScreen({super.key});

  @override
  State<PersonalRequestScreen> createState() => _PersonalRequestScreenState();
}

class _PersonalRequestScreenState extends State<PersonalRequestScreen> {
  @override
  void initState() {
    super.initState();
    PersonalRequestProvider personalRequestProvider =
    Provider.of<PersonalRequestProvider>(context, listen: false);
    personalRequestProvider.fetchPersonalRequest();
  }

  @override
  Widget build(BuildContext context) {
    final personalRequestProvider = Provider.of<PersonalRequestProvider>(context);
    final theme = Theme.of(context);

    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(title: Text(context.t.myPersonalRequest), centerTitle: true),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: personalRequestProvider.isLoading
                ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
                : personalRequestProvider.personalRequestModel == null
                ? const Center(
              child: Text(
                'Failed to load requests',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (personalRequestProvider.personalRequestModel!.messages.isNotEmpty)
                Expanded(
                  child: personalRequestProvider.personalRequestModel!.data.isEmpty
                      ? const Center(
                    child: Text(
                      'No leave requests available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: personalRequestProvider.personalRequestModel!.data.length,
                    itemBuilder: (context, index) {
                      final datum = personalRequestProvider.personalRequestModel!.data[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                PersonalRequestDetailScreen( requestId: datum.id!.toInt(),),));
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: theme.primaryColor,
                                    child: Text(
                                      datum.id?.toString() ?? '#',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          datum.leaveType ?? 'Unknown Type',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          datum.reason ?? 'No reason provided',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 16,
                                              color: Colors.grey[700],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'From: ${datum.startDate != null ? DateFormat('yyyy-MM-dd').format(datum.startDate!) : 'N/A'}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 16,
                                              color: Colors.grey[700],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'To: ${datum.endDate != null ? DateFormat('yyyy-MM-dd').format(datum.endDate!) : 'N/A'}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(datum.status),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      datum.status?.toUpperCase() ?? 'UNKNOWN',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}