DEPS =
OBJ = makefile_demo.o
CFLAGS =
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

makefile_demo: $(OBJ)
	$(CXX) -o $@ $^ $(CFLAGS)

.PHONY: clean
clean:
	rm -f *.o *~ makefile_demo

.PHONY: install
install:
	cp -f makefile_demo $(TARGET_DIR)/usr/bin/

.PHONY: uninstall
uninstall:
	rm -f $(TARGET_DIR)/usr/bin/makefile_demo
