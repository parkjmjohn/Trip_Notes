# TripNotes
An app to plan your trips by getting updated information on your desired locations. Search up a city of your desires, and get the current time, a 24-hour forecast, and an image of your location. Setup your priority on how badly you want to plan a trip to this location, and even write up some notes on this place. Save your desired city into a table of your other saved cities.



### Features
- Programmatic Layout: This app was developed through a programmatic approach

- Multiscreen Application: There are four views: ViewController (displays a TableView of your saved cities), SearchViewController (used to search up cities), CityViewController (uses networking to display information on that city), and SaveViewController (allows users to re-edit their saved cities).

- API Integration: There are three APIs used in this app. GooglePlaces API is used to help autosuggest cities to users. apixi API is used to show a 24-hour forecast and the time of the location. The unsplash API is used to display an image that was taken in the city.

- CollectionView & TableView: UITableView was used to display the cities in both ViewController and SearchViewController. CollectionView was used to show a 24-hour forecast of the city in CityViewController.

- Complex Components: 
   - Auto-suggestions: The app suggests the city to users when they are typing in any characters into the Searchbar
   - UIPickerView: A PickerView was used to have the users to choose their priorirty on their desires to visit the location. This priorirty is then saved when the user presses the save button. 
   - API: Two separate calls to APIs were called in CityViewController to show information on the city.
   - CollectionView: The CollectionView displays information horizontally but hides the scroll bar
   - TableView: Saved cities can be erased by swiping to the left in the TableView
   - Notes: Users can type in notes about the city, and save all of the informaiton about the city having it displayed in a TableView of saved cities.




#### DEBUG: 
- SearchBar displays places that are not cities
- CollectionView does not display all of the images at once



##### Useful Tools
- http://iosfonts.com/
- https://briangrinstead.com/blog/ios-uicolor-picker/

###### Credits
- App Icon: https://icons8.com/
- App Icon Generator: https://makeappicon.com/

