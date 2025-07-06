import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/safety_checks_project_details/provider/safety_checks_project_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../i18n/strings.g.dart';

class SafetyCheckProjectDetailsScreen extends StatelessWidget {
  final String safetyCheckId;

  const SafetyCheckProjectDetailsScreen({Key? key, required this.safetyCheckId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SafetyChecksProjectProvider()..fetchSafetyCheckProjectDetails(id: safetyCheckId),
      child: LanguageDirection(
        child: Scaffold(
          appBar: AppBar(title: Text(context.t.safetyCheckDetails), centerTitle: true),
          body: Consumer<SafetyChecksProjectProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
        
              if (provider.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => provider.fetchSafetyCheckProjectDetails(id: safetyCheckId),
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }
        
              final details = provider.safetyCheckDetails;
              if (details == null || details.data == null) {
                return const Center(child: Text('لا توجد بيانات متاحة'));
              }
        
              final projectDetails = details.data!.projectDetails;
              final safetyReports = details.data!.safetyReports;
        
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      // Project Details Section
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'تفاصيل المشروع',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('معرف المشروع: ${projectDetails?.projectId ?? 'غير متوفر'}'),
                              Text('اسم المشروع: ${projectDetails?.projectName ?? 'غير متوفر'}'),
                            ],
                          ),
                        ),
                      ),
                      // Safety Reports Section
                      ...safetyReports.map((report) => Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'تقرير السلامة',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('معرف التقرير: ${report.id ?? 'غير متوفر'}'),
                              Text('اسم عنصر فحص السلامة: ${report.safetyCheckItemName ?? 'غير متوفر'}'),
                              Text('ملاحظات: ${report.notes ?? 'غير متوفر'}'),
                              Text('حالة التعامل: ${report.handled ?? 'غير متوفر'}'),
                              Text('تاريخ الإنشاء: ${report.createdAt?.toLocal().toString() ?? 'غير متوفر'}'),
                              Text('تاريخ التحديث: ${report.updatedAt?.toLocal().toString() ?? 'غير متوفر'}'),
                              const SizedBox(height: 8),
                              if (report.attachments?.path != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('المرفقات:', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    report.attachments!.type == 'image'
                                        ? Image.network(
                                      report.attachments!.path!,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                      const Text('فشل تحميل الصورة'),
                                    )
                                        : Text('نوع المرفق: ${report.attachments!.type}'),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}