### UsersController
- new: Sign Up
- create: Sign Up 
- show: Profile

### ListingsController
- index: Search
- new: Add Listing
- create: Add Listing
- show: Expanded Listing
- edit: Manage your Listings
- update: Manage your Listings
- destroy: Manage your Listings
- my_listings: My Library

### MessagesController
- index: Messages
- create: Send a message
> Polymorphic `messageable` between TextMessage or Transaction 

### TransactionsController
- index: My Transactions
- create: Sending a Transaction
- update: When clicked etc.
- show: View Transaction details expanded 

### SavedItemsController
- index: My Library
- create: Saving a listing
- destroy: Unsaving a listing

### SubscriptionsController
- create: Subscribe to a search query
- index: View active subscriptions
- destroy: Unsubscribe
  
### SessionsController
- new: Login
- create: Login
- destroy: Login