# Shipt Backend Coding Challenge

A basic REST API application using Ruby on Rails where a customer can have an order that is made up of products.

1. A product belongs to many categories. A category has many products. A product can be sold in decimal amounts (such as weights).
2. A customer can have many orders. An order is comprised of many products. An order has a status stating if the order is 'ready', 'on its way' or 'delivered'.

## Instructions to Run the Application:
1. Bundle install gems `bundle install`
2. Create database and add seed data.
  - `rails db:create && rails db:seed`
3. Run any of the requests below to test the functionality

## Tasks
1. An API endpoint that accepts a date range and a day, week or month and returns a breakdown of products sold by quantity per day/week/month.

  ###`Sales by date range`
  - EndPoint: `/api/v1/products/sales_by_date_range`
  - Params:
    - start_date -> `start_date`
    - end_date -> `end_date`
    - interval -> `interval`
  - Example: `GET /api/v1/products/sales_by_date_range?start_date=2021-02-18&stop_date=2021-04-22&interval=week`
    - Response
    ```
      {
        "sales_by_week": {
            "2021-03-08": [
                {
                    "id": 1,
                    "name": "Mario Kart DS",
                    "quantity_sold": "11.15"
                },
                {
                    "id": 2,
                    "name": "Wii Music",
                    "quantity_sold": "4.3"
                },
                {
                    "id": 4,
                    "name": "Cabbages and Kings",
                    "quantity_sold": "3.05"
                },
                {
                    "id": 5,
                    "name": "Alone on a Wide, Wide Sea",
                    "quantity_sold": "8.38"
                },
                {
                    "id": 7,
                    "name": "Unforgiven",
                    "quantity_sold": "8.99"
                },
                {
                    "id": 8,
                    "name": "2001: A Space Odyssey",
                    "quantity_sold": "6.35"
                },
                {
                    "id": 9,
                    "name": "Apocalypse Now",
                    "quantity_sold": "9.79"
                }
            ],
            "2021-03-15": [
                {
                    "id": 2,
                    "name": "Wii Music",
                    "quantity_sold": "8.68"
                },
                {
                    "id": 3,
                    "name": "Left 4 Dead",
                    "quantity_sold": "13.90"
                },
                {
                    "id": 4,
                    "name": "Cabbages and Kings",
                    "quantity_sold": "4.05"
                },
                {
                    "id": 5,
                    "name": "Alone on a Wide, Wide Sea",
                    "quantity_sold": "6.92"
                },
                {
                    "id": 6,
                    "name": "Ring of Bright Water",
                    "quantity_sold": "4.65"
                },
                {
                    "id": 7,
                    "name": "Unforgiven",
                    "quantity_sold": "2.09"
                },
                {
                    "id": 8,
                    "name": "2001: A Space Odyssey",
                    "quantity_sold": "2.42"
                },
                {
                    "id": 9,
                    "name": "Apocalypse Now",
                    "quantity_sold": "5.65"
                }
            ]
         }
      }
    ```
    - Exceptions:
      - if `start_date` or `end_date` is not given in query.
        - Response: `{ message: 'one or more parameters missing' }`
      - if `range` is not given in query.
        - it is set as `day` by default


2. An API endpoint that returns all orders for a customer sorted by date.

  ###`Orders for a customer`
  - EndPoint: `/api/v1/customers/:id/orders`
  - Params:
    - customer id ->`id`
  - Example: `GET /api/v1/customers/5/orders`
    - Response
      ```
        {
          "customer": {
              "first_name": "Millicent",
              "last_name": "Gorczany"
          },
          "orders": [
              {
                  "id": 6,
                  "status": "ready",
                  "date_ordered": "2021-04-21 05:16:30.125996",
                  "products": [
                      {
                          "id": 2,
                          "name": "Wii Music",
                          "quantity": "10.2"
                      },
                      {
                          "id": 3,
                          "name": "Left 4 Dead",
                          "quantity": "30.4"
                      }
                  ]
              },
              {
                  "id": 5,
                  "status": "ready",
                  "date_ordered": "2021-04-21 04:02:06.537345",
                  "products": [
                      {
                          "id": 3,
                          "name": "Left 4 Dead",
                          "quantity": "30.4"
                      }
                  ]
              },
              {
                  "id": 2,
                  "status": "ready",
                  "date_ordered": "2021-04-20 04:50:38.675741",
                  "products": [
                      {
                          "id": 1,
                          "name": "Mario Kart DS",
                          "quantity": "3.78"
                      },
                      {
                          "id": 3,
                          "name": "Left 4 Dead",
                          "quantity": "5.43"
                      },
                      {
                          "id": 4,
                          "name": "Cabbages and Kings",
                          "quantity": "4.05"
                      },
                      {
                          "id": 5,
                          "name": "Alone on a Wide, Wide Sea",
                          "quantity": "5.81"
                      },
                      {
                          "id": 7,
                          "name": "Unforgiven",
                          "quantity": "3.07"
                      },
                      {
                          "id": 8,
                          "name": "2001: A Space Odyssey",
                          "quantity": "2.42"
                      },
                      {
                          "id": 9,
                          "name": "Apocalypse Now",
                          "quantity": "5.65"
                      }
                  ]
              }
          ]
        }
      ```
      - Exceptions:
        - if customer `id` does not exist.
          - Response: `{ message: 'No Customer Found' }`


3. An API endpoint to create an Order for a Customer where input products can be specified by Product IDs.

  ###`Create Order for a Customer`
  - EndPoint: `/api/v1/customers/:id/orders/new`
  - Params:
    - customer_id -> `id`
    - Request Body Structure:
      - Fields:
        - customer_id: ID of the customer for which order has to created.
        - products: List of products with `product_id` and `quantity`
        ```
          {
            "customer_id": :customer_id,
            "products": [
              {
                "id": :product_id,
                "quantity": :quantity
              }
            ]
          }
        ```
  - Example:
    ```
     POST /api/v1/customers/1/orders/new

      {
        "customer_id": 1,
        "products": [
          {
            "id": 6,
            "quantity": 17.2
          },
          {
            "id": 5,
            "quantity": 19.4
          }
        ]
      }
    ```
    - Response: `{ "message": "Order Created" }`
    - Exceptions:
      - If any `customer_id` is missing or not same as the `id` in query.
        - Response: `{ "message": "'id' in url and 'customer_id' in request body must be same." }`
      - If any required fields from `products` are missing.
        - Response: `{ "message": "One or more fields missing in request body" }`

- Default error for undefined url:
  - Response: `{ message: "request url not found" }`

### Improvements I'd make:
 - Reduce the no. of queries made to get products in an order along with customer orders information.
 - Combine the POST queries for order and products into one single query.

### Assumptions:
 - Assuming that each product is added in quantity to order which is a decimal and since the exercise does not request anything related to price, I did not add price field to the product.
 - It was not mentioned in the exercise but I thought it'd be good to have the list of products also return on customer orders GET.
 - Products by date range by default has range as `day`.
