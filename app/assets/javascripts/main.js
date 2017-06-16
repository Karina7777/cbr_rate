$(document).ready(function(){
  if($('#current-rate').length){

    function updateRate(){
      $.ajax({
        url: '/api/v1/get_rate/',
        success: function(data){
          $('#current-rate').html(data['rate_value_usd'])
        },
        error: function(data){

        }

      })

    }

    setInterval(updateRate, 2000)
  }
})