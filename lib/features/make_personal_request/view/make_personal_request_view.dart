import 'package:amnak/export.dart';
import 'package:amnak/features/make_personal_request/provider/make_personal_request_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MakePersonalRequestScreen extends StatefulWidget {
  const MakePersonalRequestScreen({super.key});

  @override
  State<MakePersonalRequestScreen> createState() => _MakePersonalRequestScreenState();
}

class _MakePersonalRequestScreenState extends State<MakePersonalRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _requestType;
  String? _reason;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider = Provider.of<MakePersonalRequestProvider>(context, listen: false);
      final success = await provider.makePersonalRequest(
        requestType: _requestType!,
        reason: _reason!,
        startDate: _startDate!,
        endDate: _endDate!,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.successMessage ?? 'Request created successfully',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
        provider.reset();
        Navigator.pop(context); // Return to previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.errorMessage ?? 'Failed to create request',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  String _getLeaveTypeName(int? leaveType) {
    switch (leaveType) {
      case 1:
        return 'Annual Leave';
      case 2:
        return 'Sick Leave';
      case 3:
        return 'Other';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MakePersonalRequestProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Leave Request',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.primaryColor, theme.primaryColorDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
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
          child: provider.isLoading
              ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
              : Form(
            key: _formKey,
            child: ListView(
              children: [
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'Request Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Annual Leave')),
                    DropdownMenuItem(value: 2, child: Text('Sick Leave')),
                    DropdownMenuItem(value: 3, child: Text('Other')),
                  ],
                  value: _requestType,
                  onChanged: (value) {
                    setState(() {
                      _requestType = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a request type' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Reason',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  onSaved: (value) => _reason = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a reason';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => _selectDate(context, true),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    child: Text(
                      _startDate != null
                          ? DateFormat('yyyy-MM-dd').format(_startDate!)
                          : 'Select start date',
                      style: TextStyle(
                        color: _startDate != null ? Colors.black : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => _selectDate(context, false),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    child: Text(
                      _endDate != null
                          ? DateFormat('yyyy-MM-dd').format(_endDate!)
                          : 'Select end date',
                      style: TextStyle(
                        color: _endDate != null ? Colors.black : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class MakePersonalRequestScreen extends StatefulWidget {
//   const MakePersonalRequestScreen({super.key});
//
//   @override
//   State<MakePersonalRequestScreen> createState() =>
//       _MakePersonalRequestScreenState();
// }
//
// class _MakePersonalRequestScreenState extends State<MakePersonalRequestScreen> {
//   final _formKey = GlobalKey<FormState>();
//   int? _requestType;
//   String? _reason;
//   DateTime? _startDate;
//   DateTime? _endDate;
//
//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2030),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: Theme.of(context).primaryColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = picked;
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
//   }
//
//   void _submitRequest() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       final provider =
//           Provider.of<MakePersonalRequestProvider>(context, listen: false);
//       final success = await provider.makePersonalRequest(
//         requestType: _requestType!,
//         reason: _reason!,
//         startDate: _startDate!,
//         endDate: _endDate!,
//       );
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               provider.successMessage ?? 'Request created successfully',
//               style: const TextStyle(color: Colors.white),
//             ),
//             backgroundColor: Colors.green,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//         provider.reset();
//         // Navigator.pop(context); // Return to previous screen
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               provider.errorMessage ?? 'Failed to create request',
//               style: const TextStyle(color: Colors.white),
//             ),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MakePersonalRequestProvider>(context);
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Create Leave Request',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         backgroundColor: theme.primaryColor,
//         elevation: 0,
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [theme.primaryColor, theme.primaryColorDark],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.grey[100]!, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: provider.isLoading
//               ? const Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                   ),
//                 )
//               : Form(
//                   key: _formKey,
//                   child: ListView(
//                     children: [
//                       DropdownButtonFormField<int>(
//                         decoration: InputDecoration(
//                           labelText: 'Request Type',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         items: const [
//                           DropdownMenuItem(
//                               value: 1, child: Text('Annual Leave')),
//                           DropdownMenuItem(value: 2, child: Text('Sick Leave')),
//                           DropdownMenuItem(value: 3, child: Text('Other')),
//                         ],
//                         value: _requestType,
//                         onChanged: (value) {
//                           setState(() {
//                             _requestType = value;
//                           });
//                         },
//                         validator: (value) => value == null
//                             ? 'Please select a request type'
//                             : null,
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Reason',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         maxLines: 3,
//                         onSaved: (value) => _reason = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a reason';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       InkWell(
//                         onTap: () => _selectDate(context, true),
//                         child: InputDecorator(
//                           decoration: InputDecoration(
//                             labelText: 'Start Date',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           child: Text(
//                             _startDate != null
//                                 ? DateFormat('yyyy-MM-dd').format(_startDate!)
//                                 : 'Select start date',
//                             style: TextStyle(
//                               color: _startDate != null
//                                   ? Colors.black
//                                   : Colors.grey[600],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       InkWell(
//                         onTap: () => _selectDate(context, false),
//                         child: InputDecorator(
//                           decoration: InputDecoration(
//                             labelText: 'End Date',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           child: Text(
//                             _endDate != null
//                                 ? DateFormat('yyyy-MM-dd').format(_endDate!)
//                                 : 'Select end date',
//                             style: TextStyle(
//                               color: _endDate != null
//                                   ? Colors.black
//                                   : Colors.grey[600],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       ElevatedButton(
//                         onPressed: (){
//                           debugPrint('Request Type: $_requestType');
//                           _submitRequest();
//
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: theme.primaryColor,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           'Submit Request',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
