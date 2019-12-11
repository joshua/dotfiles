// GLOBAL CONFIGS
slate.configAll({
  defaultToCurrentScreen: true,
  nudgePercentOf: 'screenSize',
  resizePercentOf: 'screenSize',
  secondsBetweenRepeat: 0.1,
  checkDefaultsOnLoad: true,
  focusCheckWidthMax: 3000,
  orderScreensLeftToRight: true
});

// FULLSCREEN
var fullscreen = slate.op("move", {
  x: "screenOriginX",
  y: "screenOriginY",
  width: "screenSizeX",
  height: "screenSizeY"
});

// CENTER
var center = slate.op("move", {
  x: "screenOriginX+(screenSizeX-windowSizeX)/2",
  y: "screenOriginY+(screenSizeY-windowSizeY)/2",
  width: "windowSizeX",
  height: "windowSizeY"
});

// HALFS
var halfBase = slate.op("move", {
  x: "screenOriginX",
  y: "screenOriginY",
  width: "screenSizeX/2",
  height: "screenSizeY"
});
var lHalf = halfBase;
var rHalf = halfBase.dup({ x: "screenOriginX+(screenSizeX/2)" });
var tHalf = halfBase.dup({ width: "screenSizeX", height: "screenSizeY/2" });
var bHalf = tHalf.dup({ y: "screenOriginY+(screenSizeY/2)" });

// THIRDS
var thirdBase = slate.op("move", {
  x: "screenOriginX",
  y: "screenOriginY",
  width: "screenSizeX/3",
  height: "screenSizeY"
});
var lThird = thirdBase;
var mThird = thirdBase.dup({ x: "screenOriginX+(screenSizeX/3)" });
var rThird = thirdBase.dup({ x: "screenOriginX+(screenSizeX*2/3)" });
var tThird = thirdBase.dup({ width: "screenSizeX", height: "screenSizeY/3" });
var cThird = tThird.dup({ y: "screenOriginY+(screenSizeY/3)" });
var bThird = tThird.dup({ y: "screenOriginY+(screenSizeY*2/3)" });

// TWO THIRDS
var l2Thirds = thirdBase.dup({ width: "screenSizeX*2/3" });
var r2Thirds = thirdBase.dup({ x: "screenOriginX+(screenSizeX/3)", width: "screenSizeX*2/3" });
var t2Thirds = thirdBase.dup({ width: "screenSizeX", height: "screenSizeY*2/3" });
var b2Thirds = t2Thirds.dup({ y: "screenOriginY+(screenSizeY/3)" })

// CORNERS
var cornerBase = slate.op("corner", {
  direction: "top-left",
  width: "screenSizeX/2",
  height: "screenSizeY/2"
});
var tlCorner = cornerBase;
var trCorner = cornerBase.dup({ direction: "top-right" });
var blCorner = cornerBase.dup({ direction: "bottom-left" });
var brCorner = cornerBase.dup({ direction: "bottom-right" });

// CORNER THIRDS
var tlCornerThrid = tlCorner.dup({ width: "screenSizeX/3" });
var trCornerThrid = trCorner.dup({ width: "screenSizeX/3" });
var blCornerThrid = blCorner.dup({ width: "screenSizeX/3" });
var brCornerThrid = brCorner.dup({ width: "screenSizeX/3" });

// CORNER TWO THIRDS
var tlCorner2Thrid = tlCorner.dup({ width: "screenSizeX*2/3" });
var trCorner2Thrid = trCorner.dup({ width: "screenSizeX*2/3" });
var blCorner2Thrid = blCorner.dup({ width: "screenSizeX*2/3" });
var brCorner2Thrid = brCorner.dup({ width: "screenSizeX*2/3" });

// CENTER THIRDS
var centerThirdBase = slate.op("move", {
  x: "screenOriginX+(screenSizeX/3)",
  y: "screenOriginY",
  width: "screenSizeX/3",
  height: "screenSizeY/2"
});
var tCenterThird = centerThirdBase;
var bCenterThird = centerThirdBase.dup({ y: "screenOriginY+(screenSizeY/2)" });

// CHAINS
var lChain = slate.op("chain", { operations: [lHalf, lThird, l2Thirds] });
var rChain = slate.op("chain", { operations: [rHalf, rThird, r2Thirds] });
var tChain = slate.op("chain", { operations: [tHalf, tThird, t2Thirds] });
var bChain = slate.op("chain", { operations: [bHalf, bThird, b2Thirds] });

var tlCornerChain = slate.op("chain", { operations: [tlCorner, tlCornerThrid, tlCorner2Thrid] });
var trCornerChain = slate.op("chain", { operations: [trCorner, trCornerThrid, trCorner2Thrid] });
var blCornerChain = slate.op("chain", { operations: [blCorner, blCornerThrid, blCorner2Thrid] });
var brCornerChain = slate.op("chain", { operations: [brCorner, brCornerThrid, brCorner2Thrid] });

// CUSTOM THIRDS CHAIN
var thirds = [lThird, mThird, rThird, bThird, cThird, tThird];
var tMap = {};
var cycleThird = function (direction) {
  return function (win) {
    var id = win.id(), i = tMap[id];
    if (i === undefined) {
      tMap[id] = 0;
    } else {
      if (direction === "next") {
        tMap[id] = (i === 5) ? 0 : i + 1;
      } else if (direction === "prev") {
        tMap[id] = (i === 0) ? 5 : i - 1;
      }
    }
    win.doOperation(thirds[tMap[id]]);
    slate.log("[SLATE] cycleThird(" + direction + ") => windowId:" + id + " prevIndex: " + i + " curIndex:" + tMap[id]);
  };
};

// BINDINGS
slate.bindAll({
  "r:shift,ctrl,alt,cmd": slate.op("relaunch"),
  "h:ctrl,cmd": slate.op("hint", { characters: "QWERTYUIOP" }),

  "f:alt,cmd": fullscreen,
  "c:alt,cmd": center,

  "left:alt,cmd": lChain,
  "right:alt,cmd": rChain,
  "up:alt,cmd": tChain,
  "down:alt,cmd": bChain,

  "left:ctrl,alt,cmd": cycleThird("prev"),
  "right:ctrl,alt,cmd": cycleThird("next"),

  "left:ctrl,cmd": tlCornerChain,
  "right:ctrl,cmd": trCornerChain,
  "left:shift,ctrl,cmd": blCornerChain,
  "right:shift,ctrl,cmd": brCornerChain,

  "up:ctrl,cmd": tCenterThird,
  "down:ctrl,cmd": bCenterThird,

  "e:shift,ctrl,alt,cmd": function () {
    slate.shell("/usr/local/bin/code /Users/josh/.files", false, "/Users/josh/.files")
  }
});

slate.log("[SLATE] -------------- Finished Loading Config --------------");
