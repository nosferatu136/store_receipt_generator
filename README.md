# Store Receipt Generator
Basic application for generating for generating receipts for a group of grosery store baskets
- Input method: Json file `basket.json`
  - Receives an array of baskets in json format
  - Each basket is an array of json objects with 'quantity', 'description' and 'price' keys.
    ```
    "[[{\"quantity\":2,\"description\":\"book at\",\"price\":12.49},{\"quantity\":1,\"description\":\"music CD at\",\"price\":14.99},{\"quantity\":1,\"description\":\"chocolate bar at\",\"price\":0.85}],[{\"quantity\":1,\"description\":\"imported box of chocolates at\",\"price\":10.0},{\"quantity\":1,\"description\":\"imported bottle of perfume at\",\"price\":47.5}],[{\"quantity\":1,\"description\":\"imported bottle of perfume at\",\"price\":27.99},{\"quantity\":1,\"description\":\"bottle of perfume at\",\"price\":18.99},{\"quantity\":1,\"description\":\"packet of headache pills at\",\"price\":9.75},{\"quantity\":3,\"description\":\"imported boxes of chocolates at\",\"price\":11.25}]]"
    ```
- Output method: TExt file `receipts.txt`
  - Contains receipt data as described.
    ```
    Output 1:
    2 book: 24.98
    1 music CD: 16.49
    1 chocolate bar: 0.85
    Sales Taxes: 1.50
    Total: 42.32


    Output 2:
    1 imported box of chocolates: 10.50
    1 imported bottle of perfume: 54.65
    Sales Taxes: 7.65
    Total: 65.15


    Output 3:
    1 imported bottle of perfume: 32.19
    1 bottle of perfume: 20.89
    1 packet of headache pills: 9.75
    3 imported box of chocolates: 35.55
    Sales Taxes: 7.90
    Total: 98.38
    ```
    
 - Application exection:
   - `ruby generator.rb`
   
 - Test exectution:
   - `bin/rspec spec  --format doc`
