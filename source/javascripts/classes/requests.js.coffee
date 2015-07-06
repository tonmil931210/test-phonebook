class window.Request

  @BASE_URL = 'http://192.168.56.101:3000'

  @requestApi: (method, url, data, callback)->
    $.ajax
      beforeSend: (xhr) ->
        xhr.setRequestHeader 'Content-Type', 'application/json; charset=UTF-8'
        if window.localStorage.getItem('Authorization')
          xhr.setRequestHeader 'Authorization', window.localStorage.Authorization
        xhr.withCredentials = true
        return
      url: @BASE_URL + url
      method: method
      dataType: 'json'
      contentType: 'application/json; charset=utf-8'
      data: JSON.stringify(data)
      success: (data) ->
        callback data, null
        return
      error: (error, status, err) ->
        callback null, error.status
        return
    return