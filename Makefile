CUR_DIR = $(CURDIR)

# =====================================================================
# 	run
# =====================================================================
	
env:
	echo 'FEATHER_WORK_DIR="$(CUR_DIR)/"' > .env.development

clean:
	rm -rf ./Resources/ ./Public/

run:
	swift run Feather

# =====================================================================
# 	testing
# =====================================================================


env.testing:
	echo 'FEATHER_WORK_DIR="$(CUR_DIR)/Tests/"' > .env.testing
		
clean.testing:
	rm -rf ./Tests/Resources/ ./Tests/Public/

test: clean.testing env.testing
	swift test

# =====================================================================
# 	install
# =====================================================================

install:
	swift package update
	swift build -c release
	install .build/Release/Feather ./feather #./usr/local/bin/feather

uninstall:
	rm ./feather

# =====================================================================
# 	dev
# =====================================================================


dev:
	cd .. && \
	git clone --branch dev https://github.com/FeatherCMS/feather-core && \
	git clone --branch dev https://github.com/FeatherCMS/user-module && \
	git clone --branch dev https://github.com/FeatherCMS/web-module && \
	git clone --branch dev https://github.com/FeatherCMS/analytics-module && \
	git clone --branch dev https://github.com/FeatherCMS/aggregator-module && \
	git clone --branch dev https://github.com/FeatherCMS/blog-module && \
	git clone --branch dev https://github.com/FeatherCMS/markdown-module && \
	git clone --branch dev https://github.com/FeatherCMS/redirect-module && \
	git clone --branch dev https://github.com/FeatherCMS/swifty-module && \
	cd feather

update:
	cd .. && \
	cd feather-core && git pull && cd .. && \
	cd user-module && git pull && cd .. && \
	cd web-module && git pull && cd .. && \
	cd analytics-module && git pull && cd .. && \
	cd aggregator-module && git pull && cd .. && \
	cd blog-module && git pull && cd .. && \
	cd markdown-module && git pull && cd .. && \
	cd redirect-module && git pull && cd .. && \
	cd swifty-module && git pull && cd .. && \
	cd feather

wrk:
	wrk -t12 -c400 -d30s http://localhost:8080/  
