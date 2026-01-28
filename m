Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237C32571F
	for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638017; cv=none; b=gX6xmq+0nx0OADFlVh5qJ7K51ZzUEBOYSrl/apPf+KCv5FwYXjofQLKKSHSjVh9uDs9TsHuHqm1XuibqGpJ5/ZXfLYHNqH0WaOSJW15hRqhn5Rof5h/KhbyFqne38rciNxDLarTXFGcTfPJrOVYqC+ZQSgLAbWbyFIgyHIsId8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638017; c=relaxed/simple;
	bh=4GsZJaqBx/KwCOqC8QRzI35J6dotbDp4jOxsgHPjCnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4WmXbi9h7CHROctKbL608cpoqg1bgvWCW5IvfrltVWtdUKNHs5WBoL5lFB1T7EHOiLP28JxMVpjKBMhgecIVyQN8t6RjXJ8Bz6rKcaQs/0G6GgsLnNBSvtod7SyZNDESsL1m6vfs4oRfWV3ZFt9WS1o7b5c6t8D3zudp0JZbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xrhQHr1N; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xrhQHr1N"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f1b750x9xzgjh;
	Wed, 28 Jan 2026 22:31:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769635872;
	bh=X7WEMzqbiw6Be8Tj5F/Cv/1lL+o+3kyYAuImwtfk6zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xrhQHr1Nxc+duZCfvplpLPNgOcys6Bvs0bjdM/sK6LqmxsNV2g2ly9FfuNgC0Ur3g
	 80svJOl8qHV8neqWdcSFNXOV95SGIMmw87T5b2y1l/29q3m9QF4ol7jQO7jCM/w8b1
	 bkGnw7phWA7tVGWGVBNDex46Qxc4xTJJw0GkUjCE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f1b7359fbz6CG;
	Wed, 28 Jan 2026 22:31:11 +0100 (CET)
Date: Wed, 28 Jan 2026 22:31:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/3] landlock: Refactor layer masks
Message-ID: <20260128.jiethoh2Zeem@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260125195853.109967-1-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Jan 25, 2026 at 08:58:50PM +0100, Günther Noack wrote:
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
> Tentative results with and without this patch set show that the
> hypothesis likely holds true.  The benchmark I used exercises a "worst
> case" scenario that attempts to be bottlenecked on the affected code:
> constructs a large number of nested directories, with one "path
> beneath" rule each and then tries to open the innermost directory many
> times.  The benchmark is intentionally unrealistic to amplify the
> amount of time used for the path walk logic and forces Landlock to
> walk the full path (eventually failing the open syscall).  (I'll send
> the benchmark program in a reply to this mail for full transparency.)
> 
> Measured with the benchmark program, the patch set results in a
> speedup of about -10%.  The benchmark results are only tentative and
> have been produced in Qemu:
> 
> With the patch, the benchmark runs in 6046 clocks (measured with
> times(3)):
> 
> *** Benchmark ***
> 10000 dirs, 100000 iterations, with landlock
> *** Benchmark concluded ***
> System: 6046 clocks
> User  : 1 clocks
> Clocks per second: 1000000
> 
> Without the patch, we get 6713 clocks, which is 11% more
> 
> *** Benchmark ***
> 10000 dirs, 100000 iterations, with landlock
> *** Benchmark concluded ***
> System: 6713 clocks
> User  : 0 clocks
> Clocks per second: 1000000
> 
> The base revision used for benchmarking was commit 7a51784da76d
> ("tools/sched_ext: update scx_show_state.py for scx_aborting change")
> 
> In real-life scenarios, the speed improvement from this patch set will
> be less pronounced than in the artificial benchmark, as people do not
> usually stack directories that deeply and attach so many rules to
> them, and the EACCES error should also be the exception rather than
> the norm.
> 
> I am looking forward to your feedback.
> 
> P.S.: I am open to suggestions on what the "layer masks" variables
> should be called, because the name "layer masks" might be less
> appropriate after this change.  I have not fixed up the name
> everywhere because fixing up the code took priority for now.

Could you please clarify your thoughts and explain why this name might
not be appropriate anymore?  Any list of name proposals?

If we rename the variables, this should be done in the same refactoring
patch.

> 
> ---
> Changes since previous versions:
> 
> V2: (This patch set)
> 
> * Remove the refactoring around the deny_mask_t type,
>   it is better to send that as a separate patch (mic review)

Feel free to include the new dedicated patch in this series.


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
> Günther Noack (3):
>   selftests/landlock: Add filesystem access benchmark
>   landlock: access_mask_subset() helper
>   landlock: transpose the layer masks data structure
> 
>  security/landlock/access.h                  |  16 +-
>  security/landlock/audit.c                   |  84 ++---
>  security/landlock/audit.h                   |   3 +-
>  security/landlock/domain.c                  |  45 +--
>  security/landlock/domain.h                  |   4 +-
>  security/landlock/fs.c                      | 354 +++++++++-----------
>  security/landlock/net.c                     |  11 +-
>  security/landlock/ruleset.c                 |  88 ++---
>  security/landlock/ruleset.h                 |  21 +-
>  tools/testing/selftests/landlock/.gitignore |   1 +
>  tools/testing/selftests/landlock/Makefile   |   1 +
>  tools/testing/selftests/landlock/fs_bench.c | 161 +++++++++
>  12 files changed, 444 insertions(+), 345 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/fs_bench.c
> 
> -- 
> 2.52.0
> 
> 
