work =
  spacing: 30
  tiles:
    cinema:
      image: 'cinematography'
      size:
        width: 531
        height: 220
      anchor:
        to: ''
      popout:
        image: 'graphics+cinematography'
        offset: 175
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    passion:
      image: 'pittintro'
      size:
        width: 730
        height: 220
      anchor:
        to: 'cinema'
        point: 'topright'
      popout:
        offset: 265
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    graphics:
      image: 'graphics'
      size:
        width: 531
        height: 220
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
        width: 350
        height: 220
      anchor:
        to: 'graphics'
        point: 'topright'
      popout:
        offset: 295
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    digest:
      image: 'digest'
      size:
        width: 350
        height: 220
      anchor:
        to: 'tomlin'
        point: 'topright'
      popout:
        offset: 350
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    cathedral:
      image: 'fieldpass-cathedral'
      size:
        width: 730
        height: 220
      anchor:
        to: 'graphics'
        point: 'bottomleft'
      popout:
        offset: 255
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    youth:
      image: 'youthfootball'
      size:
        width: 250
        height: 220
      anchor:
        to: 'cathedral'
        point: 'topright'
      popout:
        offset: 250
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'

    field:
      image: 'fieldpass2'
      size:
        width: 250
        height: 220
      anchor:
        to: 'youth'
        point: 'topright'
      popout:
        offset: 350
        content: 'http://www.youtube.com/embed/iLg7Oddge1s'
