import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/employee_permissions/model/employee_permission_model.dart';
import 'package:amnak/features/employee_permissions/provider/employee_permission_provider.dart';
import 'package:amnak/features/employee_permissions/view/employee_permission_detail_page.dart';
import 'package:provider/provider.dart';

class EmployeePermissionsPage extends StatefulWidget {
  const EmployeePermissionsPage({super.key});

  @override
  State<EmployeePermissionsPage> createState() =>
      _EmployeePermissionsPageState();
}

class _EmployeePermissionsPageState extends State<EmployeePermissionsPage> {
  @override
  void initState() {
    super.initState();
    EmployeePermissionProvider employeePermissionProvider =
        Provider.of<EmployeePermissionProvider>(context, listen: false);
    employeePermissionProvider.fetchEmployeePermissions();
  }

  @override
  Widget build(BuildContext context) {
    final employeePermissionProvider =
        Provider.of<EmployeePermissionProvider>(context);

    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.t.employeePermissions,
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: employeePermissionProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : employeePermissionProvider.errorMessage != null
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
                          employeePermissionProvider.errorMessage!,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            employeePermissionProvider
                                .fetchEmployeePermissions();
                          },
                          child: Text(context.t.retry),
                        ),
                      ],
                    ),
                  )
                : employeePermissionProvider.employeePermissionWrapper?.data ==
                            null ||
                        employeePermissionProvider
                            .employeePermissionWrapper!.data!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.assignment_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              context.t.noPermissionsAvailable,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: employeePermissionProvider
                            .employeePermissionWrapper!.data!.length,
                        itemBuilder: (context, index) {
                          final permission = employeePermissionProvider
                              .employeePermissionWrapper!.data![index];
                          return EmployeePermissionCard(
                            permission: permission,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EmployeePermissionDetailPage(
                                    permission: permission,
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

class EmployeePermissionCard extends StatelessWidget {
  final EmployeePermissionModel permission;
  final VoidCallback onTap;

  const EmployeePermissionCard({
    super.key,
    required this.permission,
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
                          permission.personName ?? context.t.undefined,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          permission.companyName ?? context.t.undefined,
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
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  permission.permissionType ?? context.t.permissionType,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      context,
                      context.t.project,
                      permission.projectName ?? context.t.undefined,
                      Icons.work,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem(
                      context,
                      context.t.date,
                      _formatDate(permission.dateTime),
                      Icons.calendar_today,
                    ),
                  ),
                ],
              ),
              if (permission.permissionImage != null) ...[
                const SizedBox(height: 12),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      permission.permissionImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context, String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
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
