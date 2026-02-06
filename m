Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603E34B1B0
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382791; cv=none; b=LnFzlhPu8kevq7KAC2oqDce4K/Mum6Ru73MkdQ7kCJ77GZD6ZZNRowT8aI2iCBaX0bmnw0350rioJAK+4dQ9VXlmjFhRDpJQlXLjLgR5e/acVL4LCGGw/cjXZadDYLUBiHA1BhbAIdPAloizt8J22c7ZMKxz09ubMHGtEgGlqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382791; c=relaxed/simple;
	bh=8wMn4VHb3INFGCizplK/8s81k1EG4hXrNYgFTNkY5tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhtJVnyNqRTo6bpvVrW0Bti3h3/R1V8nA4vzYBoiPabDmL5/c02iO9UOZ4O4SyfY87d/UZBV7H2EPERlWBQkrIBR7Z6nNXL+uJxuDi33WO67B15OgsDvZMWeyRIqOw+38GCUFCj5Xjzic9G8orGZSni5b2cDJEaY7nkcSfJjdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=esBTTrTo; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="esBTTrTo"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6vLr0mK6zMlH;
	Fri,  6 Feb 2026 13:59:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770382787;
	bh=AEkxxx8dw4wBH6UQFoE+Ud9hjvIDz7ooYc5NvfPQN7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esBTTrToPFAyb9XKWuyR26QHSL6DFDf3se2bpqMWY1ofmfRQRjN5slAhUKSukP051
	 Bv9slryhZ48HoQEnRezlftBT/4mOS9tqWvU+69yTxWVvOmWpsAKsl6MD6sdAs0N7xB
	 YcrxI5XqPn03LeUULfa6/ZU2cn5EzFeVqaq3h5CU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6vLp3dlyzfrs;
	Fri,  6 Feb 2026 13:59:46 +0100 (CET)
Date: Fri, 6 Feb 2026 13:59:41 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/3] selftests/landlock: Add filesystem access
 benchmark
Message-ID: <20260206.ietoh7AeR7Ei@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-2-gnoack3000@gmail.com>
 <20260128.eiJou3fiezai@digikod.net>
 <20260206.e69a9f79acac@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206.e69a9f79acac@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Feb 06, 2026 at 01:24:02PM +0100, Günther Noack wrote:
> Hello!
> 
> On Wed, Jan 28, 2026 at 10:31:23PM +0100, Mickaël Salaün wrote:
> > On Sun, Jan 25, 2026 at 08:58:51PM +0100, Günther Noack wrote:
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/landlock/fs_bench.c

> > > +		if (abi < 7)
> > > +			err(1, "Landlock ABI too low: got %d, wanted 7+", abi);
> > > +	}
> > > +
> > > +	ruleset_fd = -1;
> > > +	if (use_landlock) {
> > > +		struct landlock_ruleset_attr attr = {
> > > +			.handled_access_fs =
> > > +				0xffff, /* All FS access rights as of 2026-01 */
> > > +		};
> > > +		ruleset_fd = syscall(SYS_landlock_create_ruleset, &attr,
> > > +				     sizeof(attr), 0U);
> > > +		if (ruleset_fd < 0)
> > > +			err(1, "landlock_create_ruleset");
> > > +	}
> > > +
> > > +	current = open(".", O_PATH);
> > > +	if (current < 0)
> > > +		err(1, "open(.)");
> > > +
> > > +	while (depth--) {
> > > +		if (use_landlock) {
> > > +			struct landlock_path_beneath_attr attr = {
> > > +				.allowed_access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> > > +				.parent_fd = current,
> > > +			};
> > > +			if (syscall(SYS_landlock_add_rule, ruleset_fd,
> > > +				    LANDLOCK_RULE_PATH_BENEATH, &attr, 0) < 0)
> > > +				err(1, "landlock_add_rule");
> > > +		}
> > > +
> > > +		if (mkdirat(current, path, 0700) < 0)
> > > +			err(1, "mkdirat(%s)", path);
> > 
> > We should have a loop to build the directories, then start the timer and
> > have another loop to add Landlock rules.
> 
> I have to politely push back on this; the granularity of time
> measurement is not high enough and the measurement below only works
> because we repeat it 100000 times.  This is not the case when we
> construct a Landlock ruleset, and it would IMHO be weird to build the
> ruleset multiple times as well.  It feels like this would better be
> measured in a separate benchmark.
> 
> Adding a rule is an operation whose runtime does not depend on the
> depth of the nested directories, so such a separate benchmark would
> then also be simpler and wouldn't need to construct such a deeply
> nested hierarchy.

OK.  Please add this explanation in a comment.

> 
> 
> > > +	printf("*** Benchmark ***\n");
> > 
> > We should probably use ksft_*() helpers in main (see
> > seccomp_benchmark.c).
> 
> Among the benchmarks, the seccomp benchmark is the one exception in
> that it uses these ksft_*() helpers, and it's not clear to me that it
> has any benefit.  These helpers are for producing TAP-formatted
> output, and assume that there will be individual test cases with
> success/failure results, which is not the case here.  The seccomp test
> uses approximate assertions about the expected timing of operations
> (+-10%), but I don't think we can easily do that in our case.
> 
> I would therefore prefer to use a normal textual output format,
> similar to the other benchmarks in tools/testing/kselftests.

OK

> 
> 
> > > +	printf("%zu dirs, %zu iterations, %s landlock\n", num_subdirs,
> > > +	       num_iterations, use_landlock ? "with" : "without");
> > > +
> > > +	if (times(&start_time) == -1)
> > > +		err(1, "times");
> > > +
> > > +	current = build_directory(num_subdirs, use_landlock);
> > > +
> > > +	for (int i = 0; i < num_iterations; i++) {
> > > +		fd = openat(current, ".", O_DIRECTORY);
> > 
> > We can use AT_EMPTY_PATH (with an empty path) instead of "."
> > I guess the benchmark should not change, but better to check again.
> 
> This had to change anyway; now that I added cleanup of the created
> directories, I had to use another operation here that would trigger
> the path walk (file open for creation).  Opening directories and
> removing directories both need to continue working so that we can
> later remove the directories. (See discussion below.)
> 
> 
> > > +		if (fd != -1) {
> > > +			if (use_landlock)
> > > +				errx(1, "openat succeeded, expected error");
> > > +
> > > +			close(fd);
> > > +		}
> > > +	}
> > > +
> > > +	if (times(&end_time) == -1)
> > > +		err(1, "times");
> > 
> > The created directories should be removed here (setup and teardown).
> 
> Done.
> 
> Minor implementation remark: This is also done with explicit loops
> that use openat() to walk the directory tree with file descriptors and
> then unlinkat(fd, "d", ...).  At this nesting depth, the paths don't
> fit into PATH_MAX any more and relative dirfds are the only way to do
> that AFAIK.  (The directory walk function nftw(3) also breaks down
> FWIW, because it uses long paths relative to cwd.)
> 
> –Günther
> 
