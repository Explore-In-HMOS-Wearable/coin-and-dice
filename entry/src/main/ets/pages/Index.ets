import { CoinFlipComponent } from '../components/CoinFlipComponent';
import { DiceComponent } from '../components/DiceComponent';

@Entry
@Component
struct Index {
  private controller: SwiperController = new SwiperController()

  build() {
    Swiper(this.controller) {
      CoinFlipComponent()
      DiceComponent()
    }
    .vertical(false)
    .indicator(new DotIndicator().maxDisplayCount(2)
      .color($r('app.color.primary_color'))
      .selectedColor($r('app.color.on_primary_color'))
    )
    .height('100%')
    .width('100%')
  }
}