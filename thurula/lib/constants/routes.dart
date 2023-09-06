const API = "http://10.0.2.2:5154/api/";
const FORUM = "http://10.0.2.2:5154/forum/";
String getRoute(String route) {
  return API + route;
}
String getForumRoute(String route) {
  return FORUM + route;
}