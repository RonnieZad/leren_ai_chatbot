//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

/// Model classes to map and transform messages

class ReplyArray {
  final List<Reply> replies;

  ReplyArray({
    required this.replies,
  });

  factory ReplyArray.fromJson(List<dynamic> parsedJson) {
    List<Reply> photos = <Reply>[];
    photos = parsedJson.map((i) => Reply.fromJson(i)).toList();

    return ReplyArray(replies: photos);
  }
}

/// Model classes to map and transform messages
class Reply {
  final String recipientId;
  final String text;

  Reply({required this.recipientId, required this.text});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(recipientId: json['recipient_id'], text: json['text']);
  }
}