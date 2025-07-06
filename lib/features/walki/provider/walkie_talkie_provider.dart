import 'dart:io';
import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/walki/models/walkie_talkie_models.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

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

  WalkieTalkieMessagesWrapper? _allMessagesWrapper;
  WalkieTalkieMessagesWrapper? get allMessagesWrapper => _allMessagesWrapper;

  WalkieTalkieChannelMessagesWrapper? _channelMessagesWrapper;
  WalkieTalkieChannelMessagesWrapper? get channelMessagesWrapper =>
      _channelMessagesWrapper;

  // Loading states
  bool _isLoadingToken = false;
  bool get isLoadingToken => _isLoadingToken;

  bool _isLoadingContacts = false;
  bool get isLoadingContacts => _isLoadingContacts;

  bool _isLoadingMessage = false;
  bool get isLoadingMessage => _isLoadingMessage;

  bool _isLoadingAllMessages = false;
  bool get isLoadingAllMessages => _isLoadingAllMessages;

  bool _isLoadingChannelMessages = false;
  bool get isLoadingChannelMessages => _isLoadingChannelMessages;

  // Error states
  String? _errorMessageToken;
  String? get errorMessageToken => _errorMessageToken;

  String? _errorMessageContacts;
  String? get errorMessageContacts => _errorMessageContacts;

  String? _errorMessageSend;
  String? get errorMessageSend => _errorMessageSend;

  String? _errorMessageAllMessages;
  String? get errorMessageAllMessages => _errorMessageAllMessages;

  String? _errorMessageChannelMessages;
  String? get errorMessageChannelMessages => _errorMessageChannelMessages;

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

        // Check if there's an audio file to upload
        String? audioPath = messageData['audio_path'];
        if (audioPath != null && audioPath.isNotEmpty && audioPath != '') {
          // Remove the audio_path from messageData as it will be handled separately
          messageData.remove('audio_path');

          // Upload the audio file first
          final audioFile = File(audioPath);
          if (await audioFile.exists()) {
            // Create FormData for file upload
            final formData = FormData.fromMap({
              ...messageData,
              'audio': await MultipartFile.fromFile(
                audioPath,
                filename:
                    'voice_message_${DateTime.now().millisecondsSinceEpoch}.aac',
              ),
            });

            // Use uploadImage method pattern but for audio
            final headers = await apiClient.getHeaders();
            final dio = Dio(BaseOptions(
              baseUrl: 'https://api.amnak.app/api',
              headers: headers,
            ));
            try {
              final response = await dio.post(
                '/waike_toky/message/store',
                data: formData,
              );

              if (response.statusCode == 200) {
                _messageWrapper =
                    WalkieTalkieMessageWrapper.fromJson(response.data);
                if (_messageWrapper?.messages?.isNotEmpty ?? false) {
                  print('Message sent successfully: ${_messageWrapper?.messages} ');
                }
                if (_messageWrapper?.data != null) {
                  print('Message sent successfully: ${_messageWrapper?.data!.toJson()} ');
                }
                // Refresh messages after sending
                // await getAllMessages();
              } else {
                _errorMessageSend = 'Failed to send voice message';
              }
            } catch (e) {
              print('Error uploading audio: $e');
              _errorMessageSend = 'Error uploading audio: ${e.toString()}';
            }
          } else {
            _errorMessageSend = 'Audio file not found';
          }
        } else {
          // Send regular text message
          final response = await apiClient.post(
            url: '/waike_toky/message/store',
            params: messageData,
          );

          if (response.statusCode == 200) {
            _messageWrapper =
                WalkieTalkieMessageWrapper.fromJson(response.data);
            if (_messageWrapper?.messages?.isNotEmpty ?? false) {
              print('Message sent successfully: ${_messageWrapper?.messages} ');
            }
            if (_messageWrapper?.data != null) {
              print('Message sent successfully: ${_messageWrapper?.data!.toJson()} ');
            }
            // Refresh messages after sending
            // await getAllMessages();
          } else {
            _errorMessageSend = 'Failed to send message';
          }
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

  // Get All Messages
  Future<void> getAllMessages() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoadingAllMessages = true;
        _errorMessageAllMessages = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/waike_toky/messages',
        );

        if (response.statusCode == 200) {
          _allMessagesWrapper =
              WalkieTalkieMessagesWrapper.fromJson(response.data);
          if (_allMessagesWrapper?.messages?.isNotEmpty ?? false) {
            print('All Messages: ${_allMessagesWrapper?.messages}');
          }
        } else {
          _errorMessageAllMessages = 'Failed to load messages';
        }
      } catch (e) {
        print('Error fetching all messages: $e');
        _errorMessageAllMessages = 'Error: ${e.toString()}';
      } finally {
        _isLoadingAllMessages = false;
        notifyListeners();
      }
    } else {
      _errorMessageAllMessages = 'No internet connection';
      _isLoadingAllMessages = false;
      notifyListeners();
    }
  }

  // Get Channel Messages
  Future<void> getChannelMessages(String channelName) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoadingChannelMessages = true;
        _errorMessageChannelMessages = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/waike_toky/messages/$channelName',
        );

        if (response.statusCode == 200) {
          _channelMessagesWrapper =
              WalkieTalkieChannelMessagesWrapper.fromJson(response.data);
          if (_channelMessagesWrapper?.messages?.isNotEmpty ?? false) {
            print('Channel Messages: ${_channelMessagesWrapper?.messages}');
          }
        } else {
          _errorMessageChannelMessages = 'Failed to load channel messages';
        }
      } catch (e) {
        print('Error fetching channel messages: $e');
        _errorMessageChannelMessages = 'Error: ${e.toString()}';
      } finally {
        _isLoadingChannelMessages = false;
        notifyListeners();
      }
    } else {
      _errorMessageChannelMessages = 'No internet connection';
      _isLoadingChannelMessages = false;
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

  void clearAllMessagesError() {
    _errorMessageAllMessages = null;
    notifyListeners();
  }

  void clearChannelMessagesError() {
    _errorMessageChannelMessages = null;
    notifyListeners();
  }

  // Clear all data
  void clearData() {
    _agoraTokenWrapper = null;
    _contactsWrapper = null;
    _messageWrapper = null;
    _allMessagesWrapper = null;
    _channelMessagesWrapper = null;
    _errorMessageToken = null;
    _errorMessageContacts = null;
    _errorMessageSend = null;
    _errorMessageAllMessages = null;
    _errorMessageChannelMessages = null;
    notifyListeners();
  }
}
