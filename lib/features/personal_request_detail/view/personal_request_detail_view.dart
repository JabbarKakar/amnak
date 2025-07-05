import 'package:amnak/features/personal_request_detail/provider/personal_request_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PersonalRequestDetailScreen extends StatefulWidget {
  final int requestId;

  const PersonalRequestDetailScreen({super.key, required this.requestId});

  @override
  State<PersonalRequestDetailScreen> createState() => _PersonalRequestDetailScreenState();
}

class _PersonalRequestDetailScreenState extends State<PersonalRequestDetailScreen> {
  @override
  void initState() {
    super.initState();
    PersonalRequestDetailProvider personalRequestDetailProvider =
    Provider.of<PersonalRequestDetailProvider>(context, listen: false);
    personalRequestDetailProvider.fetchPersonalRequestDetail(id: widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    final personalRequestDetailProvider = Provider.of<PersonalRequestDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Request Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: personalRequestDetailProvider.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : personalRequestDetailProvider.personalRequestDetailModel == null
            ? const Center(
          child: Text(
            'Failed to load request details',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (personalRequestDetailProvider.personalRequestDetailModel!.messages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  personalRequestDetailProvider.personalRequestDetailModel!.messages.join(', '),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      context,
                      'Request ID',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.id?.toString() ?? 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Person ID',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.personId?.toString() ?? 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Leave Type',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.leaveType ?? 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Start Date',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.startDate != null
                          ? DateFormat('yyyy-MM-dd').format(personalRequestDetailProvider.personalRequestDetailModel!.data!.startDate!)
                          : 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'End Date',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.endDate != null
                          ? DateFormat('yyyy-MM-dd').format(personalRequestDetailProvider.personalRequestDetailModel!.data!.endDate!)
                          : 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Reason',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.reason ?? 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Status',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.status ?? 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Company ID',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.companyId?.toString() ?? 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Created At',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.createdAt != null
                          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(personalRequestDetailProvider.personalRequestDetailModel!.data!.createdAt!)
                          : 'N/A',
                    ),
                    _buildDetailRow(
                      context,
                      'Updated At',
                      personalRequestDetailProvider.personalRequestDetailModel!.data?.updatedAt != null
                          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(personalRequestDetailProvider.personalRequestDetailModel!.data!.updatedAt!)
                          : 'N/A',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}