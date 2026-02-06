Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF992EE5FD
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380650; cv=none; b=DZwIfkUNeXs3ICbaHJhdLEcnoPkFbpUHPETSeh2YsW+/FK0CuBa6DZ+56lUyy46E5kADjJu1C+QbDVqBCtMwloLHotAfot/Cf09/FLg05lv84TV7SnaBPBLLf99GNyzWwaxJNrzVLTzCHxFR3bS82NZmJJROXp7Da5CtRwSiGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380650; c=relaxed/simple;
	bh=QIM883YiAtXTaRybWsetJ616bX/dbfKd5ycx7MMN/F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpHaYo+XUx9rHkqMZdoX+PZZUai8spT+DX04i28rsp+gRdbzkCVxKJbMyKch7vFcu9yoZ4NyoD9QxJmoyxwAicbx/lASmAbuPdVbB3nR7i4/67TtK3A2q/VOArQZDA4BpTCjxghjeICxFcKMFK0raTvMTyDGnaBnsE20veFVLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSDyVqo7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSDyVqo7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4358fb60802so1394703f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770380649; x=1770985449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJwwST2U81EsEjDjvwsEXNOjV/gsG/vOG9zHvG6sYyU=;
        b=iSDyVqo7x8FPMxy9FNG1/eVI03N/r3xy+7+z8Kd2v2Zzz4PbT0GMY8Hk2q7H20D4Pd
         tRByid1mtxYaeEB0LTo4C/UOgYIfHXl7OsrBOI5BGZ5RoFDpKYh4ADl8BYUERrZNdgnN
         ToLcZ/HRYvoEeMjuzrc7cWxm7vtQU4s1zaok8NKDY4ZYfaxUClMCWy9V1heLUjUe0qZN
         jTfLLpBxZ3F0ivXJKvuMdlyW34edSGu33gdD4ON3LwwTf4oPFS/lc9Ao0Lj0QdqU+3DQ
         yrxa1iroNxh6SFOnn1zCDkYp7MeU86ArVoEwKr6H03IZP8DtmL1ALSlUsPW4nJUIWkvO
         WXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380649; x=1770985449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJwwST2U81EsEjDjvwsEXNOjV/gsG/vOG9zHvG6sYyU=;
        b=KlDGBmASx0ozvSqezOuUKLtg9z7teme4ySqCuZqHA3DCuOmOqcVyTk0EC97Hxslcgx
         tcJNmjNt9DC2xqYuZORR2CQwsZPvlsQd5WtHlXD20o6wLiOBCHp6U5kxCWXJV9zVCaR6
         y0q+Es4eSagfxC9msNBmYEFMhBErMrAqJSu88dR8+BtcwEJrZD/2UqNdYj0iCt3317h+
         e496NUcgABWDejahVlYf2QQejHQX+BegLa2EriHegp3CCz7A43vynJRUAmbwcit3DkZ0
         gZztR4BAQyUwvXykaMd7Qv0pao80IbY4hXKOZxIssDHR02Zn/1o9u9omWW6X0o9Ea/L/
         qc3w==
X-Gm-Message-State: AOJu0YwvRzC/ce62rkwxleUFrYDvCVKxJsmgp10GF5lEEkp9jrKUu1kg
	8uGW3DdsTtHuEJKacf/vaTbzFm7v6KJF0/7k2oecOugwokAHpc8EmDog
X-Gm-Gg: AZuq6aLvvZa4ITUhz7CqsgzLln467ftsTl30N6YR+8YjS5ThBLhMyLuQpBv9jgdRRNr
	om31M6aqi3suE0t8jxEYOEKcZX/MfHYxDbwtXLqfm+AYd89inqpvhI7mgOqHlAxtHm8nUSY1DV1
	5ov2tdithx2y5efIweNOt0LrA3HLwXTpkczKb+umcHTzEeOt2mc8+ajD5dgIOLv8bOUE6CeyBix
	Iu+BNvhRJWJU79ugLf7OgKrMuMBT17/mXdzQlTx40EFK7teKMj2vRR0i5CqX6BB49+OA4tJRIZp
	VXrCOUeqErmK6Ihdg0Gpao6fN+Lu5E6w7Ab7aeXKLq3VrAHzkBNWg9ZfcTFWnvl9gWcVFaxC7ja
	bEgWnvGROOdMCW4OzvJEfVhsgNRbnol1UMbJ+VZa1QbCGZsa3e9x48LeIUNJFWOR1TSqOX6WbHH
	ZLlMKYxYPGYa3wBDHKE2KJQQ4fzn3Q/zeQ4Rb5
X-Received: by 2002:a05:6000:2306:b0:435:b674:c9b1 with SMTP id ffacd0b85a97d-4362903c4c0mr4956525f8f.11.1770380648521;
        Fri, 06 Feb 2026 04:24:08 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bcdfcsm5691829f8f.10.2026.02.06.04.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:24:07 -0800 (PST)
Date: Fri, 6 Feb 2026 13:24:02 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/3] selftests/landlock: Add filesystem access
 benchmark
Message-ID: <20260206.e69a9f79acac@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-2-gnoack3000@gmail.com>
 <20260128.eiJou3fiezai@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128.eiJou3fiezai@digikod.net>

Hello!

On Wed, Jan 28, 2026 at 10:31:23PM +0100, Mickaël Salaün wrote:
> On Sun, Jan 25, 2026 at 08:58:51PM +0100, Günther Noack wrote:
> > --- /dev/null
> > +++ b/tools/testing/selftests/landlock/fs_bench.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Landlock filesystem benchmark
> 
> You might want to add some copyright.

Done.


> > +void usage(const char *argv0)
> 
> const

Done.


> > +int build_directory(size_t depth, bool use_landlock)
> 
> const

Done.


> > +	if (use_landlock) {
> > +		abi = syscall(SYS_landlock_create_ruleset, NULL, 0,
> > +			      LANDLOCK_CREATE_RULESET_VERSION);
> 
> Please include wrappers.h and use the related syscall helpers.  One of
> the benefit is to use __NR_* constants defined by the installed kernel
> headers.

Done.


> > +		if (abi < 7)
> > +			err(1, "Landlock ABI too low: got %d, wanted 7+", abi);
> > +	}
> > +
> > +	ruleset_fd = -1;
> > +	if (use_landlock) {
> > +		struct landlock_ruleset_attr attr = {
> > +			.handled_access_fs =
> > +				0xffff, /* All FS access rights as of 2026-01 */
> > +		};
> > +		ruleset_fd = syscall(SYS_landlock_create_ruleset, &attr,
> > +				     sizeof(attr), 0U);
> > +		if (ruleset_fd < 0)
> > +			err(1, "landlock_create_ruleset");
> > +	}
> > +
> > +	current = open(".", O_PATH);
> > +	if (current < 0)
> > +		err(1, "open(.)");
> > +
> > +	while (depth--) {
> > +		if (use_landlock) {
> > +			struct landlock_path_beneath_attr attr = {
> > +				.allowed_access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> > +				.parent_fd = current,
> > +			};
> > +			if (syscall(SYS_landlock_add_rule, ruleset_fd,
> > +				    LANDLOCK_RULE_PATH_BENEATH, &attr, 0) < 0)
> > +				err(1, "landlock_add_rule");
> > +		}
> > +
> > +		if (mkdirat(current, path, 0700) < 0)
> > +			err(1, "mkdirat(%s)", path);
> 
> We should have a loop to build the directories, then start the timer and
> have another loop to add Landlock rules.

I have to politely push back on this; the granularity of time
measurement is not high enough and the measurement below only works
because we repeat it 100000 times.  This is not the case when we
construct a Landlock ruleset, and it would IMHO be weird to build the
ruleset multiple times as well.  It feels like this would better be
measured in a separate benchmark.

Adding a rule is an operation whose runtime does not depend on the
depth of the nested directories, so such a separate benchmark would
then also be simpler and wouldn't need to construct such a deeply
nested hierarchy.


> > +	printf("*** Benchmark ***\n");
> 
> We should probably use ksft_*() helpers in main (see
> seccomp_benchmark.c).

Among the benchmarks, the seccomp benchmark is the one exception in
that it uses these ksft_*() helpers, and it's not clear to me that it
has any benefit.  These helpers are for producing TAP-formatted
output, and assume that there will be individual test cases with
success/failure results, which is not the case here.  The seccomp test
uses approximate assertions about the expected timing of operations
(+-10%), but I don't think we can easily do that in our case.

I would therefore prefer to use a normal textual output format,
similar to the other benchmarks in tools/testing/kselftests.


> > +	printf("%zu dirs, %zu iterations, %s landlock\n", num_subdirs,
> > +	       num_iterations, use_landlock ? "with" : "without");
> > +
> > +	if (times(&start_time) == -1)
> > +		err(1, "times");
> > +
> > +	current = build_directory(num_subdirs, use_landlock);
> > +
> > +	for (int i = 0; i < num_iterations; i++) {
> > +		fd = openat(current, ".", O_DIRECTORY);
> 
> We can use AT_EMPTY_PATH (with an empty path) instead of "."
> I guess the benchmark should not change, but better to check again.

This had to change anyway; now that I added cleanup of the created
directories, I had to use another operation here that would trigger
the path walk (file open for creation).  Opening directories and
removing directories both need to continue working so that we can
later remove the directories. (See discussion below.)


> > +		if (fd != -1) {
> > +			if (use_landlock)
> > +				errx(1, "openat succeeded, expected error");
> > +
> > +			close(fd);
> > +		}
> > +	}
> > +
> > +	if (times(&end_time) == -1)
> > +		err(1, "times");
> 
> The created directories should be removed here (setup and teardown).

Done.

Minor implementation remark: This is also done with explicit loops
that use openat() to walk the directory tree with file descriptors and
then unlinkat(fd, "d", ...).  At this nesting depth, the paths don't
fit into PATH_MAX any more and relative dirfds are the only way to do
that AFAIK.  (The directory walk function nftw(3) also breaks down
FWIW, because it uses long paths relative to cwd.)

–Günther
