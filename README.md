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
     <td><img src="https://user-images.githubusercontent.com/17275354/161054793-b19c1c94-02d5-402c-9827-8ea27f748af7.gif" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/161054908-681ee218-8cbe-49d4-bf25-3591575708a5.jpg" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/161054955-120ecdbf-ad6b-43c8-8100-1d2d346c72ac.jpg" width="350" title="hover text"></td>
     <td><img src="https://user-images.githubusercontent.com/17275354/161055015-42432b81-db70-4acd-a5e6-2c1f669e4e67.jpg" width="350" title="hover text"></td>
  </tr>
  <tr>
     <td><img src="https://user-images.githubusercontent.com/17275354/161055183-f27d1084-ff17-4c9b-8f97-bed30836b477.jpg" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/161055200-dc63730c-726f-4a7a-bef5-669afd8a6a61.jpg" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/161055224-29336d49-7b66-4c8d-b7d3-035c32658a87.jpg" width="350" title="hover text"></td>
     <td><img src="https://user-images.githubusercontent.com/17275354/161055234-77560f2f-2097-4931-9859-e306b6647c4f.jpg" width="350" title="hover text"></td>
  </tr>
   <tr>
     <td><img src="https://user-images.githubusercontent.com/17275354/161055263-bae82b5e-6932-445b-825a-3b5c7f15f852.jpg" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/161055291-3a7548b5-b742-4d6b-acb1-1aacdb03758c.jpg" width="350" title="hover text"></td>
    <td><img src="https://user-images.githubusercontent.com/17275354/161055309-b7afa8a4-873e-4e8e-86c3-94faafb537f3.jpg" width="350" title="hover text"></td>
     <td><img src="https://user-images.githubusercontent.com/17275354/161055339-996696db-8db4-4673-a0c5-cadbe01b1a94.jpg" width="350" title="hover text"></td>
  </tr>
   <tr>
     <td><img src="" width="350" title="hover text"></td>
    <td><img src="" width="350" title="hover text"></td>
    <td><img src="" width="350" title="hover text"></td>
     <td><img src="" width="350" title="hover text"></td>
  </tr>
  
  
</table>
