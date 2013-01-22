work =
  spacing: 21
  tiles:
    cinema:
      image: 'cinematography'
      size:
        width: 395
        height: 164
      anchor:
        to: ''
      popout:
        image: 'graphics+cinematography'
        offset: 175
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    passion:
      image: 'pittintro'
      size:
        width: 543
        height: 164
      anchor:
        to: 'cinema'
        point: 'topright'
      popout:
        offset: 195
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    graphics:
      image: 'graphics'
      size:
        width: 395
        height: 165
      anchor:
        to: 'cinema'
        point: 'bottomleft'
      popout:
        image: 'graphics+cinematography'
        offset: 175
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    tomlin:
      image: 'tomlinshow'
      size:
        width: 261
        height: 165
      anchor:
        to: 'graphics'
        point: 'topright'
      popout:
        offset: 190
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    digest:
      image: 'digest'
      size:
        width: 261
        height: 165
      anchor:
        to: 'tomlin'
        point: 'topright'
      popout:
        offset: 200
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    cathedral:
      image: 'fieldpass-cathedral'
      size:
        width: 543
        height: 164
      anchor:
        to: 'graphics'
        point: 'bottomleft'
      popout:
        offset: 190
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    youth:
      image: 'youthfootball'
      size:
        width: 187
        height: 164
      anchor:
        to: 'cathedral'
        point: 'topright'
      popout:
        offset: 251
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    field:
      image: 'fieldpass2'
      size:
        width: 186
        height: 164
      anchor:
        to: 'youth'
        point: 'topright'
      popout:
        offset: 353
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'
