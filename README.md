# ElixirPractice

Small scale programs to learn Elixir

## Cryptobot
Allybot folder contains Cryptobot, a Discord bot that is able to fetch current crypto prices, notify on crypto prices changes, and convert from crypto to USD. 
ADDITIONAL FEATURE: Also does Kanye West quotes. 

### COMMANDS:

 ```!kanye```
 
 Returns random Kanye West quote, using https://kanye.rest/ API.



 ```!currency "ticker"```
 
 Returns currency information, using https://messari.io/api API.
 > Example: !currency btc



```!alert "price,ticker"```

Creates notification for when currency reaches price. **Currently only works for when coin reaches higher price**

Price and ticker should seperated by comma, without any spaces in between. 
> Example: !alert 49700.5,btc


```!convert "amount,ticker"```
Returns price of the amount of currency inputted.
Price and ticker should seperated by comma, without any spaces in between. 
> Example: !convert 7,btc

