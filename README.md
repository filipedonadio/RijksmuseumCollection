# Rijksmuseum Collection &middot; <img src="https://img.shields.io/badge/iOS-12.0+-blue.svg" /> <img src="https://img.shields.io/badge/Swift-5.0-brightgreen.svg" /> <a href="https://twitter.com/filipedonadio"><img src="https://img.shields.io/badge/Contact-@filipedonadio-lightgrey.svg?style=flat" alt="Twitter: @filipedonadio" /></a>

As an art and history lover, I decided to make this iOS app about the Rijksmuseum in Amsterdam, the Dutch National Museum. The idea of the app is to show the collection of the Rijks museum provided by their open [API](https://www.rijksmuseum.nl/en/data).

# Configuration

To run this project you first need to obtain an API key by registering for a [Rijksstudio account](https://www.rijksmuseum.nl/en/rijksstudio).

After getting a key, create a copy of `Default.sample.xcconfig` file, name it `Default.xcconfig` and replace `<API_KEY>` with your key:

```shell
// Default.xcconfig
API_KEY = Insert here your API key
```

Make sure to select `Default` as Configuration File in Project Info tab in the Editor view