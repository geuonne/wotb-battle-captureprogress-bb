# Program dependencies
CD = cd
CP = cp
RM = rm
FIND = find
MKDIR = mkdir
CUT = cut
GREP = grep

CURL = curl
7Z = 7z
DVPL = dvpl
GH = gh
GIT = git
MAKE = make


# Mod constants
# Mod full name
WMOD_TITLE = Battle CaptureProgressBar BB
# One or more of: (pc|android|ios|any)
WMOD_INITIALTARGETPLATFORM = any
# (N.N.N[+|[-N.N.N]]|any)
WMOD_INITIALTARGETPATCH = any
# (wg|lg|Any)
WMOD_INITIALTARGETPUBLISHER = any

# Compress to dvpl (n|y)
WMOD_DVPLIZE = y

# Mod variables
WMOD_PLATFORM ?= $(WMOD_INITIALTARGETPLATFORM)
WMOD_PATCH ?= $(WMOD_INITIALTARGETPATCH)
WMOD_PUBLISHER ?= $(WMOD_INITIALTARGETPUBLISHER)

REV = HEAD
# version from an annotated tag
WMOD_VERSION = $(shell $(GIT) describe --abbrev=0 $(REV) 2>/dev/null)

# Package name. Needed for Android packages
WOTB_PACKAGENAME = net.wargaming.wot.blitz
ifeq ($(WMOD_PUBLISHER), lg)
	WOTB_PACKAGENAME = com.tanksblitz
endif

# Mod title suitable for naming a package
WMOD_NAME := $(shell echo $(WMOD_TITLE) | tr '[:upper:] ' '[:lower:]-')
WMOD_PACKAGENAME = wotb_$(WMOD_NAME)_$(WMOD_VERSION)_$(WMOD_PLATFORM:any=anyplat)_$(WMOD_PUBLISHER:any=anypub)_$(WMOD_PATCH:any=anypatch)

# platform-specific game prefix, needed for making base directory for pathe ckages
WOTB_PREFIX = .
ifeq ($(WMOD_PLATFORM), pc)
	WOTB_PREFIX = Data
endif
ifeq ($(WMOD_PLATFORM), android)
	WOTB_PREFIX = $(WOTB_PACKAGENAME)/files/packs
endif


WMOD_INSTALLDIR = /sdcard/Android/data/$(WOTB_PREFIX)

BUILDDIR = build
MEDIADIR = public/media
SCRIPTSDIR = scripts

BUILDPLATFORMDIR = $(BUILDDIR)/$(WMOD_PLATFORM)/$(WOTB_PREFIX)

### Rules
all: build

build:
	$(MKDIR) -p $(BUILDPLATFORMDIR)
	$(CP) -R src/* $(BUILDPLATFORMDIR)
ifeq ($(WMOD_DVPLIZE), y)
	$(CD) $(BUILDPLATFORMDIR) && $(DVPL) compress
endif

install: build
	$(CP) -R $(BUILDPLATFORMDIR)/** $(WMOD_INSTALLDIR)

#description:
#	scripts/make-desc.sh

release:
	$(GH) release create -t $(WMOD_VERSION) $(WMOD_VERSION) $(BUILDDIR)/*.zip

.PHONY: package
package: build
	$(CD) $(BUILDDIR)/$(WMOD_PLATFORM) && $(7Z) a $(WMOD_PACKAGENAME).zip $(WOTB_PREFIX)

.PHONY: clean
clean:
	$(RM) -r -f $(BUILDDIR)
