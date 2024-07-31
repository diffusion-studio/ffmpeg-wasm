FFMPEG_CONFIGURE_ARGS = \
	--target-os=none \
	--arch=x86_32 \
	--cc=emcc \
	--ranlib=emranlib \
	--disable-all \
	--disable-asm \
	--enable-avcodec \
	--enable-avformat \
	--enable-protocol=file

DEMUX_ARGS = \
	--enable-demuxer=mov,mp4,avi,matroska,webm

WEB_DEMUXER_ARGS = \
	emcc ./lib/web-demuxer/*.c \
		-I./lib/FFmpeg \
		-L./lib/FFmpeg/libavformat -lavformat \
		-L./lib/FFmpeg/libavutil -lavutil \
		-L./lib/FFmpeg/libavcodec -lavcodec \
		--post-js ./lib/web-demuxer/post.js \
		-lworkerfs.js \
		-O3 \
		-s EXPORT_ES6=1 \
		-s INVOKE_RUN=0 \
		-s ENVIRONMENT=worker \
		-s EXPORTED_RUNTIME_METHODS=cwrap,getValue,UTF8ToString \
		-s EXPORTED_FUNCTIONS=_free \
		-s ASYNCIFY \
		-s WASM_BIGINT \
		-s ALLOW_MEMORY_GROWTH=1

clean:
	cd lib/FFmpeg && \
	make clean && \
	make distclean

ffmpeg-lib:
	cd lib/FFmpeg && \
	emconfigure ./configure $(FFMPEG_CONFIGURE_ARGS) $(DEMUX_ARGS) && \
	emmake make

web-demuxer: 
	$(WEB_DEMUXER_ARGS) -o ./dist/ffmpeg.js
