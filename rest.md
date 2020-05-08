# REST API Design Guidelines

- REST APIs are resource oriented where each node is a simple resource or collection of resources of same type.

- Resources are named entities, and resource names are their identifiers. Each resource must have its own unique resource id.

- The key characteristic of a resource-oriented API is that it emphasizes resources (data model) over the methods performed on the resources (functionality). 

- A typical resource-oriented API exposes a large number of resources with a small number of methods. Standard methods are:
    
    Standard Method |     HTTPMapping        | RequestBody | Response Body 
    --------------- |     -----------        | ----------- | ------------- 
    List            |  GET <collection URL>  |  Empty      | Resource List
    Get             |  GET <resource URL>    |  Empty      | Resource
    Create          |  POST <collection URL> |  Resource   | Resource
    Update          |  PUT <resource URL>    |  Resource   | Resource
    Delete          |  DELETE <resource URL> |  Empty      | Empty

- General consensus is the paths should contain plural form of resources and the HTTP method should define the kind of action to be performed on the resource (e.g., ```PUT /companies/3/employees/john```)

- A batch get (such as a method that takes multiple resource IDs and returns an object for each of those IDs) should be implemented as a custom BatchGet method, rather than a List

- A collection is a special kind of resource that contains a list of sub-resources of identical type (e.g., a directory is a collection of file resources). The resource ID for a collection is called collection ID.

- The resource name is organized hierarchically using collection IDs and resource IDs, separated by forward slashes. If a resource contains a sub-resource, the sub-resource's name is formed by specifying the parent resource name followed by the sub-resource's ID - again, separated by forward slashes.

    Collection ID |	   Resource ID     | Resource ID | Resource ID
    ------------- |    -----------     | ----------- | -----------
    /users 	      |  /name@example.com | /settings   | /customFrom
    /shelves      |  /shelf1           | /books      | /book2
    
   By splitting the resource name, such as name.split("/")[n], one can obtain the individual collection IDs and resource IDs, assuming none of the segments contains any forward slash.
    
- Standard message field definitions that should be used when similar concepts are needed. This will ensure the same concept has the same name and semantics across different APIs.

    - name
    - parent
    - create_time
    - update_time
    - delete_time
    - filter (use with List)
    - query (use with Search - custom method)
    - page_token
    - page_size
    - total_size
    - next_page_token
    - order_by
        
- Errors should include at least  
    - Error Code
    - Error Messages
    - Error Details
  
- Design Patterns        
    - List Sub-Collections  

      ```GET https://library.googleapis.com/v1/shelves/-/books?filter=xxx```  (use - as wildcard instead of * to avoid need for URL escaping)
    - Get Unique Resource From Sub-Collection
        
        ```GET https://library.googleapis.com/v1/shelves/-/books/{id}```
        
- Other Considerations
    - Pretty print by default (favor it over ?pretty=true)
    - Always support gzip
    - Don't use an envelope by default, but make it possible when needed. e.g., use
    ```json
       {
          "id" : 123,
          "name" : "John"
       }
    ```
	
    instead of

    ```json
	   {
          "data" : {
             "id" : 123,
             "name" : "John"
          }
       }
    ```

## Reference
  - Google Cloud Platform: https://cloud.google.com/apis/design/
  - Microsoft API Guidelines: https://github.com/Microsoft/api-guidelines
  - RESTful API Best Practices: https://hackernoon.com/restful-api-designing-guidelines-the-best-practices-60e1d954e7c9
  - Best Practices for Designing a Pragmatic RESTful API: http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api
  - REST API - requesting multiple resources in a single get: https://stackoverflow.com/questions/9371195/rest-api-requesting-multiple-resources-in-a-single-get
