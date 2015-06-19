var BASE_URL = "http://192.168.56.101:3000"
var request = function(method, url, data, callback) {
  $.ajax({
    beforeSend: function(xhr) {
      xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
      if (window.localStorage.getItem('Authorization')) {
        xhr.setRequestHeader('Authorization', window.localStorage.Authorization)
      }
      xhr.withCredentials = true
    },
    url: BASE_URL + url,
    method: method,
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    data: JSON.stringify(data),
    success: function(data) {
      callback(data, null)
    },
    error: function(error, status, err) {
      callback(null, error.status)
    }
  })
}