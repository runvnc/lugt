if not cwd?
  cwd = '.'

sortem = (files) ->
  files.sort (a, b) ->
    if a.isDirectory
      return -1
    else
      if a.name < b.name
        return -1
      else if a.name is b.name
        return 0
      else
        return 1
  files


listFiles = ->  
  now.listFiles cwd, (files) ->
    showFiles files

    
getlink = ->
  url = $('#loadfromurl').val()
  now.loadAndUncompress url, cwd, (err) ->
    $('#loadfromurl').val ''
    listFiles()

showFiles = (files) ->
  $('#cwd').html cwd
  console.log '**** FileManager showFiles ****'
  str = '<li class=\"fmitem fmupdir\">..</li>'
  sortem files
  for file in files
    listing = file.name
    classnm = "fmfile"
    if file.isDirectory
      listing += '/'
      classnm = "fmdir"
      str += "<li class=\"fmitem #{classnm}\">#{listing}</li>"
    
  $('#fsroot').html str
  
  $('.fmdir').off 'click'
  $('.fmdir').on 'click', ->    
    if cwd is '.' then cwd = './'
    console.log 'cwd starts as ' + cwd
    cwd += $(this).text()
    console.log 'cwd ends as ' + cwd
     
    listFiles()
  
  $('.fmupdir').off 'click'  
  $('.fmupdir').on 'click', ->
    dirs = cwd.split '/'
    newdirs = []
    for d in dirs
      if d isnt ''
        newdirs.push d

    newdirs.splice newdirs.length-1, 1
    cwd = newdirs.join '/'
    cwd = cwd + '/'
    listFiles()

$ ->
  $('#donesel').click -> 
    window.cwd = cwd
    window.loadini()
  $('#seldir').click ->
    $('#fileman').dialog
      title: 'Select Directory'
      width: 870
      height: $(window).height() *.9
    $('#upframe').show()  
    $('#fileswin').height $(window).height() * .75
    listFiles()
      
    $('#refreshdir').click listFiles
  now.ready ->
    now.initdirs (dir) -> 
      cwd = dir
      $('#cwd').html cwd





