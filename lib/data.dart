import 'blog.dart';

final uuid = UUID();
final createdBlogs = [
  Blog(
    uuid: uuid.generate(),
    title: "Figures figures figures!!!",
    createdDate: DateTime.now().subtract(const Duration(days: 4)),
    blogBody:
        "These figures suggest that mobile phones are relatively in high use by a large section of the human population. This boon of mobile devices has also come with a large variety of apps available for use each with varying degrees of security and privacy. ",
    imageURL: "https://i.pravatar.cc/300?img=65",
  ),
  Blog(
    uuid: uuid.generate(),
    title: "Malicious is fair fair fair!!!",
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
    blogBody:
        ". It is also fair to say that any person or group of persons with malicious intent can exploit these many vulnerabilities. It is therefore crucial to understand the risks associated with mobile apps as well as how they have been addressed so far and the strategies that can be further implemented.",
    imageURL: "https://i.pravatar.cc/300?img=49",
  ),
  Blog(
    uuid: uuid.generate(),
    title: "State of the mobile app!!!",
    createdDate: DateTime.now().subtract(const Duration(days: 30)),
    blogBody:
        "This report discusses the current state of mobile app security and outlines strategies that can be implemented within the mobile app development process, the mobile platforms on which these developed apps are run and lastly the app-store ecosystem. ",
    imageURL: "https://i.pravatar.cc/300?img=50",
  ),
];

final deletedBlogs = [
  Blog(
    uuid: uuid.generate(),
    title: "Lorem nada nada nada !!!",
    createdDate: DateTime.now().subtract(const Duration(days: 20)),
    blogBody: "it doesn't get better than this!!!!!",
    imageURL: "https://i.pravatar.cc/300?img=30",
  ),
  Blog(
    uuid: uuid.generate(),
    title: "Not good not good!",
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
    blogBody: "Lorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsum",
    imageURL: "https://i.pravatar.cc/300?img=16",
  ),

];