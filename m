Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9786344
	for <linux-security-module@vger.kernel.org>; Mon,  2 Jun 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893820; cv=none; b=aHrDhbFlTgQiCB/q6bnDIYuy5ZURT+gRoZrGsEIa3OXO7gqhMAIYNYyudJq0iPV0ir9TNVMp5JYqKMD1PWakncnFNmJJA7vOxrzV51xLMVzaWFuRiI0FqmQsHGk9eO6nrAjKUf+rNDMW8+4PLiNKom8SE8FuJoD9qWK/Quso8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893820; c=relaxed/simple;
	bh=LvjI3LlrJ7Zg8g/bvkhfT77RSUtEJJu91dKXfvWV9xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCwYCxzbGq9qJsiLAB8ct6MTLSnq/r88ST66cX2hBk3uTdrwjRnAasgAjwh0sYk8dPyTmw6RUMfkDFDS+29Tb8hSXyrKqXfAyo++aVCnDfrfMUoNMgoCgO1skp8QJkrCulywNFEXilCPxiwZsKiqzAHf2HlhnzkjcGiulKy8gn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Nwt2zGNH; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Nwt2zGNH"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bB4FC26XWzqYJ;
	Mon,  2 Jun 2025 21:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748893807;
	bh=5GQQN+NjntWY+myNEGiXiKp8coqtI5e0IA60BofR/68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nwt2zGNHhtgn3etlMdIHz2umrb9QdUHUcWahHtDvfyZP7HV3Swx/wOhfeFE2m0PDj
	 xsvLKfGGKTBBv0mxW6ZOceHyCENeUM5oLGnxuf4ETovA4uj4Gu6bhxswkoJ1wW4r/e
	 LMJDpET52PXMBA8jKEVD17OO9jRn1YBNkN6ZOfSw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bB4FB38Y5zMJ5;
	Mon,  2 Jun 2025 21:50:06 +0200 (CEST)
Date: Mon, 2 Jun 2025 21:50:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH 02/10] landlock/hash: define (dynamic, non-resizable)
 hash table helpers
Message-ID: <20250602.uBai6ge5maiw@digikod.net>
References: <cover.1747836146.git.m@maowtm.org>
 <8b4d0d2f691e36507d5ad80ad4203c29ac6f216c.1747836146.git.m@maowtm.org>
 <20250526.quec3Dohsheu@digikod.net>
 <97fdaef3-1fe4-4aa2-a116-11d3864f0ba8@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97fdaef3-1fe4-4aa2-a116-11d3864f0ba8@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jun 02, 2025 at 02:20:08PM +0100, Tingmao Wang wrote:
> On 5/27/25 12:00, Mickaël Salaün wrote:
> > On Wed, May 21, 2025 at 08:31:58PM +0100, Tingmao Wang wrote:
> >> While there is already include/linux/hash.h, it relies on the static size
> >> of the array as the size of the hash table, and thus is inconvenient to
> >> use for this case where we dynamically compute how many slots we need.
> >>
> >> There is also the relativistic hash tables in rhashtable.h which supports
> >> dynamic resizes etc, but is more complicated and might be slower to access?
> >>
> >> However, on second thought, I'm wondering if we should just use hash
> >> tables for both domain and a not-yet-merged ruleset anyway (which saves us
> >> from having a union in landlock_rule).  If we do that then we should
> >> indeed just use rhashtable.
> >
> > Thinking more about it, the important properties are that we can have a
> > lot of domains/tables (i.e. sandboxed processes) with a few
> > entries/rules (e.g. ~30 rules seems reasonable for now).  We should then
> > try to minimize the total amount of memory while still making access
> > checks quick.  As you noted, the cost of hashing should also not be
> > ignored.
> >
> > Instead of a hash table per domain, what about flat arrays with binary
> > search?  Here is a proposal:
> 
> I think this makes sense in terms of reducing memory footprint.
> 
> My understanding of the Slab allocator is that objects are allocated in
> power-of-two sized caches, so with a single-layer, 44 bytes landlock_rule,
> we will still use 64 bytes.  Putting them in an array, especially with
> your proposed structure, would reduce this.
> 
> I also checked how the allocations actually are distributed in the current
> implementation.  Dumping the addresses of the landlock_rule objects
> allocated and sorting them by the address, we see:
> 
> # env LL_FS_RO=/usr:/bin:/etc:/lib:/sys:/dev:/home/mao/.config:/home/mao/linux LL_FS_RW=/tmp:/proc:/dev/tty:/dev/null:/dev/zero \
> > ./sandboxer bash
> Executing the sandboxed command...
> bash: /home/mao/.bashrc: Permission denied
> mao@linux-devbox-vm:~$ cat /proc/dump_landlock_domain
> Ruleset: ffff9268489451e0
>   Inode tree:
>     ffff92684e767100: inode 5374060 in fs ext4
>     ffff92684e767380 (+640 (rule itself was 44 bytes)): inode 2883604 in fs ext4
>     ffff92684e767440 (+192 (rule itself was 44 bytes)): inode 2883992 in fs ext4
>     ffff92684e767580 (+320 (rule itself was 44 bytes)): inode 11 in fs devtmpfs
>     ffff92684e767740 (+448 (rule itself was 44 bytes)): inode 5377989 in fs ext4
>     ffff92684e767800 (+192 (rule itself was 44 bytes)): inode 1 in fs devtmpfs
>     ffff92684e7678c0 (+192 (rule itself was 44 bytes)): inode 1 in fs tmpfs
>     ffff92684e767980 (+192 (rule itself was 44 bytes)): inode 6 in fs devtmpfs
>     ffff92684e767b40 (+448 (rule itself was 44 bytes)): inode 4 in fs devtmpfs
>     ffff92684e767bc0 (+128 (rule itself was 44 bytes)): inode 2883585 in fs ext4
>     ffff92684e767c40 (+128 (rule itself was 44 bytes)): inode 1 in fs sysfs
>     ffff92684e767cc0 (+128 (rule itself was 44 bytes)): inode 6815745 in fs ext4
>     ffff92684e767f80 (+704 (rule itself was 44 bytes)): inode 1 in fs proc
> 
> Note: source code for this at
> https://github.com/micromaomao/linux-dev/commit/16c318fcbc64c23b87ca67836771f710d0d0ccf1
> 
> (this is a typical result out of several repeat runs)
> (KASLR etc disabled, no_hash_pointers)
> 
> Because all landlock rules are copied at domain creation time, I
> previously thought that they are likely to be allocated close together
> (perhaps there will be some fragmentation due to a ruleset extending an
> existing rule in the parent domain), but it looks like they are still
> spreaded out a bit for some reason, and if the allocations are sparse
> during domain creation time, this situation won't fix itself and could
> slow down all access checks.  (Maybe on a single core system, with nothing
> else touching the kmem cache when the domain is being merged, they would
> be allocated together?)
> 
> I'm not sure about the performance of binary search vs rbtrees. I can see
> that the improved locality should help, but going by my benchmark of the
> hashtable domains, I'm not sure how much of a difference it make, and
> whether it would be worth the added complexity.  I could try implementing
> this flat array + binary search approach and run the existing benchmarks
> on it tho (but as of writing this I haven't).

Yes, I think binary search would be enough, taking into account the
cache.

> 
> >
> > struct landlock_domain_index {
> >     union landlock_key key;
> >     u32 shift; // value to add to this array's index to jump to the set
> >                // of mapped landlock_layer
> 
> Can you clarify the comment?  Is it the index into the layers array, or
> are you suggesting adding the index of the current landlock_domain_index
> with this shift value, and use that to index into the layers array?

I was suggesting the later but thinking out loud this doesn't help much,
we can just use an "u32 rule_index" (instead of the "shift") to jump to
the layers array.

> 
> While it's probably an unlikely situation, what if there are more than
> 2^29 rules, each having 16 layers?  I think that would overflow this u32
> even if it is an offset, and this is allowed as LANDLOCK_MAX_NUM_RULES is
> currently defined as U32_MAX.

Correct.  We can either use u64 or reduce the maximum number of rules.
I think LANDLOCK_MAX_NUM_RULES set to U16_MAX would be much more than
the worse practical case.  Even if one buggy policy tries to add one
rule per network port, that will be OK.  We could even reasonably test
this limit.  We'll need to backport this change but I'm OK with that.

> 
> (Unrelated to this patch, but I think once we have the supervise feature
> in, I can see a (probably badly implemented) supervisor getting close to
> this limit if the sandboxed application creates / delete and recreates
> lots of temporary files under /tmp)
> 
> >     u32 num_layers;
> > }; // 128-bit (or 96-bit) alligned
> 
> I guess this has to be 128 bits aligned if we have an u32 num_layers.
> Because we allow 16 layers, if we make it an u16, it would actually need
> to be the number of layers minus 1.  However maybe that is
> overcomplicating it and we should just make this 128 bits aligned
> (otherwise we have to deal with unaligned reads of the
> landlock_key->object too).

I was thinking about the size on a 32-bit architecture.

> 
> >
> > // Theoretical landlock_domain
> > struct landlock_domain {
> >     struct landlock_hierarchy *hierarchy;
> >     union {
> >         // See landlock_ruleset's union
> >     };
> >     u32 num_fs; // number of FS indexes
> >     u32 num_net; // number of net indexes
> >     struct access_masks access_masks[];
> >     struct landlock_domain_index fs_indexes[num_fs];
> >     struct landlock_layer fs_layers[sum of FS rules' layers];
> >     struct landlock_domain_index net_indexes[num_net];
> >     struct landlock_layer net_layers[sum of net rules' layers];
> > };
> 
> (Unrelated to this patch specifically, but I would probably like to use
> this domain struct for the mutable part of a domain as well later.  In
> that case the hierarchy pointer would be unused.)

OK, you can create two types.

> 
> >
> > // Real landlock_domain
> > struct landlock_domain {
> >     struct landlock_hierarchy *hierarchy;
> >     union {
> >         // See landlock_ruleset's union
> >     };
> >     u32 num_fs; // number of FS indexes
> >     u32 num_net; // number of net indexes
> >     u32 rules[]; // underlying typed arrays accessed via helpers
> > };
> >
> > The landlock_domain is a contiguously allocated memory buffer containing
> > variable-size arrays improving locality.  Another advantage is that we
> > would not get any potential allocation errors once the buffer is
> > allocated which should simplify domain creation.  Also, we avoid the
> > union in landlock_rule (patch 5) and only use landlock_rule in
> > landlock_ruleset.
> 
> I think doing this definitely has positives especially in terms of memory,
> however I'm worried about the complexity here.  Since we will have to do
> various index calculation and use it to access variable-sized arrays, I'm
> somewhat afraid that any mistake could end up either leaking kernel
> pointers, or at worst, memory corruption.

Yes, packing this is a bit complex.  We could allocate a buffer and use
pointers+lenght but I'm not sure it will be safer.  Any other
suggestion?

> 
> We should probably have a len_rules, and check (WARN_ON_ONCE and if fails
> returns -EINVAL) that any computed indices lies within range before
> accessing it.

Definitely.

> 
> >
> > An alternative approach would be to use a hash table instead of the
> > array (extending landlock_domain_index with a pointer/shift to the next
> > collision) but still with this big buffer.  I'm not sure the perf impact
> > would be noticable but it might be worse a try.
> 
> I can give that a try too and measure benchmarks.

What worries me about hash tables is the size they can take.  With
Landlock, we can have a lot of domains, and we should try to keep them
as small as possible.  I don't think a small hash table with a lot of
potential collisions would perform better than a binary search.  I
suggest you ignore this hash table unless you want to compare
performance (with a hash table + extra the same size as a flat array).

> 
> BTW, going by the direction this discussion is going, I assume we're on
> board with a separate landlock_domain, and don't plan to change how
> unmerged landlock_ruleset are stored (at least for now)?

Yes, let's focus on the domain data structure.  The ruleset's rbtree
works fine and is not a performance issue.

> If so I can
> probably start work on quiet rules, removing access bits / rules by
> intersect, etc as discussed in
> https://github.com/landlock-lsm/linux/issues/44#issuecomment-2876500918

Yes please.

> 
> >
> >>
> >> Signed-off-by: Tingmao Wang <m@maowtm.org>
> >> ---
> >>  security/landlock/hash.h | 117 +++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 117 insertions(+)
> >>  create mode 100644 security/landlock/hash.h
> >>
> >> diff --git a/security/landlock/hash.h b/security/landlock/hash.h
> >> new file mode 100644
> >> index 000000000000..955c5756d4d9
> >> --- /dev/null
> >> +++ b/security/landlock/hash.h
> >> @@ -0,0 +1,117 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Landlock - Domain hashtable mainpulation
> >
> > typo
> 
> ack
> 
> >
> >> + *
> >> + * Copyright © 2025      Tingmao Wang <m@maowtm.org>
> >> + */
> >> +
> >> +#ifndef _SECURITY_LANDLOCK_HASH_H
> >> +#define _SECURITY_LANDLOCK_HASH_H
> >> +
> >> +#include <linux/slab.h>
> >> +#include <linux/hash.h>
> >> +
> >> +#include "ruleset.h"
> >> +
> >> +struct landlock_hashtable {
> >> +	struct hlist_head *hlist;
> >
> > A simple linked-list would be enough.
> 
> I'm not sure I understand what you meant by a "simple linked-list" - do
> you mean like an array of `landlock_rule`s, each itself is part of a
> linked list of all the rules that hashed to the same key?

hlist_node has two pointers but we would only need one here.

> 
> Anyway, since we identified a flat array approach (whether we hash or
> binary search), I'm gonna try that instead.

Right

> 
> >
> >> +
> >> +	/**
> >> +	 * @hash_bits: Number of bits in this hash index (i.e.  hlist has
> >> +	 * 2^this many elements).
> >> +	 */
> >> +	int hash_bits;
> >> +};
> >> +
> >> +#define landlock_hash_for_each(rule, ht, i)                \
> >> +	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
> >> +		hlist_for_each_entry(rule, &(ht)->hlist[i], hlist)
> >> +
> >> +#define landlock_hash_for_each_safe(rule, tmp, ht, i)      \
> >> +	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
> >> +		hlist_for_each_entry_safe(rule, tmp, &(ht)->hlist[i], hlist)
> >> +
> >> +static inline int landlock_hash_init(const size_t expected_num_entries,
> >> +				     struct landlock_hashtable *out_ht)
> >> +{
> >> +	size_t table_sz = 1;
> >
> > Please use variables with full name when they are not too big:
> > table_size in this case.
> >
> >> +	int hash_bits = 0;
> >> +
> >> +	if (likely(expected_num_entries > 0)) {
> >> +		table_sz = roundup_pow_of_two(expected_num_entries);
> >
> > With roundup_pow_of_two() we'll get a few collisions but a big table.
> > What would be the impact of using roundup_pow_of_two() instead to have a
> > compact hash table (with more collisions)?
> 
> I assume you meant using rounddown_pow_of_two - I can give it a quick test
> too with the flat array approach.

Yes, I meant rounddown_pow_of_two, but I don't think it will outperform
the (small) flat array.
