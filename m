Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0C31E0FB
	for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742619; cv=none; b=PP3w/pSG5c6Ne1EI0dCinw3OzGB40qevrhZV1WcFpNmjvWACoMUXT/P8ZLkczo//uMRYeNDaI7dqWA2pQn9ga6AQ3VK8nsay63nzgjIf9jQhV316R/5rx2LTCf3kAzOzORNy/Sob8Fc2+B5u+4RmfxqHcCencMZLDWwCE+8j8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742619; c=relaxed/simple;
	bh=NSzbOUr9xtt5NwzfN1OfCZV7DFKLs6Qxq4vNnW4eE3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3x77X0hocCMloY7iCowbIoTvWejgmYWhqXVcJ5sB7cXuqVCKVRVtbH2hBDpHWbeDk7qWnZe22kjOAuFHPXwbiNHYBqpNaCmKi1pWray0Biv61g4mREAJSVE8ksyjzvVchRO4gdGUAAv7XKLtCZDyRCBKN2s8tGvjpqLmOFw1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Z3iJycOn; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Z3iJycOn"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f9Qmd1TGrzxS6;
	Tue, 10 Feb 2026 16:42:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770738145;
	bh=6GHP5l6RVtAax54a6C7bNMqmOavngK1t2BlUrukwKjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3iJycOndpJxPvu+L3sk6ppjXDgb2+ARplv79w+xcvtU6ACNUmILsWzaprutM0h0h
	 a9N6W3UBkxwKemSX9x2iKpKJp/tfcCbIMptaDJBEJ4mlVHZ2PmKuAyzQ1rUyv1AYLN
	 uS62/SFBHi3bhoNveDvBWl5lNmotcRbDYjsWT1Qo=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f9Qmb16ZBzJW;
	Tue, 10 Feb 2026 16:42:23 +0100 (CET)
Date: Tue, 10 Feb 2026 16:42:18 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 1/3] selftests/landlock: Add filesystem access
 benchmark
Message-ID: <20260210.eid3pie9eiJi@digikod.net>
References: <20260206151154.97915-2-gnoack3000@gmail.com>
 <20260206151154.97915-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206151154.97915-3-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 06, 2026 at 04:11:53PM +0100, Günther Noack wrote:
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
>  tools/testing/selftests/landlock/fs_bench.c | 214 ++++++++++++++++++++
>  3 files changed, 216 insertions(+)
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

> +int main(int argc, char *argv[])
> +{
> +	bool use_landlock = true;
> +	size_t num_iterations = 100000;
> +	size_t num_subdirs = 10000;
> +	int c, curr, fd;
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
> +	printf("%zu dirs, %zu iterations, %s landlock\n", num_subdirs,
> +	       num_iterations, use_landlock ? "with" : "without");
> +
> +	if (times(&start_time) == -1)
> +		err(1, "times");
> +
> +	curr = build_directory(num_subdirs, use_landlock);
> +
> +	for (int i = 0; i < num_iterations; i++) {
> +		fd = openat(curr, "file.txt", O_CREAT | O_TRUNC | O_WRONLY);

Some build environments complain that O_CREAT requires the fourth
openat argument to be set.  I set the mode to 0600.

> +		if (use_landlock) {
> +			if (fd == 0)
> +				errx(1, "openat succeeded, expected EACCES");
> +			if (errno != EACCES)
> +				err(1, "openat expected EACCES, but got");
> +		}
> +		if (fd != -1)
> +			close(fd);
> +	}
> +
> +	if (times(&end_time) == -1)
> +		err(1, "times");
> +
> +	printf("*** Benchmark concluded ***\n");
> +	printf("System: %ld clocks\n",
> +	       end_time.tms_stime - start_time.tms_stime);
> +	printf("User  : %ld clocks\n",
> +	       end_time.tms_utime - start_time.tms_utime);
> +	printf("Clocks per second: %ld\n", CLOCKS_PER_SEC);
> +
> +	close(curr);
> +
> +	remove_recursively(num_subdirs);
> +}
> -- 
> 2.52.0
> 
> 
