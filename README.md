# FastNews

This repository contains the iOS test source code.

## Same project in SwiftUI GoTo: https://github.com/rafaeladolfo/FastNewsSwiftUI

### Stack
* Using UIKit 
* Pods

### Features
* Integration with reddit api
* News viewing
* Comments listing
* Url Sharing

### Git strategy
* Using gitflow to organize code commits
* Check the flow in network: https://github.com/rafaeladolfo/fastnews/network

* Feature branches:
![FeatureBranch](https://wac-cdn.atlassian.com/dam/jcr:b5259cce-6245-49f2-b89b-9871f9ee3fa4/03%20(2).svg?cdnVersion=1224)

* Release branches:
![ReleaseBranch](https://wac-cdn.atlassian.com/dam/jcr:a9cea7b7-23c3-41a7-a4e0-affa053d9ea7/04%20(1).svg?cdnVersion=1224)

* Result:  
![NetworkGraph](ng.png)

### Using CICD with github actions
* yml file: https://github.com/rafaeladolfo/fastnews/blob/master/.github/workflows/swift.yml
* result:  

![NetworkGraph](cicd.png)
