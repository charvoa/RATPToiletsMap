# RATPToiletsMap

### Features

- A paginated list of all available public toilets in Paris (displaying PMR access, opening hours and adress, distance if location has been auhtorized by user)
-- That list can be filtered with two variables : PMR Access / Open 
- Map of all available public toilets in Paris (color coded according to their opening times Green (open) / Red (closed) / Blue (unknown))
- Detail view of each public toilets, displaying a map centered on its position, while also making it clear if the toilet is currently open, if it has PMR access and baby relay. 

### Architecture choices 

I chose a simple MVVM approch for this project. In my opinion this is the simplest, and quickest way to achieve a project of that size, without being too complex, but still clear and evolutive. 
The main part of the app is a list, I chose to use a TableView for its simplicity and performances. Combined with the new UITableViewDiffableDataSource to have a better control on how and what updates should happen, and to add even more readability to the code. The `delegate` pattern has been used quite extensively in the architecture, this is the simplest and quickest way to achieve "reactivity", while being easily maintenable by other developers without considering their seniority, other choices could have been made oviously (e.g. Combine, RxSwift).

While the main UI is done in UIKit + Storyboards, the detail view has been made in SwiftUI. This was done  to show both how UIKit and SwiftUI can work together, and obviously show off my skills. 

### What could be improved 

- Offline access could be made possible easily with `CoreData` or `Realm`.
- I chose to keep simplicity for accessing data, that's  why ViewModels have direct access to the network manager. Adding a layer above the network manager (e.g. ToiletteManager) could simplify handling offline access. 
- Design has not been my main focus, while making sure every data was easily readable by anyone, it could be improved.
- Filters are only filtering local data for now, so this could be discussed. Do we want that behavior or do we want to make a new request every time a filtering is being done ? 