import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/walki/models/walkie_talkie_models.dart';
import 'package:amnak/features/walki/provider/walkie_talkie_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class WalkieTalkieMessagesPage extends StatefulWidget {
  const WalkieTalkieMessagesPage(
      {super.key,
      required this.id,
      required this.channel,
      required this.token,
      required this.type});
  final int id;
  final String token;
  final String channel;
  final String type;

  @override
  State<WalkieTalkieMessagesPage> createState() => _WalkiPageState();
}

// Application state class
class _WalkiPageState extends State<WalkieTalkieMessagesPage> {
  late RtcEngine _engine;
  bool _isConnected = false;
  List<int> _remoteUsers = [];
  Timer? _messageTimer;

  // Voice recording
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String? _currentlyPlayingMessageId;
  String? _recordedFilePath;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;

  // Text message controller
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load channel messages
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WalkieTalkieProvider>().getChannelMessages(widget.channel);
    });
  }

  // Voice recording methods
  Future<void> _startRecording() async {
    try {
      // Request microphone permission
      if (await Permission.microphone.request().isGranted) {
        // Get temporary directory for recording
        final tempDir = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        _recordedFilePath = '${tempDir.path}/voice_message_$timestamp.wav';

        // Start recording
        await _audioRecorder.start(
          RecordConfig(
            encoder: AudioEncoder.wav,
            bitRate: 128000,
            sampleRate: 44100,
            numChannels: 1,
          ),
          path: _recordedFilePath!,
        );

        setState(() {
          _isRecording = true;
          _recordingDuration = Duration.zero;
        });

        // Start timer to track recording duration
        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _recordingDuration += const Duration(seconds: 1);
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
      }
    } catch (e) {
      print('Error starting recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error starting recording: $e')),
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      _recordingTimer?.cancel();

      setState(() {
        _isRecording = false;
      });

      // Send the voice message
      if (_recordedFilePath != null) {
        await _sendVoiceMessage();
      }
    } catch (e) {
      print('Error stopping recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error stopping recording: $e')),
      );
    }
  }

  Future<void> _sendVoiceMessage() async {
    if (_recordedFilePath == null) return;
    final message = _messageController.text.trim();

    debugPrint('===> _recordedFilePath: $_recordedFilePath');
    final provider = context.read<WalkieTalkieProvider>();
    int? sender_id;
    String? sender_type;

    // Get user data from storage
    final userData = sl<GetStorage>().read(kUser);
    if (userData != null) {
      final user = UserModel.fromJson(userData);
      sender_id = user.id;
      sender_type = user.typeAccount == 'company'
          ? 'App\\Models\\Company'
          : 'App\\Models\\Person';
    }

    // Send voice message
    await provider.sendWalkieTalkieMessage({
      'voice_group_id': '1',
      'channel_name': widget.channel,
      'sender_id': sender_id,
      'sender_type': sender_type,
      'receiver_id': widget.id,
      'receiver_type': (widget.type == null && widget.type.isEmpty )? widget.type :'Voice Group',
      'message': message.isNotEmpty?message:'Voice Message',
      'audio_path': _recordedFilePath!, // This will be uploaded by the API
    });
    context.read<WalkieTalkieProvider>().getChannelMessages(widget.channel);

    // Clear the recorded file path
    _recordedFilePath = null;
  }


  Future<void> _playVoiceMessage(String audioPath, String messageId) async {
    try {
      if (_currentlyPlayingMessageId == messageId) {
        // Stop current audio
        await _audioPlayer.stop();
        setState(() {
          _currentlyPlayingMessageId = null;
        });
        return;
      }

      // Stop any currently playing audio
      if (_currentlyPlayingMessageId != null) {
        await _audioPlayer.stop();
      }

      setState(() {
        _currentlyPlayingMessageId = messageId;
      });

      await _audioPlayer.play(UrlSource(audioPath));

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _currentlyPlayingMessageId = null;
        });
      });
    } catch (e) {
      print('Error playing audio: $e');
      setState(() {
        _currentlyPlayingMessageId = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing audio: $e')),
      );
    }
  }



  @override
  void dispose() {
    super.dispose();
    _messageTimer?.cancel();
    _recordingTimer?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _messageController.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel(); // Leave the channel
    await _engine.release(); // Release resources
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Walkie Talkie - ${widget.channel}',
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            // Messages List
            Expanded(
              child: _buildMessagesList(),
            ),

            // Recording Status
            if (_isRecording) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.red.withOpacity(0.1),
                child: Row(
                  children: [
                    const Icon(
                      Icons.mic,
                      color: Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Recording... ${_recordingDuration.inSeconds}s',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _stopRecording,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Stop'),
                    ),
                  ],
                ),
              ),
            ],

            // Input Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Text Field
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Mic Button
                  IconButton(
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                    icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          _isRecording ? Colors.red : kPrimaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Message Status
            Consumer<WalkieTalkieProvider>(
              builder: (context, provider, child) {
                if (provider.isLoadingMessage) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Sending message...'),
                      ],
                    ),
                  );
                }

                if (provider.errorMessageSend != null) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.red.withOpacity(0.1),
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            provider.errorMessageSend!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        IconButton(
                          onPressed: provider.clearMessageError,
                          icon: const Icon(Icons.close,
                              color: Colors.red, size: 16),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return Consumer<WalkieTalkieProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingChannelMessages) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.errorMessageChannelMessages != null) {
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
                  provider.errorMessageChannelMessages!,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    provider.getChannelMessages(widget.channel);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final messages = provider.channelMessagesWrapper?.data;
        if (messages == null || messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No messages in this channel',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<WalkieTalkieProvider>()
                .getChannelMessages(widget.channel);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return _buildMessageCard(message);
            },
          ),
        );
      },
    );
  }

  Widget _buildMessageCard(WalkieTalkieMessageData message) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: kPrimaryColor.withOpacity(0.1),
                  child: Icon(
                    _getSenderIcon(message.senderType),
                    color: kPrimaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getSenderName(message),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatDate(message.sentAt),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Message Content
            if (message.message != null && message.message!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message.message!,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Audio Path
            if (message.audioPath != null && message.audioPath!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.audiotrack,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Voice Message',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Tap to play',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _playVoiceMessage(
                          message.audioPath!, message.id.toString()),
                      icon: Icon(
                        _currentlyPlayingMessageId == message.id.toString()
                            ? Icons.stop
                            : Icons.play_arrow,
                        color: kPrimaryColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getSenderIcon(String? senderType) {
    switch (senderType) {
      case 'App\\Models\\Company':
        return Icons.business;
      case 'App\\Models\\Person':
        return Icons.person;
      default:
        return Icons.person_outline;
    }
  }

  String _getSenderName(WalkieTalkieMessageData message) {
    switch (message.senderType) {
      case 'App\\Models\\Company':
        return 'Company (ID: ${message.senderId})';
      case 'App\\Models\\Person':
        return 'Person (ID: ${message.senderId})';
      default:
        return 'Unknown (ID: ${message.senderId})';
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
