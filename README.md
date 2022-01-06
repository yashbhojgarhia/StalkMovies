# StalkMovies

**Steps to run the application:-**
Unzip the folder, open the project in Xcode via MoviesApp.xcworkspace this file. 
Build and run the application in Xcode by choosing a supported simulator.

**Features & Specifications:-**
Application starts with a launch screen which animates itself landing you on the first screen of TabViewController which is Home.

**App has 3 Tabs:-**
Common Behaviour in all Tabs:-
1. Movies are displayed as table cell rows.
2. Each cell is clickable which lands you on MovieDetails ViewController
3. MovieDetailsViewController list movie details, with an option to share and save the movie.

**1. Home Tab:-**
1. This displays Trending Movies as well as Now Playing Movies.
2. Trending Movies is displayed inside a collectionview which itself is wrapped inside a table view.
3. Tableview has 2 section, Trending movies CollectionView (Horizontally scrolled) followed by Now Playing Movies.
4. Now Playing Movies list supports pagination.
5. Trending movies doesn’t support pagination since API has no support for the same.

**2. Search Tab:-**
1. CustomTextField to search your query is present at the top
2. After 1 second that the user stops typing in the bar the API gets hit(this can be modified very easily in storyboard or code itself)
3. Fetched results are shown as table cells
4. Pagination is supported for fetched results

**3. Saved Tab:-**
1. Movies which are bookmarked/saved by the user is displayed here in table cells.
2. Saved movies are fetched from CoreData.
3. A notification is observed on the controller to update the fetched result upon user action.

**Deeplink:-**
On movies detail page there is a share button, which upon click gives a url
Copy that url and paste the same on Safari to test the feature
Alternatively you can type the url by giving different movie id by yourself on safari
This will land the user on MovieDetails page where he will see the details of the following movie It also has a cross button which redirects user back to home tab


Architecture followed - MVVM, Protocol oriented, Networking is modular 
App works in offline mode by fetching the results from CoreData if present.


**Future Scope:-**
1. Error Handling and no results view can be taken care of.
2. Pull to refresh option can be provided in home tab.
3. Shimmers while the API is loading
4. Movie Details screen should have been inside a scrollview
5. CoreData code can be more modular
6. App Delegate shared instance should be used from main thread
