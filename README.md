# Github API
Automated tests are available by running `$ rspec` on the project root folder.

The API has 7 endpoints oriented by Github events. Those endpoints are supported by entities: Event, Actor, and Repository.

* 1: DELETE `{base_url}/erase` will delete all events from database.
* 2: POST `{base_url}/events` will create an event in database along with its relations. If Actor and/or Repo does not exist it will be created before inserting events.
```json
{ 
   "id":1299472637,
   "type":"PushEvent",
   "actor":{ 
      "id":4189746,
      "login":"lisa67",
      "avatar_url":"https://avatars.com/4189746"
   },
   "repo":{ 
      "id":144489,
      "name":"lisa67/aliquam-est-quaerat",
      "url":"https://github.com/lisa67/aliquam-est-quaerat"
   },
   "created_at":"2013-04-07 15:13:31"
}
```
* 3: GET `{base_url}/events` will return all events from database in following format:
```json
[ 
   { 
      "id":1000026630,
      "type":"PushEvent",
      "actor":{ 
         "id":1578058,
         "login":"yshaw",
         "avatar_url":"https://avatars.com/1578058"
      },
      "repo":{ 
         "id":444748,
         "name":"yshaw/voluptas-magni",
         "url":"https://github.com/yshaw/voluptas-magni"
      },
      "created_at":"2013-01-01 01:13:31"
   },
   { 
      "id":1013380559,
      "type":"PushEvent",
      "actor":{ 
         "id":1354354,
         "login":"johnsonpaul",
         "avatar_url":"https://avatars.com/1354354"
      },
      "repo":{ 
         "id":279295,
         "name":"julianmoses/placeat-explicabo",
         "url":"https://github.com/julianmoses/placeat-explicabo"
      },
      "created_at":"2013-01-05 03:13:31"
   }
]
```
* 4: GET `{base_url}/actors` will return all Actors sort by its amount of Events, last event date DESC and login ASC.
```json
[ 
   { 
      "id":4785310,
      "login":"sherigutierrez",
      "avatar_url":"https://avatars.com/4785310"
   },
   { 
      "id":1085223,
      "login":"lawrenceharrington",
      "avatar_url":"https://gavatar.com/1085223"
   },
   { 
      "id":2268401,
      "login":"danielcharles",
      "avatar_url":"https://gavatar.com/2268401"
   },
   { 
      "id":2907782,
      "login":"eric66",
      "avatar_url":"https://gavatar.com/2907782"
   }
]
```
* 5: GET `{base_url}/actors/4189746`  will return all events from an actor.
```json
[ 
   { 
      "id":1299472637,
      "type":"PushEvent",
      "actor":{ 
         "id":4189746,
         "login":"lisa67",
         "avatar_url":"https://avatars.com/4189746"
      },
      "repo":{ 
         "id":144489,
         "name":"lisa67/aliquam-est-quaerat",
         "url":"https://github.com/lisa67/aliquam-est-quaerat"
      },
      "created_at":"2013-04-07 15:13:31"
   },
   { 
      "id":1299899515,
      "type":"PushEvent",
      "actor":{ 
         "id":4189746,
         "login":"lisa67",
         "avatar_url":"https://avatars.com/4189746"
      },
      "repo":{ 
         "id":170826,
         "name":"lisa67/occaecati",
         "url":"https://github.com/lisa67/occaecati"
      },
      "created_at":"2013-04-08 00:13:31"
   }
]
```
* 6: PUT `{base_url}/actors`  will update Actor `login` and/or `avatar_url` by id sent in request body.
```json
{ 
   "id":4189746,
   "login":"lisa67",
   "avatar_url":"https://gavatar.com/4189746"
}
```
* 7: GET `{base_url}/actors/streak`  will return Actors sort by streak (How many unbroken sequences of events Actor has daily based. `Gaps and Islands` challenge), last event date DESC and login ASC.
```json
[ 
   { 
      "id":4785310,
      "login":"sherigutierrez",
      "avatar_url":"https://avatars.com/4785310"
   },
   { 
      "id":4204682,
      "login":"jacquelinelewis",
      "avatar_url":"https://avatars.com/4204682"
   },
   { 
      "id":3827632,
      "login":"chenjennifer",
      "avatar_url":"https://avatars.com/3827632"
   },
   { 
      "id":2268401,
      "login":"danielcharles",
      "avatar_url":"https://gavatar.com/2268401"
   },
   { 
      "id":4520405,
      "login":"michael35",
      "avatar_url":"https://avatars.com/4520405"
   }
]
```
