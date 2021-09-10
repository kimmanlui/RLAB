# Welcome to Sonic Pi

live_loop :drums do
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_hard
  sleep 1
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_hard
  sleep 1
end



x=1
live_loop :test do
  
  if x==1
    use_synth :saw
  else
    use_synth :prophet
  end
  
  play :e4    ; sleep 0.5
  play :a4    ; sleep 0.5
  play :b4    ; sleep 0.5
  play :c5    ; sleep 1
  play :c5    ; sleep 1
  
  play :d5 ; sleep 0.5
  play :e5 ; sleep 0.5
  play :f5 ; sleep 2
  
  if x==1
    play :b4    ; sleep 0.5
    play :c5    ; sleep 0.5
    play :d5    ; sleep 0.5
    play :a5    ; sleep 0.5
    play :g5    ; sleep 0.5
    play :f5    ; sleep 0.5
    
    
    play :e5    ; sleep 0.1
    play :f5    ; sleep 0.1
    play :e5
    sleep 0.3
    play :eb5
    sleep 0.5
    play :e5
    sleep 2
  else
    play :b4    ; sleep 0.5
    play :c5    ; sleep 0.5
    play :d5    ; sleep 0.5
    play :a5    ; sleep 0.5
    play :g5    ; sleep 0.5
    play :b4    ; sleep 0.5
    play :c5    ; sleep 1
  end
  
  if x==2
    x=0
  end
  
  x=x+1
end