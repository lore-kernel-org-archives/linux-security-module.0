Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55D21254B
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091706; cv=none; b=S+hoPA+zW0SxeGE4nntAWM49vL5+MgA3tKpZp50z1m9ubFEYITY4p+/h9MWTntDYBsE3rNVMhXmRIyqTrXK61rjpnQHKzwo0PTTK0BYskB/PzY43YY/bBNcXVGVfsLpUC83dr3//EnWvGiisDBp6WyTVlKJXuxAlLt76JxC65GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091706; c=relaxed/simple;
	bh=y6StIMQb2tCtKAFWdU9JNkEWzAuWeY7Bqp2x5Mdqrx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxo4zBLFdJ7w7Jeyo7rRl+HnpsCk8lFl5DRDpBUHa4YQWad9s9UX1weDRULOxh33XCujY1q8uUHWcnbRaoxaeeJOfbGzbEhLYh6pbcreVARdkD+dHzWL1jr98tEsQooJ069pOf/4HWARpXFrpVRNP2/6m0rPPAsd7DKvB8dKZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR7cawot; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR7cawot"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so1587495466b.0
        for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 02:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767091703; x=1767696503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jcAZIDMCbr8Z0cXAksa3aQhXwblncG+JtDqjJy49MZk=;
        b=DR7cawotf4ah8RDLj9SXTK1vR1pxORrEeK95/aRvSYkw4RQADArOU4AA8zDpZvjxOE
         D5bkika96Q/y/3wCm4CSD8XQyHooXjC0yYMNNM8+Xi3h8bwLhUPZu5CQd9b27B9XJiRf
         94+NBQV3tN7vVmSgD/5QC9WW9Qn/LpcmtWbvf3/I4nJzMgtNU4X1SX09J/hrLB8uYPVp
         BIQeSc5dvFmKjuNneqzVj86GZkV/YF6EeRHX20GFDDkCl/X9VFkrgzuosRoRepzWHDVY
         vI6FPsKxqw73lNv0p9WJlKellagZWcFZDlrb1Wzd3tGUhrZA8khELGst7jQhKBRo1SRo
         PiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767091703; x=1767696503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcAZIDMCbr8Z0cXAksa3aQhXwblncG+JtDqjJy49MZk=;
        b=gSfgVa+WQHPQ/hWFItLApUuB3Xb2d2coskxC11H2EbmhJ1xS+GswSmZz5tjgx6CzIy
         cY9xfMACk9LmpHZj1m/xv5czBpgjojr7z7FsPe5as3FkEi2W4t3GAQcwfdORIqlWXzBH
         GVjL5wyV31ZS9Cx7rO66eOqj1PGf11TmBGICtO1AswpwMqgT1STiZRDMTGT9JKT0wv2S
         7oFBidFlKtDQgBODVBsEstFby8q9XkPNTt3k4oHmi7j2GDi667NB1JYPg5nYAhYVYw0y
         LvCPHeqlTSMRgbBle6+//MZKjtl66snb93fMMpl67oLo+PEy4Rks3Lmo1rwkSERiEvxR
         3SSg==
X-Gm-Message-State: AOJu0Yz3JGUXKuoVeLm9wKWwAnhTdn0F9i/Qp053jYjAj/9hLzpWeHSb
	cvJjpvb9dPkZkhVKLSAItrFKZs+/JHTHW3yb6KhM6vEp4vWjxbW6U9uJ
X-Gm-Gg: AY/fxX72/Cx2dvx0Hek70ZDjgZ1VYxszhn7DddFhYz6u0RunobBLPdhUYIeOgPQKqMm
	T3mBxvhDYTKlUwZ2yHsiYKO77tY9ckIrBr0x7m48AJLfwJDVw5qbim8BKmteI3HI/uPjQOWHQbm
	Bj9aQkHVHAipgsZ29cBMk0wOOhWWjgIhgjVdRVotoGHvM5DDsq/2GZUoT86Zc8O9ijQFJc2tu7M
	wk9bxZEBq+T8t+eJp/HJKupIM917QKtxxp05l+kJ7bXU/x+escDhzeFwGVRPweZQNOUNd3wO2XP
	hZSs7U0Zyvsl1V/VHa2ACF22L0M0hRZYBVqun+TLfJl08riqpIl9IQ+zYBYbm+gP2kNASMmvO3n
	AhgTF0LkriID2ZCO+ZaOyHmsho9OWuCkLGjutFz/y315lAJzYN0UGQR32YfTElOgfJnVmPcGXPl
	p+LxRfHlY5a/qz//4og2M7/F+XkMP5lQizGM/z
X-Google-Smtp-Source: AGHT+IFytK3lnUrwkQyEQELAg5yivKs9mMvLDiP7URBjLpOYbrfQ9a5+bK0efidUu8BlKiGS2vR4AA==
X-Received: by 2002:a17:907:da2:b0:b80:1348:226e with SMTP id a640c23a62f3a-b80371a2bc2mr3619846766b.33.1767091703197;
        Tue, 30 Dec 2025 02:48:23 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b83926533b7sm244863166b.20.2025.12.30.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:48:22 -0800 (PST)
Date: Tue, 30 Dec 2025 11:48:21 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 0/2] landlock: Refactor layer masks
Message-ID: <20251230.d4bf391b98c5@gnoack.org>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230103917.10549-3-gnoack3000@gmail.com>

On Tue, Dec 30, 2025 at 11:39:17AM +0100, Günther Noack wrote:
> Tentative results with and without this patch set show that the
> hypothesis likely holds true.  The benchmark I used exercises a "worst
> case" scenario that attempts to be bottlenecked on the affected code:
> constructs a large number of nested directories, with one "path
> beneath" rule each and then tries to open the innermost directory many
> times.  The benchmark is intentionally unrealistic to amplify the
> amount of time used for the path walk logic and forces Landlock to
> walk the full path (eventually failing the open syscall).  (I'll send
> the benchmark program in a reply to this mail for full transparency.)

Please see the benchmark program below.

To compile it, use:

    cc -o benchmark_worsecase benchmark_worsecase.c

Source code:

```
#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <linux/landlock.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/times.h>
#include <time.h>
#include <unistd.h>

/* Flags */
bool use_landlock = true;
size_t num_iterations = 100000;
size_t num_subdirs = 10000;

void usage() { puts("Usage: benchmark_worstcase [-no-landlock]"); }

/*
 * Build a deep directory, enforce Landlock and return the FD to the
 * deepest dir.  On any failure, exit the process with an error.
 */
int build_directory(size_t depth) {
  const char *path = "d"; /* directory name */

  if (use_landlock) {
    int abi = syscall(SYS_landlock_create_ruleset, NULL, 0,
                      LANDLOCK_CREATE_RULESET_VERSION);
    if (abi < 7)
      err(1, "Landlock ABI too low: got %d, wanted 7+", abi);
  }

  int ruleset_fd = -1;
  if (use_landlock) {
    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
      err(1, "prctl");

    struct landlock_ruleset_attr attr = {
        .handled_access_fs = 0xffff, /* All FS access rights as of 2025-12 */
    };
    ruleset_fd = syscall(SYS_landlock_create_ruleset, &attr, sizeof(attr), 0U);
    if (ruleset_fd < 0)
      err(1, "landlock_create_ruleset");
  }

  int current = open(".", O_PATH);
  if (current < 0)
    err(1, "open(.)");

  while (depth--) {
    if (use_landlock) {
      struct landlock_path_beneath_attr attr = {
          .allowed_access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
          .parent_fd = current,
      };
      if (syscall(SYS_landlock_add_rule, ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
                  &attr, 0) < 0)
        err(1, "landlock_add_rule");
    }

    if (mkdirat(current, path, 0700) < 0)
      err(1, "mkdirat(%s)", path);

    int previous = current;
    current = openat(current, path, O_PATH);
    if (current < 0)
      err(1, "open(%s)", path);

    close(previous);
  }

  if (use_landlock) {
    if (syscall(SYS_landlock_restrict_self, ruleset_fd, 0) < 0)
      err(1, "landlock_restrict_self");
  }

  close(ruleset_fd);
  return current;
}

int main(int argc, char *argv[]) {
  for (int i = 1; i < argc; i++) {
    if (!strcmp(argv[i], "-no-landlock")) {
      use_landlock = false;
    } else if (!strcmp(argv[i], "-d")) {
      i++;
      if (i < argc)
        err(1, "expected number of subdirs after -d");
      num_subdirs = atoi(argv[i]);
    } else if (!strcmp(argv[i], "-n")) {
      i++;
      if (i < argc)
        err(1, "expected number of iterations after -n");
      num_iterations = atoi(argv[i]);
    } else {
      usage();
      errx(1, "unknown argument: %s", argv[i]);
    }
  }

  printf("*** Benchmark ***\n");
  printf("%zu dirs, %zu iterations, %s landlock\n", num_subdirs,
         num_iterations, use_landlock ? "with" : "without");

  struct tms start_time;
  if (times(&start_time) == -1)
    err(1, "times");    
  
  int current = build_directory(num_subdirs);

  for (int i = 0; i < num_iterations; i++) {
    int fd = openat(current, ".", O_DIRECTORY);
    if (fd != -1)
      errx(1, "openat succeeded, expected error");
  }

  struct tms end_time;
  if (times(&end_time) == -1)
    err(1, "times");
  
  printf("*** Benchmark concluded ***\n");
  printf("System: %ld clocks\n", end_time.tms_stime - start_time.tms_stime);
  printf("User  : %ld clocks\n", end_time.tms_utime - start_time.tms_utime);
  printf("Clocks per second: %d\n", CLOCKS_PER_SEC);
  
  close(current);  
}
```
