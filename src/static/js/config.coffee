work =
  spacing: 30
  tiles:
    cinema:
      image: 'cinematography'
      size:
        width: 470
        height: 470
      anchor:
        to: ''

    tomlin:
      image: 'tomlinshow'
      size:
        width: 230
        height: 470
      anchor:
        to: 'cinema'
        point: 'topright'

    dawning:
      image: 'dawning'
      size:
        width: 531
        height: 220
      anchor:
        to: 'tomlin'
        point: 'topright'
      expand:
        topleft: 'tomlin'
        bottomleft: 'tomlin'
        bottomright: 'pitt'

    pitt:
      image: 'FBintro'
      size:
        width: 531
        height: 220
      anchor:
        to: 'dawning'
        point: 'bottomleft'
