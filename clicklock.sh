#!/bin/bash

DEVICE_ID=9      # Kensington SlimBlade Pro Trackball (pointer)
BUTTON=1         # 左クリック
HOLD_MS=1000     # 1秒長押しでロック
POLL_MS=30       # 監視間隔 30ms

locked=0         # 0=通常, 1=ロック中
last_down=0      # 前フレームのボタン状態
press_start_ms=0 # 押し始めた時刻
long_press=0     # 長押しになったかどうか

echo "ClickLock: device=$DEVICE_ID hold=${HOLD_MS}ms"

get_now_ms() {
  echo $(( $(date +%s%3N) ))
}

while true; do
  STATE=$(xinput query-state "$DEVICE_ID" 2>/dev/null)
  if [ $? -ne 0 ]; then
    sleep 0.1
    continue
  fi

  if echo "$STATE" | grep -q "button\[$BUTTON]=down"; then
    down=1
  else
    down=0
  fi

  now_ms=$(get_now_ms)

  if [ $locked -eq 0 ]; then
    # --- ロックしていない状態 ---
    if [ $down -eq 1 ] && [ $last_down -eq 0 ]; then
      # 押し始め
      press_start_ms=$now_ms
      long_press=0
    elif [ $down -eq 1 ] && [ $last_down -eq 1 ]; then
      # 押しっぱなし中
      elapsed=$(( now_ms - press_start_ms ))
      if [ $elapsed -ge $HOLD_MS ]; then
        long_press=1
      fi
    elif [ $down -eq 0 ] && [ $last_down -eq 1 ]; then
      # ボタンを離した
      if [ $long_press -eq 1 ]; then
        # ここで初めてロックON（物理ボタンが離れてから押しっぱなしを送る）
        echo ">>> ロックON (mousedown after long-press release)"
        xdotool mousedown $BUTTON
        locked=1
      fi
      long_press=0
    fi

  else
    # --- ロック中：次のクリックで解除 ---
    if [ $down -eq 0 ] && [ $last_down -eq 1 ]; then
      echo ">>> ロック解除 (mouseup)"
      xdotool mouseup $BUTTON
      locked=0
    fi
  fi

  last_down=$down
  sleep 0.03
done

