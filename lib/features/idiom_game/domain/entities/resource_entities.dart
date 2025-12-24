enum ResourceType { voskModel, idiomDb }

enum DownloadStatus {
  idle,
  checking,
  downloading,
  extracting,
  importing,
  completed,
  error,
}

class ResourceInfo {
  final String name;
  final String version;
  final String url;
  final int sizeBytes;
  final String md5;

  const ResourceInfo({
    required this.name,
    required this.version,
    required this.url,
    required this.sizeBytes,
    required this.md5,
  });
}

class DownloadProgress {
  final ResourceType type;
  final DownloadStatus status;
  final double progress; // 0.0 to 1.0
  final String? message;
  final String? error;

  const DownloadProgress({
    required this.type,
    required this.status,
    this.progress = 0.0,
    this.message,
    this.error,
  });

  factory DownloadProgress.idle(ResourceType type) => 
      DownloadProgress(type: type, status: DownloadStatus.idle);
      
  factory DownloadProgress.downloading(ResourceType type, double progress) => 
      DownloadProgress(type: type, status: DownloadStatus.downloading, progress: progress);
      
  factory DownloadProgress.completed(ResourceType type) => 
      DownloadProgress(type: type, status: DownloadStatus.completed, progress: 1.0);
      
  factory DownloadProgress.error(ResourceType type, String error) => 
      DownloadProgress(type: type, status: DownloadStatus.error, error: error);
}
