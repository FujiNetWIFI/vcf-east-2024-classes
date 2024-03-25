#
# VCFE asm lessons build
#
# Convert from unix text files without
# line numbers, into line numbered ATASCII files and build
# an ATR from the files.
#
# Uses franny and aac utilities for converting to atascii and creating/adding to ATR disk

BUILD_DIR   := build
GEN_DIR     := gen
SOURCES     := $(wildcard src/*.asm)

FRANNY      := franny

ALTIRRA ?= $(ALTIRRA_HOME)/Altirra64.exe \
	//nobasic //portabletemp //memsize:64k //ntsc \
	//disk altirra/atr/vcfe-edasm.atr //disk build/data.atr

.PHONY: all create-data-disk clean

all: generate

# convert list of sources to files we want to generate with line nums and in atascii format
GEN_FILES   := $(SOURCES:src/%=$(GEN_DIR)/%)

$(BUILD_DIR):
	mkdir build

$(GEN_DIR):
	mkdir gen

vpath %.asm src

$(GEN_DIR)/%.asm: %.asm | $(GEN_DIR) create-data-disk
	@echo "processing $<"
	@bin/add-num.sh $< 1000 10 > $@
	@bin/add-file-atr.sh $(BUILD_DIR)/data.atr $@

generate: $(GEN_FILES)

create-data-disk: | $(BUILD_DIR)
	@if [ ! -f "$(BUILD_DIR)/data.atr" ]; then \
	  echo "Creating data disk"; \
	  $(FRANNY) -C -t s -f a $(BUILD_DIR)/data.atr; \
	fi

test: all
	$(ALTIRRA)

clean:
	rm -rf build
	rm -rf gen
