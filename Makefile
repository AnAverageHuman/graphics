OUTFILE := image.ppm
EXECUTABLE := a.out
SCRIPT := script
OBJDIR := build
DEPLIST := depend.mk
CLEANTARGETS := $(OBJDIR) $(EXECUTABLE) $(DEPLIST) *.ppm

LDFLAGS ?= -Wl,-O1 -Wl,--as-needed
ifneq (,$(findstring ifort,$(FC))) # we are using Intel's ifort
FFLAGS ?= -O3 -xHost -fp-model source -standard-semantics
FFLAGS += -module $(OBJDIR)
else # we are probably using gcc's gfortran
FFLAGS ?= -O3 -march=native -pipe
FFLAGS += -J $(OBJDIR)
endif

SRCDIR := src
SRC := $(wildcard $(SRCDIR)/*.for)
OBJ := $(patsubst $(SRCDIR)/%.for,$(OBJDIR)/%.o,$(SRC))

ifneq ($(V),)
	SHELL := sh -x
	Q = true ||
endif

.PHONY: all clean debug $(OUTFILE)
all: $(DEPLIST) $(OUTFILE)

debug: FFLAGS := $(patsubst -O%,-g,$(FFLAGS))
debug: clean $(DEPLIST) all

clean:
	@$(foreach i, $(CLEANTARGETS), $(Q)echo "  CLEAN		$(i)"; rm -rf $(i);)

$(OBJDIR):
	@$(Q)echo "  MKDIR		$(OBJDIR)"
	@mkdir -p $(OBJDIR)

$(EXECUTABLE): $(OBJDIR)/main.o
	@$(Q)echo "  LD		$@"
	@$(LINK.f) $(OBJDIR)/*.o $(LOADLIBES) $(LDLIBS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.for $(OBJDIR)
	@$(Q)echo "  FC		$@"
	@$(COMPILE.f) $(OUTPUT_OPTION) $< 

$(OUTFILE): $(EXECUTABLE)
	@$(Q)echo "  PPM		$@"
	@./$(EXECUTABLE) $(SCRIPT)

$(DEPLIST): $(SRC)
	@$(Q)echo "  DEPGEN	$@"
	@$(file > $@)
	@$(foreach i,$^,./depgen.awk -v o="$(OBJDIR)/" -v s="$(SRCDIR)/" $i >> $@;)
	$(include $(DEPLIST))

ifeq ($(filter $(MAKECMDGOALS),clean),)
-include $(DEPLIST)
endif

