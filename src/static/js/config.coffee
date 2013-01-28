youtube = (id) -> "http://www.youtube.com/embed/#{ id }?wmode=opaque"
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
        offset: 345
        content: youtube '5seNDgTseBw'

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
        content: youtube 'iLg7Oddge1s'

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
        offset: 345
        content: youtube 'k94D77N0VJw'

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
        content: youtube 'op98zTa4apc'

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
        content: youtube 'Vm4pOGy--SM'

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
        content: youtube 'LnaY05G6ImA'

    youth:
      image: 'youthfootball'
      size:
        width: 187
        height: 164
      anchor:
        to: 'cathedral'
        point: 'topright'
      popout:
        offset: 205
        content: youtube 'Bn4xMmhouhw'

    field:
      image: 'fieldpass2'
      size:
        width: 186
        height: 164
      anchor:
        to: 'youth'
        point: 'topright'
      popout:
        offset: 202
        content: youtube 'Aj4zmNBTwKU'
