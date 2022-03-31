# To-Do App - Dart / Flutter

## Project Description

### Tr
Projede http kullanılarak, https://collectapi.com sitesindeki Hava Durumu API'sinden veri çekilmiştir. 5 günlük hava durumu verisi Tabbar kullanılarak ekrana çizilmiştir. Ayarlar sayfasından şehir ve veri dili ayarı yapılabilmektedir fakat şuan o kısmın arkaplanı çalışmıyor. En yakın zamanda eklenecektir.
</br>
### En
Using http in the project, data was retrieved from the Weather API on the https://collectapi.com site. 5 days of weather data is drawn on the screen using Tabbar. City and data language settings can be made from the settings page, but the background of that section is not working now. It will be added as soon as possible.



</br>

## Project Feature

#### Flutter Http Service ✓
#### Responsive Screen ✖
#### Clean Code ✓


</br>

## Using


#### Use http package as a library
```js
   $ flutter pub add http  
```

#### Import it. Now in your Dart code, you can use:
```js
   $ import 'package:http/http.dart';        
```

#### Register on collectapi.com and get an api key from the weather api for free.

```js

   var response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=eskişehir'), //Paste Weather Api url
        headers: {
          'content-type': 'application/json',
          'authorization':
              'apikey .........................' //Paste Weather Api apikey
        });
        
```



</br>

## Project Screenshots

<table>

  <tr>
     <td><img src="https://user-images.githubusercontent.com/17275354/158072016-c0eebec6-aafb-4ce2-91c2-27caab0d34cc.gif" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/158071710-d3838ef6-84e3-4b18-8b41-3a02d68e9835.png" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/158071723-c282d1ec-d0cd-4bce-932c-7287886f242a.png" width="350" title="hover text"></td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/17275354/158071728-7631c6f1-fe11-4d56-867b-79c3a5e1ff3b.png" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/158071736-d2263332-bd5d-4f4a-9b0b-7d7c332647ba.png" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/158071741-a27be32d-eff6-4eb0-94b6-fe809f597e8f.png" width="350" title="hover text"></td>
  </tr>
  
  
</table>
