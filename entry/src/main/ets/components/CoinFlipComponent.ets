import lottie, { AnimationItem } from '@ohos/lottie';
import Logger from '../utils/Logger';

@Component
export struct CoinFlipComponent {
  @State private showCoinResult: boolean = false;
  @State private isHeadCoin: boolean = false;
  private canvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D();
  private animateName: string = 'coin';
  private animateItem: AnimationItem | null = null;

  build() {
    Stack() {
      Canvas(this.canvasRenderingContext)
        .borderRadius(3)
        .onReady(() => {
          this.loadAnimation();
        })
        .onDisAppear(() => {
          this.cleanupAnimation();
        })
        .onClick(() => {
          this.showCoinResult = false;
          this.animateItem?.goToAndPlay(0, true);
          this.isHeadCoin = Math.random() < 0.5;
        });
      if (this.showCoinResult) {
        Image(this.isHeadCoin ? $r('app.media.ic_coin_head') : $r('app.media.ic_coin_tail'))
          .aspectRatio(1)
          .width('100px')
          .height('100px')
      }
    }
    .alignContent(Alignment.Center)
    .width('466px')
    .height('466px')
  }

  /**
   * Initializes and loads the Lottie animation.
   */
  private loadAnimation() {
    try {
      this.animateItem = lottie.loadAnimation({
        container: this.canvasRenderingContext,
        renderer: 'canvas', // canvas renderer
        loop: false,
        autoplay: false,
        name: this.animateName,
        contentMode: 'Contain',
        path: 'common/coin.json',
      });

      this.animateItem.addEventListener('complete', () => {
        this.showCoinResult = true;
      });
    } catch (error) {
      Logger.error(`Error loading Lottie animation: ${error}`);
    }
  }

  /**
   * Cleans up the Lottie animation when the component is removed.
   */
  private cleanupAnimation() {
    if (this.animateItem) {
      this.animateItem.removeEventListener('complete');
      this.animateItem.destroy();
      this.animateItem = null;
    }
  }
}