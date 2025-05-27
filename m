Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106D3C30
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343623; cv=none; b=HVzL5nSQbTWgg6l66Kf3jlaUSGjTz8Bs7hfseIUoTJV1G8lxwBRA6MCQRJT2PshxWcn1Kenh3EH6BcQWpDj/Ssbk2phDDDo4JObdEwC1EwekkOIMqwemkCYte5FIh5UrFunnMkUebbTwx4hA49tBNVor7gkf8IYU5vU1LAriiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343623; c=relaxed/simple;
	bh=B87AUeb60pBmOd2FsyN6Ov+P3qQZI+zsz39+PDXNpQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4Ya0vlnohMV2j/rdNiWL9tZ0S7bRsdzcys+txfEH1DOGQIF4EYtTML1O/5BaDhLHq+P03C3k7KTfS5RGcwUjNSYz6nsLWFw7EGce2DfN+dJcl1NIcaEmzDIfKXOF+ubRTfopt/T2NCmjAMfogdRUVX8uZJRUBIdA7dLDGW3cj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QPxXdvLV; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QPxXdvLV"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b68mb6M4GzFF8;
	Tue, 27 May 2025 13:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748343615;
	bh=QtQEhIHVwl1yZd0kdSYIQAxlMC7PaVHOb/NWhVjc4Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPxXdvLV4zVhY3UNg7MdcFnCEbUkSXpG8Ix3OlkoiUeORfqtJ3Dt0/djMTRK67xos
	 WilQNgLU4Z8NioUDJ/V/IMB3oGP6g5wFnZKCeLmlP8synSIvh+VJdK1vDJV5uKfjfl
	 xc3QYNtAHO+uHvh99D4F5ocRj0PoIkgwmzntWAOY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b68mb1vJlz26S;
	Tue, 27 May 2025 13:00:15 +0200 (CEST)
Date: Tue, 27 May 2025 13:00:14 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH 02/10] landlock/hash: define (dynamic, non-resizable)
 hash table helpers
Message-ID: <20250526.quec3Dohsheu@digikod.net>
References: <cover.1747836146.git.m@maowtm.org>
 <8b4d0d2f691e36507d5ad80ad4203c29ac6f216c.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b4d0d2f691e36507d5ad80ad4203c29ac6f216c.1747836146.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Wed, May 21, 2025 at 08:31:58PM +0100, Tingmao Wang wrote:
> While there is already include/linux/hash.h, it relies on the static size
> of the array as the size of the hash table, and thus is inconvenient to
> use for this case where we dynamically compute how many slots we need.
> 
> There is also the relativistic hash tables in rhashtable.h which supports
> dynamic resizes etc, but is more complicated and might be slower to access?
> 
> However, on second thought, I'm wondering if we should just use hash
> tables for both domain and a not-yet-merged ruleset anyway (which saves us
> from having a union in landlock_rule).  If we do that then we should
> indeed just use rhashtable.

Thinking more about it, the important properties are that we can have a
lot of domains/tables (i.e. sandboxed processes) with a few
entries/rules (e.g. ~30 rules seems reasonable for now).  We should then
try to minimize the total amount of memory while still making access
checks quick.  As you noted, the cost of hashing should also not be
ignored.

Instead of a hash table per domain, what about flat arrays with binary
search?  Here is a proposal:

struct landlock_domain_index {
    union landlock_key key;
    u32 shift; // value to add to this array's index to jump to the set
               // of mapped landlock_layer
    u32 num_layers;
}; // 128-bit (or 96-bit) alligned

// Theoretical landlock_domain
struct landlock_domain {
    struct landlock_hierarchy *hierarchy;
    union {
        // See landlock_ruleset's union
    };
    u32 num_fs; // number of FS indexes
    u32 num_net; // number of net indexes
    struct access_masks access_masks[];
    struct landlock_domain_index fs_indexes[num_fs];
    struct landlock_layer fs_layers[sum of FS rules' layers];
    struct landlock_domain_index net_indexes[num_net];
    struct landlock_layer net_layers[sum of net rules' layers];
};

// Real landlock_domain
struct landlock_domain {
    struct landlock_hierarchy *hierarchy;
    union {
        // See landlock_ruleset's union
    };
    u32 num_fs; // number of FS indexes
    u32 num_net; // number of net indexes
    u32 rules[]; // underlying typed arrays accessed via helpers
};

The landlock_domain is a contiguously allocated memory buffer containing
variable-size arrays improving locality.  Another advantage is that we
would not get any potential allocation errors once the buffer is
allocated which should simplify domain creation.  Also, we avoid the
union in landlock_rule (patch 5) and only use landlock_rule in
landlock_ruleset.

An alternative approach would be to use a hash table instead of the
array (extending landlock_domain_index with a pointer/shift to the next
collision) but still with this big buffer.  I'm not sure the perf impact
would be noticable but it might be worse a try.

> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/hash.h | 117 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 security/landlock/hash.h
> 
> diff --git a/security/landlock/hash.h b/security/landlock/hash.h
> new file mode 100644
> index 000000000000..955c5756d4d9
> --- /dev/null
> +++ b/security/landlock/hash.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock - Domain hashtable mainpulation

typo

> + *
> + * Copyright © 2025      Tingmao Wang <m@maowtm.org>
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_HASH_H
> +#define _SECURITY_LANDLOCK_HASH_H
> +
> +#include <linux/slab.h>
> +#include <linux/hash.h>
> +
> +#include "ruleset.h"
> +
> +struct landlock_hashtable {
> +	struct hlist_head *hlist;

A simple linked-list would be enough.

> +
> +	/**
> +	 * @hash_bits: Number of bits in this hash index (i.e.  hlist has
> +	 * 2^this many elements).
> +	 */
> +	int hash_bits;
> +};
> +
> +#define landlock_hash_for_each(rule, ht, i)                \
> +	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
> +		hlist_for_each_entry(rule, &(ht)->hlist[i], hlist)
> +
> +#define landlock_hash_for_each_safe(rule, tmp, ht, i)      \
> +	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
> +		hlist_for_each_entry_safe(rule, tmp, &(ht)->hlist[i], hlist)
> +
> +static inline int landlock_hash_init(const size_t expected_num_entries,
> +				     struct landlock_hashtable *out_ht)
> +{
> +	size_t table_sz = 1;

Please use variables with full name when they are not too big:
table_size in this case.

> +	int hash_bits = 0;
> +
> +	if (likely(expected_num_entries > 0)) {
> +		table_sz = roundup_pow_of_two(expected_num_entries);

With roundup_pow_of_two() we'll get a few collisions but a big table.
What would be the impact of using roundup_pow_of_two() instead to have a
compact hash table (with more collisions)?

> +		hash_bits = fls_long(table_sz - 1);
> +	}
> +
> +	/*
> +	 * We allocate a table even if expected_num_entries == 0 to avoid
> +	 * unnecessary branching in lookup code
> +	 */
> +
> +	out_ht->hash_bits = hash_bits;
> +	out_ht->hlist = kcalloc(table_sz, sizeof(struct hlist_head),
> +				GFP_KERNEL_ACCOUNT);
> +	if (!out_ht->hlist) {
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void landlock_hash_free(struct landlock_hashtable *ht,
> +				      const enum landlock_key_type key_type)
> +{
> +	struct landlock_rule *rule;
> +	struct hlist_node *tmp;
> +	size_t i;
> +
> +	if (key_type == LANDLOCK_KEY_INODE)
> +		might_sleep();
> +
> +	if (!ht->hlist)
> +		return;
> +
> +	landlock_hash_for_each_safe(rule, tmp, ht, i)
> +	{
> +		free_rule(rule, key_type);
> +	}
> +	kfree(ht->hlist);
> +	ht->hlist = NULL;
> +}
> +
> +static inline u32 landlock_hash_key(const union landlock_key key,
> +				    const int hash_bits)
> +{
> +	return hash_ptr((void *)key.data, hash_bits);
> +}
> +
> +static inline struct landlock_rule *
> +landlock_hash_find(const struct landlock_hashtable *const ht,
> +		   const union landlock_key key)
> +{
> +	struct hlist_head *head;
> +	struct landlock_rule *rule;
> +
> +	head = &ht->hlist[landlock_hash_key(key, ht->hash_bits)];
> +
> +	hlist_for_each_entry(rule, head, hlist) {
> +		if (rule->key.data == key.data)
> +			return rule;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * @landlock_hash_count - Return number of entries in the hashtable.
> + */
> +static inline size_t landlock_hash_count(const struct landlock_hashtable *ht)
> +{
> +	size_t num_entries = 0;
> +	struct landlock_rule *rule;
> +	size_t i;
> +	landlock_hash_for_each(rule, ht, i)
> +	{
> +		num_entries += 1;
> +	}
> +	return num_entries;
> +}
> -- 
> 2.49.0
> 
> 
