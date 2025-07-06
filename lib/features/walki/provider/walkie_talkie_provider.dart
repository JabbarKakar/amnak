import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/walki/models/walkie_talkie_models.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

class WalkieTalkieProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  // Data
  AgoraTokenWrapper? _agoraTokenWrapper;
  AgoraTokenWrapper? get agoraTokenWrapper => _agoraTokenWrapper;

  WalkieTalkieContactsWrapper? _contactsWrapper;
  WalkieTalkieContactsWrapper? get contactsWrapper => _contactsWrapper;

  WalkieTalkieMessageWrapper? _messageWrapper;
  WalkieTalkieMessageWrapper? get messageWrapper => _messageWrapper;

  // Loading states
  bool _isLoadingToken = false;
  bool get isLoadingToken => _isLoadingToken;

  bool _isLoadingContacts = false;
  bool get isLoadingContacts => _isLoadingContacts;

  bool _isLoadingMessage = false;
  bool get isLoadingMessage => _isLoadingMessage;

  // Error states
  String? _errorMessageToken;
  String? get errorMessageToken => _errorMessageToken;

  String? _errorMessageContacts;
  String? get errorMessageContacts => _errorMessageContacts;

  String? _errorMessageSend;
  String? get errorMessageSend => _errorMessageSend;

  // Generate Agora Token
  Future<void> generateAgoraToken(String channelName) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoadingToken = true;
        _errorMessageToken = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/generate_agora_token',
          queryParameters: {'channel_name': channelName},
        );

        if (response.statusCode == 200) {
          _agoraTokenWrapper = AgoraTokenWrapper.fromJson(response.data);
          if (_agoraTokenWrapper?.messages?.isNotEmpty ?? false) {
            print('Agora Token Messages: ${_agoraTokenWrapper?.messages}');
          }
        } else {
          _errorMessageToken = 'Failed to generate Agora token';
        }
      } catch (e) {
        print('Error generating Agora token: $e');
        _errorMessageToken = 'Error: ${e.toString()}';
      } finally {
        _isLoadingToken = false;
        notifyListeners();
      }
    } else {
      _errorMessageToken = 'No internet connection';
      _isLoadingToken = false;
      notifyListeners();
    }
  }

  // Get Walkie Talkie Contacts
  Future<void> getWalkieTalkieContacts(int projectId) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoadingContacts = true;
        _errorMessageContacts = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/waike_toky/contacts',
          queryParameters: {'project_id': projectId},
        );

        if (response.statusCode == 200) {
          _contactsWrapper =
              WalkieTalkieContactsWrapper.fromJson(response.data);
          if (_contactsWrapper?.messages?.isNotEmpty ?? false) {
            print('Contacts Messages: ${_contactsWrapper?.messages}');
          }
        } else {
          _errorMessageContacts = 'Failed to load contacts';
        }
      } catch (e) {
        print('Error fetching contacts: $e');
        _errorMessageContacts = 'Error: ${e.toString()}';
      } finally {
        _isLoadingContacts = false;
        notifyListeners();
      }
    } else {
      _errorMessageContacts = 'No internet connection';
      _isLoadingContacts = false;
      notifyListeners();
    }
  }

  // Send Walkie Talkie Message
  Future<void> sendWalkieTalkieMessage(Map<String, dynamic> messageData) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoadingMessage = true;
        _errorMessageSend = null;
        notifyListeners();

        final response = await apiClient.post(
          url: '/waike_toky/message/store',
          params: messageData,
        );

        if (response.statusCode == 200) {
          _messageWrapper = WalkieTalkieMessageWrapper.fromJson(response.data);
          if (_messageWrapper?.messages?.isNotEmpty ?? false) {
            print('Message sent successfully: ${_messageWrapper?.messages}');
          }
        } else {
          _errorMessageSend = 'Failed to send message';
        }
      } catch (e) {
        print('Error sending message: $e');
        _errorMessageSend = 'Error: ${e.toString()}';
      } finally {
        _isLoadingMessage = false;
        notifyListeners();
      }
    } else {
      _errorMessageSend = 'No internet connection';
      _isLoadingMessage = false;
      notifyListeners();
    }
  }

  // Clear error messages
  void clearTokenError() {
    _errorMessageToken = null;
    notifyListeners();
  }

  void clearContactsError() {
    _errorMessageContacts = null;
    notifyListeners();
  }

  void clearMessageError() {
    _errorMessageSend = null;
    notifyListeners();
  }

  // Clear all data
  void clearData() {
    _agoraTokenWrapper = null;
    _contactsWrapper = null;
    _messageWrapper = null;
    _errorMessageToken = null;
    _errorMessageContacts = null;
    _errorMessageSend = null;
    notifyListeners();
  }
}
