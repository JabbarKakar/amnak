import 'package:amnak/features/safety_check_details/provider/safety_check_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SafetyCheckDetailsScreen extends StatelessWidget {
  final String safetyCheckId;

  const SafetyCheckDetailsScreen({Key? key, required this.safetyCheckId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SafetyCheckDetailsProvider()..fetchSafetyCheckDetails(safetyCheckId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل فحص السلامة'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Consumer<SafetyCheckDetailsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)));
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
                    Card(
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
                            Text('معرف التقرير: ${safetyReports?.id ?? 'غير متوفر'}'),
                            Text('اسم عنصر فحص السلامة: ${safetyReports?.safetyCheckItemName ?? 'غير متوفر'}'),
                            Text('ملاحظات: ${safetyReports?.notes ?? 'غير متوفر'}'),
                            Text('حالة التعامل: ${safetyReports?.handled ?? 'غير متوفر'}'),
                            Text('تاريخ الإنشاء: ${safetyReports?.createdAt?.toLocal().toString() ?? 'غير متوفر'}'),
                            Text('تاريخ التحديث: ${safetyReports?.updatedAt?.toLocal().toString() ?? 'غير متوفر'}'),
                            const SizedBox(height: 8),
                            if (safetyReports?.attachments?.path != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('المرفقات:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  safetyReports!.attachments!.type == 'image'
                                      ? Image.network(
                                    safetyReports.attachments!.path!,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Text('فشل تحميل الصورة'),
                                  )
                                      : Text('نوع المرفق: ${safetyReports.attachments!.type}'),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}