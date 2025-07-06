import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/walki/models/walkie_talkie_models.dart';
import 'package:amnak/features/walki/provider/walkie_talkie_provider.dart';
import 'package:amnak/features/walki/view/walkie_talkie_messages_page.dart';
import 'package:amnak/features/walki/walki_page.dart';
import 'package:provider/provider.dart';

class WalkieTalkieContactsPage extends StatefulWidget {
  const WalkieTalkieContactsPage({super.key, required this.projectId});

  final int projectId;
  @override
  State<WalkieTalkieContactsPage> createState() =>
      _WalkieTalkieContactsPageState();
}

class _WalkieTalkieContactsPageState extends State<WalkieTalkieContactsPage> {
  @override
  void initState() {
    super.initState();
    // Load contacts for project ID 9 (you can make this dynamic)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WalkieTalkieProvider>().getWalkieTalkieContacts(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Walkie Talkie Contacts',
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                context.read<WalkieTalkieProvider>().getWalkieTalkieContacts(widget.projectId);
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Consumer<WalkieTalkieProvider>(
          builder: (context, provider, child) {
            if (provider.isLoadingContacts) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.errorMessageContacts != null) {
              return Center(
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
                      provider.errorMessageContacts!,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        provider.getWalkieTalkieContacts(widget.projectId);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final contacts = provider.contactsWrapper?.data;
            if (contacts == null) {
              return const Center(
                child: Text('No contacts available'),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Section
                  if (contacts.company != null) ...[
                    _buildSectionTitle('Company'),
                    _buildContactCard(
                      contacts.company!.name ?? 'Unknown Company',
                      Icons.business,
                      () => _startCall(contacts.company!.id??0,contacts.company!.name ?? 'company',contacts.company!.type??'App\\Models\\Company'),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Voice Groups Section
                  if (contacts.voiceGroups != null &&
                      contacts.voiceGroups!.isNotEmpty) ...[
                    _buildSectionTitle('Voice Groups'),
                    ...contacts.voiceGroups!.map((group) => _buildContactCard(
                          group.name ?? 'Unknown Group',
                          Icons.group,
                          () => _startCall(group.id??0,group.name ?? 'group','group${group.id}'),
                        )),
                    const SizedBox(height: 20),
                  ],

                  // Individual Persons Section
                  if (contacts.personsIndividual != null &&
                      contacts.personsIndividual!.isNotEmpty) ...[
                    _buildSectionTitle('Individuals'),
                    ...contacts.personsIndividual!
                        .map((person) => _buildContactCard(
                              person.name ?? 'Unknown Person',
                              Icons.person,
                              () => _startCall(person.id??0,person.name ?? 'person',contacts.company!.type??'App\\Models\\Person'),
                            )),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kPrimaryColor.withOpacity(0.1),
          child: Icon(
            icon,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          name,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.call,
            color: kPrimaryColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Future<void> _startCall(int id, String channelName, String type) async {
    final provider = context.read<WalkieTalkieProvider>();

    // // Show loading dialog
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );

    try {
      // Generate Agora token
      await provider.generateAgoraToken(channelName);

      // Close loading dialog
      Navigator.of(context).pop();

      if (provider.agoraTokenWrapper?.data?.token != null) {
        // Navigate to WalkiPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalkieTalkieMessagesPage(
              id: id, type: type,
              channel: channelName,
              token: provider.agoraTokenWrapper!.data!.token!,
            ),
          ),
        );
      } else {
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(provider.errorMessageToken ?? 'Failed to generate token'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
