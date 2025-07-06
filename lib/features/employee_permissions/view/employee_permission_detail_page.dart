import 'package:amnak/export.dart';
import 'package:amnak/features/employee_permissions/model/employee_permission_model.dart';
import 'package:amnak/features/employee_permissions/provider/employee_permission_provider.dart';
import 'package:provider/provider.dart';

class EmployeePermissionDetailPage extends StatefulWidget {
  final EmployeePermissionModel permission;

  const EmployeePermissionDetailPage({
    super.key,
    required this.permission,
  });

  @override
  State<EmployeePermissionDetailPage> createState() =>
      _EmployeePermissionDetailPageState();
}

class _EmployeePermissionDetailPageState
    extends State<EmployeePermissionDetailPage> {
  @override
  void initState() {
    super.initState();
    // Fetch detailed permission data
    EmployeePermissionProvider employeePermissionProvider =
        Provider.of<EmployeePermissionProvider>(context, listen: false);
    employeePermissionProvider
        .fetchPermissionDetails(widget.permission.id ?? 0);
  }

  @override
  void dispose() {
    // Clear the selected permission when leaving the page
    EmployeePermissionProvider employeePermissionProvider =
        Provider.of<EmployeePermissionProvider>(context, listen: false);
    employeePermissionProvider.clearSelectedPermission();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeePermissionProvider =
        Provider.of<EmployeePermissionProvider>(context);

    // Use the detailed data if available, otherwise use the passed permission
    final permission =
        employeePermissionProvider.selectedPermission ?? widget.permission;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.permissionDetails,
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: employeePermissionProvider.isLoadingDetails
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : employeePermissionProvider.errorMessageDetails != null
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
                        employeePermissionProvider.errorMessageDetails!,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          employeePermissionProvider.fetchPermissionDetails(
                              widget.permission.id ?? 0);
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
                      _buildHeaderCard(context, permission),
                      const SizedBox(height: 20),
                      _buildPermissionInfoCard(context, permission),
                      const SizedBox(height: 20),
                      if (permission.permissionImage != null)
                        _buildImageCard(context, permission),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeaderCard(
      BuildContext context, EmployeePermissionModel permission) {
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
              permission.personName ?? context.t.undefined,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              permission.companyName ?? context.t.undefined,
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                permission.permissionType ?? context.t.permissionType,
                style: context.textTheme.titleMedium?.copyWith(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionInfoCard(
      BuildContext context, EmployeePermissionModel permission) {
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
              context.t.permissionInformation,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoRow(
              context,
              context.t.project,
              permission.projectName ?? context.t.undefined,
              Icons.work,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              context.t.permissionDate,
              _formatDate(permission.dateTime),
              Icons.calendar_today,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              context.t.permissionId,
              '${permission.id ?? 0}',
              Icons.confirmation_number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(
      BuildContext context, EmployeePermissionModel permission) {
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
              context.t.permissionImage,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  permission.permissionImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 60,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            context.t.imageNotAvailable,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: kPrimaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
