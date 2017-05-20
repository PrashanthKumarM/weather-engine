var express = require('express');
var redis = require('redis');
var router = express.Router();
var client = redis.createClient(6379, "redis");

var app = express();

/* GET home page. */
router.get('/', function(req, res, next) {
   client.smembers('weather_machine', function(err, reply) {
    var tab = "<div>";
     for(var i = 0;i<reply.length;i++) {
      var key = reply[i];
      var count = 1;
       client.smembers(reply[i], function(err, response) {
        tab+="<div>Job Number: "+count+"</div>";
        count++;
        tab += "<div><div>"+key+"</div>";
         for(var j = 0;j<response.length;j++) {
          tab += "<div>"+response[j]+"</div>";
         }
         tab += "</div> <br>";
       });
     
     }
    tab += "</div> ";
     console.log(tab);
    setTimeout(function() {res.render('index.ejs', {tab})}, 1000);
   });
 });

module.exports = router;
