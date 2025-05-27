Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911F2512EB
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343608; cv=none; b=GiEN+UMedXxlqZGEAxZf/CEcRMC+ADLNtYgZrNn/zhwVU41oXfp0nyZk3Qh/Uf3pePXbQH5WCqAkQogDfBWNzVMxgllTrjnF8K6jNxAolzFECS4Xzx5aBZEtCNmhjUhcgDHL+BTsPh/9BHu8AdcBVCBq0iZ02qndDjfbY55jZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343608; c=relaxed/simple;
	bh=br70lFw1NvJpc2iH3hOzDzWeiP7sArx3gNYzfTk4MXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaMQsvIccr3HMTdsaVN7WvnxpilJd1nqrztsfpT2yPP+EtjxIuaX6FZabTPLqv6X356nU7+Tixj2ppPc/6LqcgbyqBXLb2tKURvFy1+XtaxtR1rBMDYFVm71v/cw0GOGtkcwU1E7QpZYHbt1c1UlfIZMk/86IfGP1WMSopfz7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FAQe76Y2; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FAQe76Y2"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b68mF42FlzC6B;
	Tue, 27 May 2025 12:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748343597;
	bh=xQZNjdHea11fHa59gzAWE7b56s+40mEGmXqbap377cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAQe76Y29ue5xWTDm05GAaPWVJgUu6B02jZBU8HT/NUPgzL5HdW4H2R5IH4LtCkzk
	 XIAY1TgAS7cWhiN4RJEzbJij+kzS0XFgu/ZIP4RPghUsBPTitZsIyjT/yJCEM3qBaW
	 vYSXdfpMa5fJsb9Li+3+Q/yM428tUaeCo0yHuvxA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b68mD4RjPz1yn;
	Tue, 27 May 2025 12:59:56 +0200 (CEST)
Date: Tue, 27 May 2025 12:59:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: landlock: Use hashtable for merged domains
Message-ID: <20250527.oaquah5upohB@digikod.net>
References: <cover.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1747836146.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Wed, May 21, 2025 at 08:31:56PM +0100, Tingmao Wang wrote:
> Hi Mickaël,
> 
> This is a set of (incomplete) patches for the "domain hashtable" work.
> While this is still a WIP, I'm sending it now as per our discussion.  You
> can take a look and see if the approach needs correcting / if we want to
> go ahead with using hashtable.
> 
> Currently only implemented for fs access.
> 
> This set of changes is also available on the landlock-hashmap branch of
> https://github.com/micromaomao/linux-dev.git

Thanks for these patches and the related benchmarks!

> 
> 
> struct landlock_domain
> ----------------------
> 
> One of the major thing I'm not sure about in this patch is the fact that
> I've decided to create a standalone `struct landlock_domain`, instead of
> re-using landlock_ruleset.  My original hope was that it might help make
> the code a bit clearer - struct landlock_ruleset would just be for
> unmerged rulesets (and it can use rbtree if we still wants to), and we can
> use this new type for domains (and add new fields and locks to it that
> wouldn't be on a ruleset, for the mutable domains / supervisor work).
> 
> I also wanted to split the logic of dealing with rules in a merged domain
> (hence needing to copy multiple layers etc) out of create_rule and
> insert_rule, and simply these functions (especially insert_rule) by
> letting them just deal with unmerged rulesets (so only one layer) - the
> logic for merged domains would be different anyway since it's no longer a
> rbtree walk (but something like landlock_hash_upsert in patch 8 instead).
> 
> However, looking back at it, I'm not sure if creating this landlock_domain
> was actually a good idea.  Going down this route eventually I will just
> have to move all the domain-related logic from using ruleset to using
> landlock_domain.  If we decide to use hashtable for unmerged rulesets too
> (not done in this patch, and need more thoughts on how that would work),
> then separating this out is even less value.
> 
> Regardless, the relevant code in this patch should still be easily
> portable to just extend landlock_ruleset with hashtables, so I'm happy to
> do that instead in the next version.

I think a dedicated struct landlock_domain has value: clearer API,
smaller domain's size, optimizations.  In the current implementation of
the hash table, the domain's size increases in most cases because of the
table's size.  We also still have scattered rules and at least two
pointer dereferencing (if no hash collision): landlock_hashtable.hlist,
and hlist_node.first.  This could be avoided with a compact flat
structure, using a hash table or just an array with sorted keys.  See a
new proposal in my reply to patch 2.

> 
> 
> Hashtable implementation
> ------------------------
> 
> Since I couldn't find a suitable existing wrapper for runtime-sized (but
> fixed after creation) hashtables, this patch uses a newly hand-rolled
> implementation.  It's not very complex so this might be fine, but there is
> also rhashtable which would be especially suitable if we want to use hash
> table for unmerged rulesets too.  See patch 2 message for details.
> 
> 
> Testing
> -------
> 
> selftests/landlock/fs_tests all passes under KASAN, lockdep etc.  Other
> tests showed no obvious issues, but base and net fails due to missing
> config (no MPTCP, no CONFIG_ASYMMETRIC_KEY_TYPE i.e. keyctl)
> 
> I ran benchmark with before/after using two workloads, on the same machine
> and setup:
> 
>     1. run_microbench with different depth and number of extra rules using
>     code in https://github.com/landlock-lsm/landlock-test-tools/pull/17
> 
>     2. A more "typical" workload I put together quickly, calling git status
>     and the like repeatedly:
>     https://github.com/torvalds/linux/commit/f1865ce970af97ac3b6f4edf580529b8cdc66371
> 
> On the "typical" workload, which has 2 layers and ~15 rules, we have:
> 
> Comparing:                    orig	  hashtable  (% change)
>   landlock_overhead:
>     (this is the % of time spent in landlock hook in the open syscall)
>                         avg = 34      33         (-2.9%)
>                      median = 34      33         (-2.9%)
> 
>   landlock_hook:        avg = 837     775        (-7.4%) (unit: ns)
>                      median = 813     748        (-8.0%) (unit: ns)
> 
>   open_syscall:         avg = 2429    2324       (-4.3%) (unit: ns)
>                      median = 2370    2265       (-4.4%) (unit: ns)
> 
> Using the microbench script, for an extreme case on a path beneath 28
> directories and with 10000 rules:
> 
> Comparing:                    orig	  hashtable  (% change)
>   landlock_overhead:    avg = 27      24         (-11.1%)
>                      median = 29      25         (-13.8%)
>   landlock_hook:        avg = 1913    1577       (-17.6%)
>                      median = 1884    1544       (-18.0%)
>   open_syscall:         avg = 6775    6259       (-7.6%)
>                      median = 6666    6115       (-8.3%)
> 
> The full results can be found at
> https://fileshare.maowtm.org/landlock/20250521/index.html
> 
> Closes: https://github.com/landlock-lsm/linux/issues/1
> 
> Tingmao Wang (10):
>   landlock: Add some debug output
>   landlock/hash: define (dynamic, non-resizable) hash table helpers
>   landlock/hash: Use linear search for small tables
>   landlock/ruleset: Rename and extract create_rule
>   Add hlist_node member to struct landlock_rule
>   landlock/domain: Define landlock_domain
>   landlock: Add the new domain to landlock_cred_security
>   landlock: Construct the inode hashtable in the new landlock_domain
>   landlock/fs: Use the new hashtable-based domain to find inode rules
>   landlock: Debug print inode hashtable in landlock_merge_ruleset2
> 
>  security/landlock/cred.c     |   8 +-
>  security/landlock/cred.h     |   1 +
>  security/landlock/domain.c   | 145 +++++++++++++++++
>  security/landlock/domain.h   |  45 ++++++
>  security/landlock/fs.c       | 107 +++++++++----
>  security/landlock/fs.h       |   1 +
>  security/landlock/hash.h     | 294 +++++++++++++++++++++++++++++++++++
>  security/landlock/ruleset.c  |  80 +---------
>  security/landlock/ruleset.h  |  99 +++++++++++-
>  security/landlock/syscalls.c |  35 +++++
>  10 files changed, 702 insertions(+), 113 deletions(-)
>  create mode 100644 security/landlock/hash.h
> 
> 
> base-commit: 3039ed432745f8fdf5cbb43fdc60b2e1aad624c1
> --
> 2.49.0
