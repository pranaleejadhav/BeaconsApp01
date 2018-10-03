# BeaconsApp01

## iOS Mobile APP
Features:

a) The  application  consists  of  a  single  window  that  will enable  the  user  to  view  the discounted items around him/her while shopping in the store. 


b) When  the  user  is  in  the  store,  the  app  should  locate  the  closest  beacon  and present only the products for the region belonging to the closest beacon.

## API

API that enables fetching of discounted items in a specific region. All the items are stored in Database, we have Mongo DB Atlas 
for storing the items as it is a cloud database and easy to integrate when the API is deployed in AWS. we have used Amazon S3 to 
store items photos.

## Requirement ##
* [MongoDB](https://www.mongodb.com/) - Databas
* [Expressjs](http://expressjs.com/zh-tw/) - API Server
* [Nodejs](https://nodejs.org/en/) - Backend Framework
* [NPM](https://www.npmjs.com/) - Package Management
* xcode - iOS IDE

## Packages ##
>1. [Mongoose](http://mongoosejs.com/) - mongodb object modeling
>2. [body-parser](https://www.npmjs.com/package/body-parser) - http request body parser.

## API EndPoints

### 1. GetAllitems

* **/addData**

  ` post - add new items`
  
     Request:
     
     { 
     
        "discount": 10,  
        "name": "Pineapple",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/pineapple.png",
        "price": 1.18,
        "region": "produce"
    },
    
     Response:
     
     201 Created.

* **/getdata**

  ` get - get all Items`
  
     Response:  
     
     
     [ 
     
    { 
    
        "_id": "5bac5720c96bd80332ab011f",
        "discount": 10,
        "name": "Croissants",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/croissants.png",
        "price": 2.79,
        "region": "grocery",
        "__v": 0
    },
    { 
    
        "_id": "5bac5796c96bd80332ab0120",
        "discount": 20,
        "name": "Brach's Jelly Beans",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/jelly-beans.png",
        "price": 2.21,
        "region": "grocery",
        "__v": 0
    },
    {
    
        "_id": "5bac57d6c96bd80332ab0125",
        "discount": 15,
        "name": "Coca Cola",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/coca-cola.png",
        "price": 6.99,
        "region": "grocery",
        "__v": 0
    },
    {
    
        "_id": "5bac57e0c96bd80332ab0126",
        "discount": 10,
        "name": "Gatorade",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/gatorade.png",
        "price": 3.89,
        "region": "grocery",
        "__v": 0
    },
    { 
    
        "_id": "5bac57fcc96bd80332ab0129",
        "discount": 15,
        "name": "Cranberry Cocktail",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/cranberry-cocktail.png",
        "price": 1.89,
        "region": "grocery",
        "__v": 0
    },
    { 
    
        "_id": "5bac5828c96bd80332ab012a",
        "discount": 20,
        "name": "Milk",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/milk.jpg",
        "price": 10.5,
        "region": "grocery",
        "__v": 0
    },
    {
    
        "_id": "5bac583ec96bd80332ab012b",
        "discount": 15,
        "name": "HI-C Fruit Punch",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/hi-c-fruit-punch.png",
        "price": 4.67,
        "region": "grocery",
        "__v": 0
    },
    { 
    
        "_id": "5bac57a9c96bd80332ab0121",
        "discount": 20,
        "name": "Dial Soap",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/dial_soap.jpg",
        "price": 2.99,
        "region": "lifestyle",
        "__v": 0
    },
    {
    
        "_id": "5bac57c1c96bd80332ab0123",
        "discount": 15,
        "name": "Scotch Brite Sponges",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/scotch-brite-sponges.png",
        "price": 5.89,
        "region": "lifestyle",
        "__v": 0
    },
    {
    
        "_id": "5bac57e9c96bd80332ab0127",
        "discount": 10,
        "name": "Organix Conditioner",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/organix-conditioner.png",
        "price": 13.46,
        "region": "lifestyle",
        "__v": 0
    },
    {
    
        "_id": "5bac585bc96bd80332ab012e",
        "discount": 15,
        "name": "US Weekly",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/us-weekly.png",
        "price": 4.99,
        "region": "lifestyle",
        "__v": 0
    },
    {  
    
        "_id": "5bac56b8c96bd80332ab011e",
        "discount": 10,
        "name": "Pineapple",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/pineapple.png",
        "price": 1.18,
        "region": "produce",
        "__v": 0
    },
    { 
    
        "_id": "5bac57b7c96bd80332ab0122",
        "discount": 10,
        "name": "Oranges",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/oranges.png",
        "price": 0.89,
        "region": "produce",
        "__v": 0
    },
    {
    
        "_id": "5bac57ccc96bd80332ab0124",
        "discount": 15,
        "name": "Fresh Express Lettuce",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/lettuce.jpg",
        "price": 3.69,
        "region": "produce",
        "__v": 0
    },
    {
    
        "_id": "5bac57f2c96bd80332ab0128",
        "discount": 10,
        "name": "Spinach",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/spinach.png",
        "price": 1.23,
        "region": "produce",
        "__v": 0
    },
    
    {
    
        "_id": "5bac5849c96bd80332ab012c",
        "discount": 10,
        "name": "Nectarines",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/fresh-nectarines.png",
        "price": 3.67,
        "region": "produce",
        "__v": 0
    },
    {
    
        "_id": "5bac5852c96bd80332ab012d",
        "discount": 10,
        "name": "Fresh Seedless Whole Watermelon",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/watermellon.jpg",
        "price": 6.99,
        "region": "produce",
        "__v": 0
    },
    
] 

* **/getproductdata/{regionName}**

  ` get - get all Items in a specific region`
  
  ### All items in lifestyle region.
  
     Response:  
     
     [ 
     
    {  
    
        "_id": "5bac57a9c96bd80332ab0121",
        "discount": 20,
        "name": "Dial Soap",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/dial_soap.jpg",
        "price": 2.99,
        "region": "lifestyle",
        "__v": 0
    },
    {
    
        "_id": "5bac57c1c96bd80332ab0123",
        "discount": 15,
        "name": "Scotch Brite Sponges",
        "photo": "https://s3.us-east-2.amazonaws.com/admadphotos/scotch-brite-sponges.png",
        "price": 5.89,
        "region": "lifestyle",
        "__v": 0
    },

## APP




