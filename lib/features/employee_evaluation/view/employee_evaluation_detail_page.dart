import 'package:amnak/export.dart';
import 'package:amnak/features/employee_evaluation/model/employee_evaluation_model.dart';
import 'package:amnak/features/employee_evaluation/provider/employee_evaluation_provider.dart';
import 'package:provider/provider.dart';

class EmployeeEvaluationDetailPage extends StatefulWidget {
  final EmployeeEvaluationModel evaluation;

  const EmployeeEvaluationDetailPage({
    super.key,
    required this.evaluation,
  });

  @override
  State<EmployeeEvaluationDetailPage> createState() =>
      _EmployeeEvaluationDetailPageState();
}

class _EmployeeEvaluationDetailPageState
    extends State<EmployeeEvaluationDetailPage> {
  @override
  void initState() {
    super.initState();
    // Fetch detailed evaluation data
    EmployeeEvaluationProvider employeeEvaluationProvider =
        Provider.of<EmployeeEvaluationProvider>(context, listen: false);
    employeeEvaluationProvider
        .fetchEvaluationDetails(widget.evaluation.id ?? 0);
  }

  @override
  void dispose() {
    // Clear the selected evaluation when leaving the page
    EmployeeEvaluationProvider employeeEvaluationProvider =
        Provider.of<EmployeeEvaluationProvider>(context, listen: false);
    employeeEvaluationProvider.clearSelectedEvaluation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeEvaluationProvider =
        Provider.of<EmployeeEvaluationProvider>(context);

    // Use the detailed data if available, otherwise use the passed evaluation
    final evaluation =
        employeeEvaluationProvider.selectedEvaluation ?? widget.evaluation;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.evaluationDetails,
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: employeeEvaluationProvider.isLoadingDetails
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : employeeEvaluationProvider.errorMessageDetails != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        employeeEvaluationProvider.errorMessageDetails!,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          employeeEvaluationProvider.fetchEvaluationDetails(
                              widget.evaluation.id ?? 0);
                        },
                        child: Text(context.t.retry),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderCard(context, evaluation),
                      const SizedBox(height: 20),
                      _buildScoreCard(context, evaluation),
                      const SizedBox(height: 20),
                      _buildDetailsCard(context, evaluation),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeaderCard(
      BuildContext context, EmployeeEvaluationModel evaluation) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: kPrimaryColor.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: kPrimaryColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              evaluation.personName ?? context.t.undefined,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              evaluation.companyName ?? context.t.undefined,
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                evaluation.evaluationTitle ?? context.t.evaluationTitle,
                style: context.textTheme.titleMedium?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(
      BuildContext context, EmployeeEvaluationModel evaluation) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.evaluationSummary,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildScoreItem(
                    context,
                    context.t.totalScore,
                    '${evaluation.totalScore ?? 0}',
                    Icons.star,
                    kPrimaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildScoreItem(
                    context,
                    context.t.averageScore,
                    '${evaluation.averageScore?.toStringAsFixed(1) ?? '0.0'}',
                    Icons.analytics,
                    kSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildScoreItem(
                    context,
                    context.t.numberOfItems,
                    '${evaluation.details?.length ?? 0}',
                    Icons.list,
                    kDarkGreen,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildScoreItem(
                    context,
                    context.t.evaluationDate,
                    _formatDate(evaluation.createdAt),
                    Icons.calendar_today,
                    kYellowColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(
      BuildContext context, EmployeeEvaluationModel evaluation) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.evaluationItems,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 16),
            if (evaluation.details == null || evaluation.details!.isEmpty)
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 60,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.t.noDetailsAvailable,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: evaluation.details!.length,
                itemBuilder: (context, index) {
                  final detail = evaluation.details![index];
                  return _buildDetailItem(context, detail, index + 1);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      BuildContext context, EvaluationDetailModel detail, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '$index',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.evaluationItem ?? context.t.evaluationItem,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${context.t.date}: ${_formatDate(detail.createdAt)}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getScoreColor(detail.score ?? 0).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${detail.score ?? 0}',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: _getScoreColor(detail.score ?? 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(BuildContext context, String label, String value,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 8) return kDarkGreen;
    if (score >= 6) return kSecondaryColor;
    if (score >= 4) return kYellowColor;
    return kRed;
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return context.t.undefined;
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return context.t.undefined;
    }
  }
}
