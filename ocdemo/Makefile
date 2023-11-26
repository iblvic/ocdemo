DD=1

%_g: test.c
	$(info ----> DD = $(DD))
	gcc -o $@ $<

ffplay ffmpeg: %: %_g

ffplay_g: DD += 2

ffmpeg_g: DD += 3

all: ffplay ffmpeg