OUTFILE := image.ppm
EXECUTABLE := a.out
OBJDIR := build
DEPLIST := depend.mk
CLEANTARGETS := $(OBJDIR) $(EXECUTABLE) $(DEPLIST)

LDFLAGS ?= -Wl,-O1 -Wl,--as-needed
ifneq (,$(findstring ifort,$(FC))) # we are using Intel's ifort
FFLAGS ?= -O3 -xHost -fp-model source
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

.PHONY: all clean
all: $(DEPLIST) $(OUTFILE)

debug: FFLAGS=-g
debug: clean $(DEPLIST) all

clean:
	@$(foreach i, $(CLEANTARGETS), $(Q)echo "  CLEAN		$(i)"; rm -rf $(i);)

$(OBJDIR):
	@$(Q)echo "  MKDIR		$(OBJDIR)"
	@mkdir -p $(OBJDIR)

$(EXECUTABLE): $(OBJ)
	@$(Q)echo "  LD		$@"
	@$(LINK.f) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.for $(OBJDIR)
	@$(Q)echo "  FC		$@"
	@$(COMPILE.f) $(OUTPUT_OPTION) $< 

$(OUTFILE): $(EXECUTABLE)
	@$(Q)echo "  PPM		$@"
	@./$(EXECUTABLE) > $(OUTFILE)

$(DEPLIST): $(SRC)
	@$(Q)echo "  DEPGEN	$@"
	@$(file > $@)
	@$(foreach i,$^,./depgen.awk -v o="$(OBJDIR)/" -v s="$(SRCDIR)/" $i >> $@;)
	$(include $(DEPLIST))

ifeq ($(filter $(MAKECMDGOALS),clean),)
-include $(DEPLIST)
endif

