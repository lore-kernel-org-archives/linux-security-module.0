Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CE2DBF40
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397409; cv=none; b=Ev2r612/jsz37EzRwG0r8X7DGKtoE73VebtEESc2aAlaVAjNkxGsKZzl8RRmXoV2wwalIa0280sf1u3ffhBKZNq6PDMktdCL3eZdfYdPjmrcnW2gTAaZzKQBIa/OG43J3RjrV7hfzSzbLMstzD/C+nbFlI1pZOKIeU2QEwwHXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397409; c=relaxed/simple;
	bh=s4i39zmpznOFsd/h9i8q0hjw4Gxu8VYcpJJK/OrOy1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLMl5+lF4oXbiwOgy9SQADpZm8g3b2Jjx7luCW2H2REje26qsiFM1jyUvLUf5AqgzuLycx1Cn8Abgtn0sxp0Fkphgn3NYXvVKBQCKt0z0znNV1QWopDtjWcafIAeAGH76kaUiSzrRPQTbIfenTt677teG4yjqM2LAAKJ+5oUP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xr20gU+F; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xr20gU+F"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f70lx548gzBVW;
	Fri,  6 Feb 2026 18:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770397405;
	bh=UaUDmzKGfbz/LjjPgG9GB67h7HbdPWOkL4dVZ5KeUjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xr20gU+FOBgdx/U8hN/r5kNMQgo02ctH31KZoLL7SrO05kbbJ8K+Hg75A9n5BtGC/
	 PUgxF8iEBzqm6Nw3FMW7JEO8xVLKNK7MLa3g6+BtFsIdiv0LHwmH6QLlc12sUcdb47
	 W0Pc2xpG0uvrfTyAjWE8Loux+o6IJToCmLn58+5o=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f70lw3mV1z6tq;
	Fri,  6 Feb 2026 18:03:24 +0100 (CET)
Date: Fri, 6 Feb 2026 18:03:18 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 0/3] landlock: Refactor layer masks
Message-ID: <20260206.taa2IeS8au2w@digikod.net>
References: <20260206151154.97915-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206151154.97915-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

Looks good, thanks these last improvements!

On Fri, Feb 06, 2026 at 04:11:52PM +0100, Günther Noack wrote:
> Hello!
> 
> This patch set "transposes" the layer masks matrix, which was
> previously modeled as a access-max-sized array of layer masks, and
> changes it to be a layer-max-sized array of access masks instead.
> (It is a pure refactoring, there are no user-visible changes.)
> 
> This unlocks a few code simplifications and in multiple places it
> removes the need for loops and branches that deal with individual
> bits.  Instead, the changed data structure now lends itself for more
> bitwise operations.  The underlying hypothesis for me was that by
> using more bitwise operations and fewer branches, we would get an
> overall speedup even when the data structure size increases slightly
> in some cases.
> 
> Benchmark results with and without this patch set show that the
> hypothesis holds true.  The benchmark I used exercises a "worst case"
> scenario that attempts to be bottlenecked on the affected code: It
> constructs a large number of nested directories, with one "path
> beneath" rule each and then tries to open the innermost directory many
> times.  The benchmark is intentionally unrealistic to amplify the
> amount of time used for the path walk logic and forces Landlock to
> walk the full path (eventually failing the open syscall).  (I'll send
> the benchmark program in a reply to this mail for full transparency.)
> 
> Measured with the benchmark program, the patch set results in a
> speedup of about -7%.  The benchmark results are only approximate and
> have been produced in Qemu:
> 
> With the patch, the benchmark runs in 6007 clocks (measured with
> times(3)):
> 
> *** Benchmark ***
> 10000 dirs, 100000 iterations, with landlock
> *** Benchmark concluded ***
> System: 6007 clocks
> User  : 1 clocks
> Clocks per second: 1000000
> 
> Without the patch, we get 6506 clocks, which is 8% more
> 
> *** Benchmark ***
> 10000 dirs, 100000 iterations, with landlock
> *** Benchmark concluded ***
> System: 6506 clocks
> User  : 1 clocks
> Clocks per second: 1000000
> 
> The base revision used for benchmarking was
> commit b7ff7151e653 ("Merge tag 'hwmon-for-v6.19-final' of
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging").
> 
> In real-life scenarios, the speed improvement from this patch set will
> be less pronounced than in the artificial benchmark, as people do not
> usually stack directories that deeply and attach so many rules to
> them, and the EACCES error should also be the exception rather than
> the norm.
> 
> I am looking forward to your feedback.
> 
> ---
> 
> Changes since previous versions:
> 
> V3: (This patch set) 
> 
> * Benchmark:
>   * Document what it does (and doesn't) do
>   * Const, use wrappers.h, add copyright line
>   * Delete the directory hierarchy after the run
>   * Use different Landlock policy for benchmark so that deletion works
> * access_mask_subset() helper:
>   * Docstring corrections suggested by Randy Dunlap (thanks!)
>     https://lore.kernel.org/all/7b7b8fd5-7e1f-4572-a342-11a0fd24b0ac@infradead.org/
>   * Change argument names to "subset" and "superset"
>   * Use it from one more place
> * Various
>   * Do not use docstring commenting style for non-docstrings
>   * Use ssize_t for downwards iterations from N-1 to 0
>   * Slightly reword deny_mask documentation
> 
> V2:
> 
> https://lore.kernel.org/all/20260125195853.109967-1-gnoack3000@gmail.com/
> 
> * Remove the refactoring around the deny_mask_t type,
>   it is better to send that as a separate patch (mic review)
> * Added the benchmark program to the selftests
> * Fix unused variable report for "access_dom":
>   https://lore.kernel.org/all/202601200900.wonk9M0m-lkp@intel.com/
> * Use size_t and ARRAY_SIZE to loop over the layers (mic review)
> * Documentation
>   * Fixing up and adding back documentaiton (mic review)
>   * Documented landlock_unmask_layers()
>   * Fixed up kernel docs in a place where it was improperly updated
>     (Spotted by Randy Dunlap
>     https://lore.kernel.org/all/20260123025121.3713403-1-rdunlap@infradead.org/)
> * Minor
>   * Const, some newlines (mic review)
> 
> V1: (Initial version)
> 
> https://lore.kernel.org/all/20251230103917.10549-3-gnoack3000@gmail.com/
> 
> 
> Günther Noack (3):
>   selftests/landlock: Add filesystem access benchmark
>   landlock: access_mask_subset() helper
>   landlock: transpose the layer masks data structure
> 
>  security/landlock/access.h                  |  22 +-
>  security/landlock/audit.c                   |  81 ++---
>  security/landlock/audit.h                   |   3 +-
>  security/landlock/domain.c                  |  45 +--
>  security/landlock/domain.h                  |   4 +-
>  security/landlock/fs.c                      | 352 +++++++++-----------
>  security/landlock/net.c                     |   9 +-
>  security/landlock/ruleset.c                 |  89 ++---
>  security/landlock/ruleset.h                 |  21 +-
>  tools/testing/selftests/landlock/.gitignore |   1 +
>  tools/testing/selftests/landlock/Makefile   |   1 +
>  tools/testing/selftests/landlock/fs_bench.c | 214 ++++++++++++
>  12 files changed, 499 insertions(+), 343 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/fs_bench.c
> 
> -- 
> 2.52.0
> 
> 
