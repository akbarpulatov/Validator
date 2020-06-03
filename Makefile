

CROSS_COMPILE=/opt/P18-L2/opt/EmbedSky/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

cur_dir=$(shell pwd)

obj_dir=$(cur_dir)/obj
SRC_PATH=$(cur_dir)
EXCLUDE_C=
DIRS = $(shell /usr/bin/find "$(SRC_PATH)" -maxdepth 1 -type d)  
SRCS_C= $(foreach dir, $(DIRS), $(wildcard $(dir)/*.c))  

SRC= $(filter-out $(EXCLUDE_C),${SRCS_C})

OBJS=${patsubst %.c, $(obj_dir)/%.o, $(SRC)}


CFLAGS = -fPIC -W -Wall -I$(cur_dir)/sdk/inc 
LDFLAGS=-L. -lpos  -lpthread -lrt -L $(cur_dir)/sdk/lib

LDFLAGS +=-lpng -liconv -lfreetype -lz 

TARGET = test_api

LIBAPI = libpos


.PHONY:all
all: $(TARGET) 

$(TARGET) :  $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

$(obj_dir)/%.o:%.c
	mkdir -p $(shell dirname $@)
	$(CC) $(CFLAGS) -o $@ -c $<	

clean:
	rm -f *.o $(OBJS) $(TARGET)
	rm -rf tmp
