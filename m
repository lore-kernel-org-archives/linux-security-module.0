Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7C2DAFDF
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974378; cv=none; b=G9fjmteS2PJ5+1k9NyI35ZD1BGf7KvoDi1JxF8Sw1F1vK4nwN+bAxcFpkFmHDbZZ0PnhdFSuFCVZ4TFvli725ubUEk7HLVZjTjEl620IauLLfvTuOr0v+yGLjPpf3EKzhvWgKGtnKH8tAGLjqw+xYrjNE7y3+cDZhY7tPnTgOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974378; c=relaxed/simple;
	bh=YIdsXU86fKVUNfMfd2g1kzs53qUUxWFjdW+8Fm8ZbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGbJjAG86l5LEVCGuOwXBR2zyoZrDJQHPMwT+ZEa1965+asNRmntJrBHWSWS+GDI6Zxa0jUY4ZmIJr3dyneTw7Bp/kvlPlgZlYLLwCHH9DNhyuIb2SIxRImCCtOTpyRnT4SsVgMJmdq5Lh/SABW9XMqNwTfTu1rkt2Nc08ietn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lxD1tdRS; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lxD1tdRS"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dnmg2265Szykh;
	Fri,  9 Jan 2026 16:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767974366;
	bh=L0rzsXec7LSIbJB4SoMCA+Dev+QrsQ4SnwAn630WcyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxD1tdRS/Y1NNfXSBqE489LNc4pbgt+Iz+KpooPY60y0NyDZvT4g22eEJLjveRS5G
	 wiph8w2b2A8aUBKzx0PYJoVyctEiIzI4hnRYxDmCe92/fQmNfxemSnIis4x898OI2C
	 YIvu4HP4NBfXOowBGAB5S66hy39VjK9zB49IP6BU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dnmg11f47z6vm;
	Fri,  9 Jan 2026 16:59:25 +0100 (CET)
Date: Fri, 9 Jan 2026 16:59:19 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 0/2] landlock: Refactor layer masks
Message-ID: <20260109.au3vee9Eisei@digikod.net>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230.d4bf391b98c5@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230.d4bf391b98c5@gnoack.org>
X-Infomaniak-Routing: alpha

On Tue, Dec 30, 2025 at 11:48:21AM +0100, Günther Noack wrote:
> On Tue, Dec 30, 2025 at 11:39:17AM +0100, Günther Noack wrote:
> > Tentative results with and without this patch set show that the
> > hypothesis likely holds true.  The benchmark I used exercises a "worst
> > case" scenario that attempts to be bottlenecked on the affected code:
> > constructs a large number of nested directories, with one "path
> > beneath" rule each and then tries to open the innermost directory many
> > times.  The benchmark is intentionally unrealistic to amplify the
> > amount of time used for the path walk logic and forces Landlock to
> > walk the full path (eventually failing the open syscall).  (I'll send
> > the benchmark program in a reply to this mail for full transparency.)
> 
> Please see the benchmark program below.

Thanks for the investigation!

> 
> To compile it, use:
> 
>     cc -o benchmark_worsecase benchmark_worsecase.c

It would be useful to clean up a bit this benchmark and add it to the
selftests' Landlock directory (see seccomp_benchmark.c).

> 
> Source code:
> 
> ```
> #define _GNU_SOURCE
> #include <err.h>
> #include <fcntl.h>
> #include <linux/landlock.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/times.h>
> #include <time.h>
> #include <unistd.h>
> 
> /* Flags */
> bool use_landlock = true;
> size_t num_iterations = 100000;
> size_t num_subdirs = 10000;
> 
> void usage() { puts("Usage: benchmark_worstcase [-no-landlock]"); }
> 
> /*
>  * Build a deep directory, enforce Landlock and return the FD to the
>  * deepest dir.  On any failure, exit the process with an error.
>  */
> int build_directory(size_t depth) {
>   const char *path = "d"; /* directory name */
> 
>   if (use_landlock) {
>     int abi = syscall(SYS_landlock_create_ruleset, NULL, 0,
>                       LANDLOCK_CREATE_RULESET_VERSION);
>     if (abi < 7)
>       err(1, "Landlock ABI too low: got %d, wanted 7+", abi);
>   }
> 
>   int ruleset_fd = -1;
>   if (use_landlock) {
>     if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
>       err(1, "prctl");
> 
>     struct landlock_ruleset_attr attr = {
>         .handled_access_fs = 0xffff, /* All FS access rights as of 2025-12 */
>     };
>     ruleset_fd = syscall(SYS_landlock_create_ruleset, &attr, sizeof(attr), 0U);
>     if (ruleset_fd < 0)
>       err(1, "landlock_create_ruleset");
>   }
> 
>   int current = open(".", O_PATH);
>   if (current < 0)
>     err(1, "open(.)");
> 
>   while (depth--) {
>     if (use_landlock) {
>       struct landlock_path_beneath_attr attr = {
>           .allowed_access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
>           .parent_fd = current,
>       };
>       if (syscall(SYS_landlock_add_rule, ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>                   &attr, 0) < 0)
>         err(1, "landlock_add_rule");
>     }
> 
>     if (mkdirat(current, path, 0700) < 0)
>       err(1, "mkdirat(%s)", path);
> 
>     int previous = current;
>     current = openat(current, path, O_PATH);
>     if (current < 0)
>       err(1, "open(%s)", path);
> 
>     close(previous);
>   }
> 
>   if (use_landlock) {
>     if (syscall(SYS_landlock_restrict_self, ruleset_fd, 0) < 0)
>       err(1, "landlock_restrict_self");
>   }
> 
>   close(ruleset_fd);
>   return current;
> }
> 
> int main(int argc, char *argv[]) {
>   for (int i = 1; i < argc; i++) {
>     if (!strcmp(argv[i], "-no-landlock")) {
>       use_landlock = false;
>     } else if (!strcmp(argv[i], "-d")) {
>       i++;
>       if (i < argc)
>         err(1, "expected number of subdirs after -d");
>       num_subdirs = atoi(argv[i]);
>     } else if (!strcmp(argv[i], "-n")) {
>       i++;
>       if (i < argc)
>         err(1, "expected number of iterations after -n");
>       num_iterations = atoi(argv[i]);
>     } else {
>       usage();
>       errx(1, "unknown argument: %s", argv[i]);
>     }
>   }
> 
>   printf("*** Benchmark ***\n");
>   printf("%zu dirs, %zu iterations, %s landlock\n", num_subdirs,
>          num_iterations, use_landlock ? "with" : "without");
> 
>   struct tms start_time;
>   if (times(&start_time) == -1)
>     err(1, "times");    
>   
>   int current = build_directory(num_subdirs);
> 
>   for (int i = 0; i < num_iterations; i++) {
>     int fd = openat(current, ".", O_DIRECTORY);
>     if (fd != -1)
>       errx(1, "openat succeeded, expected error");
>   }
> 
>   struct tms end_time;
>   if (times(&end_time) == -1)
>     err(1, "times");
>   
>   printf("*** Benchmark concluded ***\n");
>   printf("System: %ld clocks\n", end_time.tms_stime - start_time.tms_stime);
>   printf("User  : %ld clocks\n", end_time.tms_utime - start_time.tms_utime);
>   printf("Clocks per second: %d\n", CLOCKS_PER_SEC);
>   
>   close(current);  
> }
> ```
> 
