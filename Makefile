ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
IOS_SIMULATOR = "iOS Simulator,name=iPhone 15 Pro,OS=17.5"
DERIVED_DATA_DIR=$(ROOT_DIR)/.build/DerivedData

.PHONY: pre_checks_macos default

default:

pre_checks_macos:
# 	ifeq (, $(shell which xcpretty))
# 	$(error "No xcpretty in PATH, consider doing gem install xcpretty")
# 	endif

build:
	swift build

test: 
	swift test

test-swift:
	swift test -c release

test-ios: pre_checks_macos
	set -o pipefail && \
	xcodebuild test \
		-derivedDataPath $(DERIVED_DATA_DIR) \
		-scheme NotionSwift \
		-destination platform=$(IOS_SIMULATOR)

test-macos: pre_checks_macos
	set -o pipefail && \
	xcodebuild test \
		-derivedDataPath $(DERIVED_DATA_DIR) \
		-scheme NotionSwift \
		-destination platform="macOS" | xcpretty

test-linux:
	docker run \
		--rm \
		-v "$(PWD):$(PWD)" \
		-w "$(PWD)" \
		swift:5.9 \
		bash -c 'swift test -c release'

test-all: test-macos test-ios

clean:
	swift package clean
