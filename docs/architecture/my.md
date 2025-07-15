### UsersController
- new: Sign Up
- create: Sign Up 
- show: Profile

### ListingsController
- index: Search
- show: Expanded Listing

### MyListingsController
- index: My Library
- new
- create
- edit: Manage your Listings
- update: Manage your Listings
- destroy: Manage your Listings

### MessagesController
- index: Messages
- create: Send a message (creating transaction is included here)
> Polymorphic `messageable` between TextMessage or Transaction 

### TransactionsController
- index: My Transactions
- create: Sending a Transaction (not needed because you can only create a transaction using a message)
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