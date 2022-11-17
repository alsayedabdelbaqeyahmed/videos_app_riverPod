class ApiConstants {
  static const baseApi = 'https://youtube.googleapis.com';
  static const apiKey = 'AIzaSyBb_lPoazVvrLHwgxz1CUGP0zBOPl6mWm0';
  static const channelApi =
      '$baseApi/youtube/v3/channels?part=statistics&part=snippet&id=UCSNkfKl4cU-55Nm-ovsvOHQ&key=$apiKey';
  static const searchApi =
      '$baseApi/youtube/v3/search?part=snippet&channelId=UCSNkfKl4cU-55Nm-ovsvOHQ&order=date&pageToken=a&type=video&key=$apiKey';
  static const videoApi =
      '$baseApi/youtube/v3/videos?part=snippet&id=UCSNkfKl4cU-55Nm-ovsvOHQ&key=$apiKey';
}
