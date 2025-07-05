import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/employee_evaluation/model/employee_evaluation_model.dart';
import 'package:amnak/features/employee_evaluation/provider/employee_evaluation_provider.dart';
import 'package:amnak/features/employee_evaluation/view/employee_evaluation_detail_page.dart';
import 'package:provider/provider.dart';

class EmployeeEvaluationPage extends StatefulWidget {
  const EmployeeEvaluationPage({super.key});

  @override
  State<EmployeeEvaluationPage> createState() => _EmployeeEvaluationPageState();
}

class _EmployeeEvaluationPageState extends State<EmployeeEvaluationPage> {
  @override
  void initState() {
    super.initState();
    EmployeeEvaluationProvider employeeEvaluationProvider =
        Provider.of<EmployeeEvaluationProvider>(context, listen: false);
    employeeEvaluationProvider.fetchEmployeeEvaluations();
  }

  @override
  Widget build(BuildContext context) {
    final employeeEvaluationProvider =
        Provider.of<EmployeeEvaluationProvider>(context);

    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.t.employeeEvaluation,
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: employeeEvaluationProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : employeeEvaluationProvider.errorMessage != null
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
                          employeeEvaluationProvider.errorMessage!,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            employeeEvaluationProvider
                                .fetchEmployeeEvaluations();
                          },
                          child: Text(context.t.retry),
                        ),
                      ],
                    ),
                  )
                : employeeEvaluationProvider.employeeEvaluationWrapper?.data ==
                            null ||
                        employeeEvaluationProvider
                            .employeeEvaluationWrapper!.data!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.assessment_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              context.t.noEvaluationsAvailable,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: employeeEvaluationProvider
                            .employeeEvaluationWrapper!.data!.length,
                        itemBuilder: (context, index) {
                          final evaluation = employeeEvaluationProvider
                              .employeeEvaluationWrapper!.data![index];
                          return EmployeeEvaluationCard(
                            evaluation: evaluation,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EmployeeEvaluationDetailPage(
                                    evaluation: evaluation,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
      ),
    );
  }
}

class EmployeeEvaluationCard extends StatelessWidget {
  final EmployeeEvaluationModel evaluation;
  final VoidCallback onTap;

  const EmployeeEvaluationCard({
    super.key,
    required this.evaluation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: kPrimaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          evaluation.personName ?? context.t.undefined,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          evaluation.companyName ?? context.t.undefined,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  evaluation.evaluationTitle ?? context.t.evaluationTitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildScoreItem(
                    context,
                    context.t.totalScore,
                    '${evaluation.totalScore ?? 0}',
                    Icons.star,
                  ),
                  _buildScoreItem(
                    context,
                    context.t.averageScore,
                    '${evaluation.averageScore?.toStringAsFixed(1) ?? '0.0'}',
                    Icons.analytics,
                  ),
                  _buildScoreItem(
                    context,
                    context.t.numberOfItems,
                    '${evaluation.details?.length ?? 0}',
                    Icons.list,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${context.t.evaluationDate}:',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    _formatDate(evaluation.createdAt),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreItem(
      BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: kPrimaryColor,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Undefined';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Undefined';
    }
  }
}
