# NotionSwift

Unofficial [Notion](https://www.notion.so) SDK for iOS & macOS. 

This is an alpha version and still a work in progress.

## Supported Endpoints

### Databases
 * Retrieve a database ✅
 * Query a database ✅
 * List databases ✅
 
### Pages
* Retrieve a page ✅
* Create a page
* Update page properties

### Blocks 
* Retrieve block children ✅
* Append block children ✅

### Users
* Retrieve a user ✅
* List all users ✅

### Search 
* Search 


## Installation

This project is a work in progress so no release versions available yet.

### CocoaPods

```ruby
pod 'NotionSwift', :git => 'https://github.com/chojnac/NotionSwift.git', :branch => 'main'
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/chojnac/NotionSwift.git", .branch("main"))
]
```

## Usage

Currently, this library supports only the "internal integration" authorization mode. For more information about authorization and 
instruction how to obtain `NOTION_TOKEN` please check [Notion Offical Documentation](https://developers.notion.com/docs/authorization).

```swift

let notion = NotionClient(accessKeyProvider: StringAccessKeyProvider(accessKey: "{NOTION_TOKEN}"))

// fetch avaiable databases
notion.databaseList {
    print($0)
}

let pageId = Block.Identifier("{PAGE UUIDv4}")

// retrieve page content
// this endpoint returns only the first level of children, 
// so for example nested list items won't be returned. For that, 
// you need to make another request with block id
notion.blockChildren(blockId: pageId, params: .init()) {
    print($0)
}

// append paragraph with styled text to a page.
let blocks: [WriteBlock] = [
    .init(type: .paragraph(.init(text: [
        .init(string: "Lorem ipsum dolor sit amet, "),
        .init(string: "consectetur", annotations: .bold),
        .init(string: " adipiscing elit.")
    ])))
]

notion.blockAppend(blockId: pageId, children: blocks) {
    print($0)
}
```

**Important**
Integrations are granted access to resources (pages and databases) which users have shared with the integration. Once an integration has been added to a workspace by an Admin, users see the integration within `Share` menus inside Notion.

## License

**NotionSwift** is available under the MIT license. See the [LICENSE](https://github.com/chojnac/NotionSwift/blob/master/LICENSE) file for more info.
