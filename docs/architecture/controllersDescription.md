### **UsersController**

| Action   | Purpose                   |
| -------- | ------------------------- |
| `new`    | Sign up form              |
| `create` | Create user account       |
| `show`   | View profile              |
| `edit`   | Edit profile (bio, image) |
| `update` | Update profile            |

### **ListingsController**

| Action  | Purpose                         |
| ------- | ------------------------------- |
| `index` | Search/list all public listings |
| `show`  | View a specific listing detail  |


### **MyListingsController**

| Action    | Purpose                         |
| --------- | ------------------------------- |
| `index`   | View all listings owned by user |
| `new`     | Form to create a listing        |
| `create`  | Save a new listing              |
| `edit`    | Edit one of your listings       |
| `update`  | Save changes to your listing    |
| `destroy` | Delete a listing                |


### **MessagesController**

| Action   | Purpose                                               |
| -------- | ----------------------------------------------------- |
| `index`  | Show all message threads/conversations                |
| `show`   | View a conversation thread         |
| `create` | Send a message (text or transaction) |

> Message content (`messageable`) can be:
>
> * `TextMessage`
> * `Transaction`

### **TransactionsController**

| Action   | Purpose                                            |
| -------- | -------------------------------------------------- |
| `index`  | View all of user’s transactions                    |
| `show`   | View detailed transaction info                     |
| `update` | Update transaction (e.g., mark started, completed) |


### **SavedItemsController**

| Action    | Purpose                 |
| --------- | ----------------------- |
| `index`   | View all saved listings |
| `create`  | Save a listing          |
| `destroy` | Unsave a listing        |

### **SubscriptionsController**


| Action    | Purpose                          |
| --------- | -------------------------------- |
| `index`   | View user’s active subscriptions |
| `create`  | Subscribe to a query string      |
| `destroy` | Unsubscribe from a query         |

### **SessionsController**

| Action    | Purpose       |
| --------- | ------------- |
| `new`     | Login form    |
| `create`  | Perform login |
| `destroy` | Logout        |