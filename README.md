# VO2_VIDEO_ASSIGNMENT_THEJUS

Welcome to VO2Video app, a basic app which displays a collection of Popular movies. It lets the user see details of the movie and add the movie to favourites. The application uses UICollectionViewCompositionalLayout to display the list of movies. The main idea when developing the application was to give equal importance to UI and architecure, and keep the app as modular as possible.

## Pre-requirements

1. Minimun deployment target iOS 16
2. Api key from TMDB

## Libraries used
Few external libraries are used inorder to save some time.

### Swift package manger
1. SDWebImage -> https://github.com/SDWebImage/SDWebImage -> Only used for managing cached images, as the  image urls are loaded from network.
2. Rswift -> https://github.com/mac-cain13/R.swift -> User for autogeneration of strings, assets, fonts, storyboard identifiers etc.



## Architecure

1. VO2Video uses MVVM + coordinator architecure where all data is handled at Model level, View models respective to each view user the model and implements all business logic, and Controllers as Views.
2. All routings and flows are handled by respective Coordinators.
3. Uses pagination wherever needed.


## Known Issues to improve in V2

1. Maybe to introduce a cache for the network calls if any.
2. Better UI with some good assests and images.
3. Implement more Unit Tests.


## Usage

###  MoviesService -> Protocol for service calls (MoviesNetworkService and MoviesMockedService implements this)

    ```func getPopularMovies(pageNo: Int, completion: @escaping ResultCallback<VO2Data<Movie>>)```
    Makes an async call to fetch all popular movies with pagination support, can throw erros of type VO2Error.
    
    ```func getDetailsOf(movieId: Int, completion: @escaping ResultCallback<MovieDetails>)```
    Makes an async call to fetch further details of a movie with id as parameter.
    
    ```updateFavouriteState(movieId: Int, isFavourite: Bool)```
    Updates isFavourite state for a movie and using observers publishes this information.
    
    
## Protocols
    
### Spawnable
    Helps in easy instantiating View controllers from storyboard using `storyboardName` and `storyboardIdentifier`
   
    
## Coordinators

### AppCoordinator
    Handles all routing/navigations at AppDelegate level
### HomeCoordinator
    Handles all routing/navigations and flow at Home tab


## Tests


### Unit Tests & integration tests
Performs certain number of tests. More tests needs to be implemented.

