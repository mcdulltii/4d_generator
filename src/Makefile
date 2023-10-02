VCC=/opt/v/v
VFLAGS=-enable-globals #-prod
FNAME=4d

.PHONY: run clean

all: $(FNAME)

$(FNAME):
	$(VCC) $(VFLAGS) $(FNAME).v

run: clean $(FNAME)
	./$(FNAME)

clean:
	$(RM) $(FNAME)
