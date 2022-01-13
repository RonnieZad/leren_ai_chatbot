//  LEREN DIGITAL HUMAN
//
//  Created by Ronald Zad Muhanguzi.
//  2021, All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

///Modal class to convert user message to json
class Sent {
  final String sender, message;

  Sent(this.sender, this.message);

  Map<String, dynamic> toJson() => {"sender": sender, "message": message};
}
