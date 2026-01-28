Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0126B77D
	for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639217; cv=none; b=pdY0Tap+RopPEyg4cCyst61Ch2lYHmUrAdMy6YzfZgYOwF8XnXPB4gJau+T9w8ki5PADCmbmT0mVHTEf1w0ETWVqPwDrCicmxl6rcENLCRmSsmvOAup/SocH7tVcn6v5o443Fxst9sr8oyShM0B4ZvDuSPTIgN0rzEfWxTA+qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639217; c=relaxed/simple;
	bh=Ie+YMHMgCnXp0iY2XN0qsgq11Xn9zIrKebgr5YvdjTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ6re66HUU90DNUZVnyYlECJSV4II7bj4qMm32Uxv/YrrnXzjTI9+kPq1bkcwwnGcLbpZD49OqWdTIoPSVQkasiocs4HHa8tudyyjHbNfT9geTuO5ao1+eBJSLWX8Us00WkNvHa3OB3LZ/jQUFpimeepDxCDp4ZZLOQY3hlRP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XM14gNrO; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XM14gNrO"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f1b7K0VwKzdwZ;
	Wed, 28 Jan 2026 22:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769635884;
	bh=SIZT6YdTrHBMCtrT4soi24cVGioAuB/bvCibfH4mQ+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XM14gNrOh4yGFYwa/CsdrfGnnB1oTEj5d6RoqO7QBwGjK0RHNSANNYCPkhL3WouxR
	 HEJCZqVgfYs7mvtE4NZbwxeoVJq1DzfdJlCG7GdAOaoFiX3QfJiMuC9s6HgHfnZ+ih
	 0MJN5jJ9VqDJ2LlHtYJu7Z/CEa5R9SjbzzyJbelA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f1b7J3RqGzDF3;
	Wed, 28 Jan 2026 22:31:24 +0100 (CET)
Date: Wed, 28 Jan 2026 22:31:23 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/3] selftests/landlock: Add filesystem access
 benchmark
Message-ID: <20260128.eiJou3fiezai@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260125195853.109967-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Jan 25, 2026 at 08:58:51PM +0100, Günther Noack wrote:
> fs_bench benchmarks the performance of Landlock's path walk
> by exercising it in a scenario that amplifies Landlock's overhead:
> 
> * Create a large number of nested directories
> * Enforce a Landlock policy in which a rule is associated with each of
>   these subdirectories
> * Benchmark openat() applied to the deepest directory,
>   forcing Landlock to walk the entire path.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/.gitignore |   1 +
>  tools/testing/selftests/landlock/Makefile   |   1 +
>  tools/testing/selftests/landlock/fs_bench.c | 161 ++++++++++++++++++++
>  3 files changed, 163 insertions(+)
>  create mode 100644 tools/testing/selftests/landlock/fs_bench.c
> 
> diff --git a/tools/testing/selftests/landlock/.gitignore b/tools/testing/selftests/landlock/.gitignore
> index a820329cae0d..1974e17a2611 100644
> --- a/tools/testing/selftests/landlock/.gitignore
> +++ b/tools/testing/selftests/landlock/.gitignore
> @@ -1,4 +1,5 @@
>  /*_test
> +/fs_bench
>  /sandbox-and-launch
>  /true
>  /wait-pipe
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index 044b83bde16e..fc43225d319a 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -9,6 +9,7 @@ LOCAL_HDRS += $(wildcard *.h)
>  src_test := $(wildcard *_test.c)
>  
>  TEST_GEN_PROGS := $(src_test:.c=)
> +TEST_GEN_PROGS += fs_bench
>  
>  TEST_GEN_PROGS_EXTENDED := \
>  	true \
> diff --git a/tools/testing/selftests/landlock/fs_bench.c b/tools/testing/selftests/landlock/fs_bench.c
> new file mode 100644
> index 000000000000..a3b686418bc5
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/fs_bench.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock filesystem benchmark

You might want to add some copyright.

> + */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <fcntl.h>
> +#include <linux/landlock.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/prctl.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/times.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +void usage(const char *argv0)

const

> +{
> +	printf("Usage:\n");
> +	printf("  %s [OPTIONS]\n", argv0);
> +	printf("\n");
> +	printf("  Benchmark expensive Landlock checks for D nested dirs\n");
> +	printf("\n");
> +	printf("Options:\n");
> +	printf("  -h	help\n");
> +	printf("  -L	disable Landlock (as a baseline)\n");
> +	printf("  -d D	set directory depth to D\n");
> +	printf("  -n N	set number of benchmark iterations to N\n");
> +}
> +
> +/*
> + * Build a deep directory, enforce Landlock and return the FD to the
> + * deepest dir.  On any failure, exit the process with an error.
> + */
> +int build_directory(size_t depth, bool use_landlock)

const

> +{
> +	const char *path = "d"; /* directory name */
> +	int abi, ruleset_fd, current, previous;
> +
> +	if (use_landlock) {
> +		abi = syscall(SYS_landlock_create_ruleset, NULL, 0,
> +			      LANDLOCK_CREATE_RULESET_VERSION);

Please include wrappers.h and use the related syscall helpers.  One of
the benefit is to use __NR_* constants defined by the installed kernel
headers.

> +		if (abi < 7)
> +			err(1, "Landlock ABI too low: got %d, wanted 7+", abi);
> +	}
> +
> +	ruleset_fd = -1;
> +	if (use_landlock) {
> +		struct landlock_ruleset_attr attr = {
> +			.handled_access_fs =
> +				0xffff, /* All FS access rights as of 2026-01 */
> +		};
> +		ruleset_fd = syscall(SYS_landlock_create_ruleset, &attr,
> +				     sizeof(attr), 0U);
> +		if (ruleset_fd < 0)
> +			err(1, "landlock_create_ruleset");
> +	}
> +
> +	current = open(".", O_PATH);
> +	if (current < 0)
> +		err(1, "open(.)");
> +
> +	while (depth--) {
> +		if (use_landlock) {
> +			struct landlock_path_beneath_attr attr = {
> +				.allowed_access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +				.parent_fd = current,
> +			};
> +			if (syscall(SYS_landlock_add_rule, ruleset_fd,
> +				    LANDLOCK_RULE_PATH_BENEATH, &attr, 0) < 0)
> +				err(1, "landlock_add_rule");
> +		}
> +
> +		if (mkdirat(current, path, 0700) < 0)
> +			err(1, "mkdirat(%s)", path);

We should have a loop to build the directories, then start the timer and
have another loop to add Landlock rules.

> +
> +		previous = current;
> +		current = openat(current, path, O_PATH);
> +		if (current < 0)
> +			err(1, "open(%s)", path);
> +
> +		close(previous);
> +	}
> +
> +	if (use_landlock) {
> +		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
> +			err(1, "prctl");
> +
> +		if (syscall(SYS_landlock_restrict_self, ruleset_fd, 0) < 0)
> +			err(1, "landlock_restrict_self");
> +	}
> +
> +	close(ruleset_fd);
> +	return current;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	bool use_landlock = true;
> +	size_t num_iterations = 100000;
> +	size_t num_subdirs = 10000;
> +	int c, current, fd;
> +	struct tms start_time, end_time;
> +
> +	setbuf(stdout, NULL);
> +	while ((c = getopt(argc, argv, "hLd:n:")) != -1) {
> +		switch (c) {
> +		case 'h':
> +			usage(argv[0]);
> +			return EXIT_SUCCESS;
> +		case 'L':
> +			use_landlock = false;
> +			break;
> +		case 'd':
> +			num_subdirs = atoi(optarg);
> +			break;
> +		case 'n':
> +			num_iterations = atoi(optarg);
> +			break;
> +		default:
> +			usage(argv[0]);
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	printf("*** Benchmark ***\n");

We should probably use ksft_*() helpers in main (see
seccomp_benchmark.c).

> +	printf("%zu dirs, %zu iterations, %s landlock\n", num_subdirs,
> +	       num_iterations, use_landlock ? "with" : "without");
> +
> +	if (times(&start_time) == -1)
> +		err(1, "times");
> +
> +	current = build_directory(num_subdirs, use_landlock);
> +
> +	for (int i = 0; i < num_iterations; i++) {
> +		fd = openat(current, ".", O_DIRECTORY);

We can use AT_EMPTY_PATH (with an empty path) instead of "."
I guess the benchmark should not change, but better to check again.

> +		if (fd != -1) {
> +			if (use_landlock)
> +				errx(1, "openat succeeded, expected error");
> +
> +			close(fd);
> +		}
> +	}
> +
> +	if (times(&end_time) == -1)
> +		err(1, "times");

The created directories should be removed here (setup and teardown).

> +
> +	printf("*** Benchmark concluded ***\n");
> +	printf("System: %ld clocks\n",
> +	       end_time.tms_stime - start_time.tms_stime);
> +	printf("User  : %ld clocks\n",
> +	       end_time.tms_utime - start_time.tms_utime);
> +	printf("Clocks per second: %ld\n", CLOCKS_PER_SEC);
> +
> +	close(current);
> +}
> -- 
> 2.52.0
> 
> 
