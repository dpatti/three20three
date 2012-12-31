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

    passion:
      image: 'pittintro'
      size:
        width: 730
        height: 220
      anchor:
        to: 'cinema'
        point: 'topright'

    graphics:
      image: 'graphics'
      size:
        width: 531
        height: 220
      anchor:
        to: 'cinema'
        point: 'bottomleft'

    tomlin:
      image: 'tomlinshow'
      size:
        width: 350
        height: 220
      anchor:
        to: 'graphics'
        point: 'topright'

    digest:
      image: 'digest'
      size:
        width: 350
        height: 220
      anchor:
        to: 'tomlin'
        point: 'topright'

    cathedral:
      image: 'fieldpass-cathedral'
      size:
        width: 730
        height: 220
      anchor:
        to: 'graphics'
        point: 'bottomleft'

    youth:
      image: 'youthfootball'
      size:
        width: 250
        height: 220
      anchor:
        to: 'cathedral'
        point: 'topright'

    field:
      image: 'fieldpass2'
      size:
        width: 250
        height: 220
      anchor:
        to: 'youth'
        point: 'topright'
