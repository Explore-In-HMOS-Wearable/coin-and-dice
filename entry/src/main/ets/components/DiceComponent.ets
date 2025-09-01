import lottie, { AnimationItem } from '@ohos/lottie';
import Logger from '../utils/Logger';

@Component
export struct DiceComponent {
  private timeoutId: number | null = null;
  private frameToShow: number = -1;
  private canvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D();
  private animateName: string = 'dice';
  private animateItem: AnimationItem | null = null;

  build() {
    Stack() {
      Canvas(this.canvasRenderingContext)
        .onReady(() => {
          this.loadAnimation();
        })
        .onDisAppear(() => {
          this.cleanupAnimation();
        })
        .width('180px')
        .height('180px')
    }
    .alignContent(Alignment.Center)
    .onClick(() => {
      this.clearTimeOutId();
      this.rollDice();
      this.setTimeOut();
    })
    .width('466px')
    .height('466px')
  }

  /**
   * Generate random number to go to as animation frame.
   */
  private rollDice() {
    this.animateItem?.goToAndPlay(0, true);
    let diceNumber: number = Math.floor(Math.random() * 6); // 0 to 5
    this.frameToShow = diceNumber * 6 + 1; // Start frame of that dice face
  }

  /**
   * Sets timeout and sets the go-to-frame with stopping animation.
   */
  private setTimeOut() {
    this.timeoutId = setTimeout(() => {
      this.animateItem?.goToAndStop(this.frameToShow, true);
      this.clearTimeOutId();
    }, 1800);
  }

  /**
   * Clears time out by ids if exists.
   */
  private clearTimeOutId() {
    if (this.timeoutId) {
      clearTimeout(this.timeoutId);
      this.timeoutId = null;
    }
  }

  /**
   * Initializes and loads the Lottie animation.
   */
  private loadAnimation() {
    try {
      this.animateItem = lottie.loadAnimation({
        container: this.canvasRenderingContext,
        renderer: 'canvas', // canvas renderer
        loop: true,
        autoplay: false,
        name: this.animateName,
        contentMode: 'Contain',
        path: 'common/dice.json',
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
      this.animateItem.destroy();
      this.animateItem = null;
    }
  }
}