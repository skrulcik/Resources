
MAIN=<Insert Main Filename Here>
MAIN_CLASS=$(MAIN).class

all: $(MAIN_CLASS)


$(MAIN_CLASS): *.java
	javac $(MAIN).java

.PHONY: run
run: $(MAIN_CLASS)
	java $(MAIN)

.PHONY: clean
clean:
	rm *.class


