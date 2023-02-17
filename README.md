# Water jug challenge

This API generates a JSON containing the steps to solve the Water jug challenge in the shortest amount of steps.

### Prerequisites:
* Ruby 3.1.2
* Ruby on Rails 7.0.4.2

### Installation
1. Clone this repository.
  ```sh
  git clone git@github.com:Neroslike/water-jug-challenge.git
  ```
2. Navigate to the project's folder.
  ```sh
  cd water-jug-challenge
  ```
3. Start the rails server locally.
  ```sh
  rails s
  ```
4. Check the console to see in which port the rails server is listening, e.g  Listening on http://127.0.0.1:3000
5. Make an API call to http://127.0.0.1:3000/result with the x, y and z parameters (x = bucket_x, y = bucket_y, z = desired_result)
  ```sh
  curl http://127.0.0.1:3000/result/2/10/4
  ```
6. This will generate a JSON response:
```json
{"result":{"step1":{"bucket_x":2,"bucket_y":0,"explanation":"Fill bucket x"},"step2":{"bucket_x":0,"bucket_y":2,"explanation":"Transfer from bucket x to bucket y"},"step3":{"bucket_x":2,"bucket_y":2,"explanation":"Fill bucket x"},"step4":{"bucket_x":0,"bucket_y":4,"explanation":"Transfer from bucket x to bucket y"}}}
```

The json response has the following keys:
* result: The hash containing the steps number as keys (e.g 'step1') and a hash as the value with the following keys:
  * bucket_x: The current amount of water in bucket_x
  * bucket_y: The current amount of water in bucket_y
  * explanation: A brief explanation of what action was performed in that step.
