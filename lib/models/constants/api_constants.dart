class ApiConstants {
  static const baseApi = 'https://youtube.googleapis.com';
  static const apiKey = 'AIzaSyBWX2uhdqnFHbhBN0H12-b_JY3szkLbKdo';
}

/// search :
///https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCytEtngcIINSMbdc22SrbrQ&maxResults=100&pageToken=a&q=html&key=AIzaSyBWX2uhdqnFHbhBN0H12-b_JY3szkLbKdo&order=date
/// search
/// paheToken:string value by user
/// part
/// q : string value by user 
/// channel id if i nead to search at define channel
/// apikey
/// type
/// order ترتيب الفييدهراتعلي حسب التاريخ
/// channel:
/// https://youtube.googleapis.com/youtube/v3/channels?part=statistics&part=snippet&id=UCSNkfKl4cU-55Nm-ovsvOHQ&maxResults=100&key=AIzaSyBWX2uhdqnFHbhBN0H12-b_JY3szkLbKdo
/// part
/// channel id
/// api key
/// max result
/// video:
/// https://youtube.googleapis.com/youtube/v3/videos?part=snippet&id=zA7uJUkGYec&key=AIzaSyBWX2uhdqnFHbhBN0H12-b_JY3szkLbKdo
/// part
/// video id
/// api key
/// random videos
/// https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=1000&key=AIzaSyBWX2uhdqnFHbhBN0H12-b_JY3szkLbKdo