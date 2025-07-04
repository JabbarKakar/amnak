import 'package:amnak/core/feature/data/models/visitors_wrapper.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';

class VisitorDetailsPage extends StatelessWidget {
  const VisitorDetailsPage({super.key, required this.visitor});
  final VisitorModel visitor;

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(4),
        content: SizedBox(
          width: 1.sw,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('${context.t.name}: ${visitor.name}'),
                subtitle: Text('${context.t.carNumber}: ${visitor.carNumber}'),
              ),
              ListTile(
                title: Text('${context.t.id}: ${visitor.id}'),
                subtitle: Text('${context.t.idNumber}: ${visitor.idNumber}'),
              ),
              ListTile(
                title: Text('${context.t.companyName}: ${visitor.companyName}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
