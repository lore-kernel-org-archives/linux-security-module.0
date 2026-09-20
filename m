Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461147ECC1;
	Sun, 20 Sep 2026 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941369; cv=none; b=dBBt331wax9X+3wGIe+9LD7+wdA3Y4yACMnv9iHClQNxiTAc0S78jQSSpiORq178crFEzhSoSA4rLb1Ba+WfvZ/HP/tAOaay2zBFup+7kh0QRaw42KDYSdC7FJk2DrBLsxOnCzWcwssLB66poraXIROFk8/lYErilE9AaJGu91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941369; c=relaxed/simple;
	bh=CB4o+kFkHxn8PPX9FVAPbaHMh42DPXx33aMCy5heswA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akhdEyc9Uewo9txKXUQWVr/H6iVH/Xpn8ZfBoyDKM5i6YzxlcvppLEkgIPDz9Uff97rD7ObZnUqauM+2daFwFpcCBhHMnPBDkMx52raxCqIf1qjX0I3KGAtfRPB7PXgqwWfJ18d1Gw4zZEllC1QyoRDYdOZb0RmOIx4fYbnmUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze+HcaOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze+HcaOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6AF1F00899;
	Sun, 20 Sep 2026 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941358;
	bh=QFsAij/JXESTg11K4+nBq8vZ49HGqOt4fP682OcNRqw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ze+HcaOPnM/S3bm1iACLYsSowx32MUJ/NPn2HY/7yYXnqM4DoZB89I/DABIm+GMIa
	 2b+SIaij7Vu9II571fUM6i6dcz/mrAOmDTa1z2jT9ThcqdJuIAJ6wJ1niG1fI/mzd2
	 bXhSzXRK8cEqG25CuRWxmoM/tiNZfIiTmQRqBNN+gLnJviMCnih/7IVGjq/SjGf52S
	 mTum7Y2dt0uGNXLCfP8kcZdTdFMp3MXWWKuAXQBVRT3MmrYFllkzAYrsUPgfpbvGsH
	 h2w2ZXbv5P23X5KhBf2wDfLfMQfIRg6+93jqVAS48O3t0BH18ygT2Wx4Kbe5CJlCeO
	 8LzWfH8OJ89lA==
Subject: Re: [PATCH] netlabel: cipso_v4: reject empty MLS level/cat lists and
 zero tail in cipso_v4_delopt()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 21:55:57 +0000
Message-ID: <178994135732.2160803.15552484711039753590@kernel.org>
In-Reply-To: <20260919215243.3472150-1-benquike@gmail.com>
References: <20260919215243.3472150-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netlbl_cipsov4_remove_cb()
  (net/netlabel/netlabel_cipso_v4.c:695-703) now deletes the entire…
- [High] The new ADDRSELECT cleanup in netlbl_cipsov4_remove_cb() can
  never run for default domain mappings.
- [Medium] The new `cat.local_size == 0 || cat.cipso_size == 0` check
  inside the `if (info->attrs[NLBL_CIPSOV4_A_MLSCATLST])` block of…
- [Medium] The commit squashes three logically independent changes into
  one patch across two subsystems: (a) netlink input validation in…

Pre-existing issues:
- [Medium] Asymmetry between the two DOI-teardown walk callbacks: after
  this patch netlbl_cipsov4_remove_cb() inspects…
- [Low] The kernel-doc for cipso_v4_delopt() states 'Returns zero on
  success, negative values on failure', but the implementation returns…

--

netlabel: cipso_v4: reject empty MLS level/cat lists and zero tail in cipso_v4_delopt()

This bundles three changes: netlbl_cipsov4_add_std() now rejects zero-sized
MLS level and category tables before kcalloc(), netlbl_cipsov4_remove_cb()
also inspects NETLBL_NLTYPE_ADDRSELECT entries, and cipso_v4_delopt() zeroes
the trailing bytes after the memmove() and shortens the length passed to
cipso_v4_get_actual_opt_len().

The changelog describes three independent fixes:

>     Fix three bugs in NetLabel CIPSOv4 handling:
>     1. In netlbl_cipsov4_add_std(), ...
>     2. In netlbl_cipsov4_remove_cb(), ...
>     3. In cipso_v4_delopt(), ...
>
>     Fixes: 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integration")
>     Fixes: 389fb800ac8b ("netlabel: Label incoming TCP connections correctly in SELinux")

[Severity: Medium]
Could these be split into three patches?  The three hunks touch two
subsystems and have unrelated triggering conditions: the contents of a
CIPSOv4 ADD message, the contents of a CIPSOv4 REMOVE message, and the
socket/request IP option teardown path.

Both Fixes: tags are listed together with no indication of which tag covers
which hunk, so stable tooling matching either tag pulls the netlink
validation change and the netlbl_cipsov4_remove_cb() semantics change in
along with the cipso_v4_delopt() change.  Can each hunk get its own patch
with its own Fixes: tag?

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index a05aa075de1a..4ac1a4965abe 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2025,9 +2025,11 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  
>  		memmove(cipso_ptr, cipso_ptr + cipso_len,
>  			opt->opt.optlen - cipso_off - cipso_len);
> +		memset(&opt->opt.__data[opt->opt.optlen - cipso_len],
> +		       IPOPT_END, cipso_len);
>  
>  		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
> -							 opt->opt.optlen);
> +							 opt->opt.optlen - cipso_len);
>  		hdr_delta = opt->opt.optlen;
>  		opt->opt.optlen = (optlen_new + 3) & ~3;
>  		hdr_delta -= opt->opt.optlen;

[Severity: Low]
This is a pre-existing mismatch and not something this patch introduces,
but while touching this function, would it be worth correcting the
kernel-doc above cipso_v4_delopt()?  It says:

 * adjustments to the IP option structure.  Returns zero on success, negative
 * values on failure.

The body only has "return 0" for the no-CIPSO-option case and
"return hdr_delta" otherwise, where hdr_delta is the number of option bytes
removed.  There is no negative return path, and the callers
cipso_v4_sock_delattr() and cipso_v4_req_delattr() consume the byte count.

> diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
> index b080e666523f..9bb28236b8fe 100644
> --- a/net/netlabel/netlabel_cipso_v4.c
> +++ b/net/netlabel/netlabel_cipso_v4.c
> @@ -185,6 +185,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
>  					break;
>  				}
>  		}
> +	if (doi_def->map.std->lvl.local_size == 0 ||
> +	    doi_def->map.std->lvl.cipso_size == 0)
> +		goto add_std_failure;
>  	doi_def->map.std->lvl.local = kcalloc(doi_def->map.std->lvl.local_size,
>  					      sizeof(u32),
>  					      GFP_KERNEL | __GFP_NOWARN);

[ ... ]

> @@ -260,6 +263,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
>  						break;
>  					}
>  			}
> +		if (doi_def->map.std->cat.local_size == 0 ||
> +		    doi_def->map.std->cat.cipso_size == 0)
> +			goto add_std_failure;
>  		doi_def->map.std->cat.local = kcalloc(
>  					      doi_def->map.std->cat.local_size,
>  					      sizeof(u32),

[Severity: Medium]
Does this change the accepted attribute encodings for NLBL_CIPSOV4_C_ADD?

This check sits inside the "if (info->attrs[NLBL_CIPSOV4_A_MLSCATLST])"
block, so it only fires when the category list nest is present but carries
no NLBL_CIPSOV4_A_MLSCAT child.  nla_validate_nested_deprecated() returns 0
for an empty nest, the first nla_for_each_nested() pass matches nothing, and
cat.local_size / cat.cipso_size stay at 0, so ADD now returns -EINVAL.

Omitting NLBL_CIPSOV4_A_MLSCATLST entirely produces exactly the same DOI
state (empty cat.local / cat.cipso, sizes 0) and is still accepted, so only
one of the two encodings of "no categories" is rejected.

There is also a round-trip asymmetry with the LIST side.
netlbl_cipsov4_list() starts the nest unconditionally for
CIPSO_V4_MAP_TRANS:

	nla_a = nla_nest_start_noflag(ans_skb,
				      NLBL_CIPSOV4_A_MLSCATLST);

and only fills it while iter < cat.local_size, so a category-less DOI is
reported back with an empty MLSCATLST that ADD would now reject.

Is the zero-size state actually unsafe?  Every category access looks
size-guarded, for example in cipso_v4_map_cat_rbm_valid():

	if (cat >= cipso_cat_size ||
	    cipso_array[cat] >= CIPSO_V4_INV_CAT)
		return -EFAULT;

and the same pattern for host_spot >= host_cat_size in _hton() and
net_spot >= net_cat_size in _ntoh().  If the sizes already bound all
accesses, would it be better to only guard the kcalloc() calls rather than
reject the request?

> @@ -680,10 +686,21 @@ static int netlbl_cipsov4_listall(struct sk_buff *skb,
>  static int netlbl_cipsov4_remove_cb(struct netlbl_dom_map *entry, void *arg)
>  {
>  	struct netlbl_domhsh_walk_arg *cb_arg = arg;
> +	struct netlbl_af4list *iter4;
> +	struct netlbl_domaddr4_map *map4;
>  
>  	if (entry->def.type == NETLBL_NLTYPE_CIPSOV4 &&
>  	    entry->def.cipso->doi == cb_arg->doi)
>  		return netlbl_domhsh_remove_entry(entry, cb_arg->audit_info);
> +	else if (entry->def.type == NETLBL_NLTYPE_ADDRSELECT) {
> +		netlbl_af4list_foreach_rcu(iter4, &entry->def.addrsel->list4) {
> +			map4 = netlbl_domhsh_addr4_entry(iter4);
> +			if (map4->def.type == NETLBL_NLTYPE_CIPSOV4 &&
> +			    map4->def.cipso->doi == cb_arg->doi)
> +				return netlbl_domhsh_remove_entry(entry,
> +							cb_arg->audit_info);
> +		}
> +	}
>  
>  	return 0;
>  }

[Severity: High]
Can this remove mappings unrelated to the DOI being deleted?

One match on a single address selector passes "entry" to
netlbl_domhsh_remove_entry(), which tears down the whole domain entry:

net/netlabel/netlabel_domainhash.c:netlbl_domhsh_remove_entry() {
	...
	case NETLBL_NLTYPE_ADDRSELECT:
		netlbl_af4list_foreach_rcu(iter4, &entry->def.addrsel->list4) {
			map4 = netlbl_domhsh_addr4_entry(iter4);
			cipso_v4_doi_putdef(map4->def.cipso);
		}
		netlbl_af6list_foreach_rcu(iter6, &entry->def.addrsel->list6) {
			map6 = netlbl_domhsh_addr6_entry(iter6);
			calipso_doi_putdef(map6->def.calipso);
		}
	...
	call_rcu(&entry->rcu, netlbl_domhsh_free_entry);
}

It also clears netlbl_domhsh_def_ipv4 / netlbl_domhsh_def_ipv6 when the
entry happens to be the default mapping.

A single ADDRSELECT entry can legitimately aggregate selectors with
different types and DOIs - netlbl_domhsh_validate() accepts per-selector
NETLBL_NLTYPE_UNLABELED and NETLBL_NLTYPE_CIPSOV4 in the same list4, and
netlbl_domhsh_add() merges later selectors into the existing entry without
requiring a shared DOI.  So does deleting DOI 1 on a domain that also maps
192.168.0.0/16 to CIPSO DOI 2 and 10.0.0.0/8 to unlbl silently drop those
other two mappings as well?

Would netlbl_domhsh_remove_af4() be the right granularity here?  It removes
a single selector and only drops the entry once the selector lists become
empty.

[Severity: High]
Can this callback ever be invoked for a default mapping?

netlbl_domhsh_add() stores entries with domain == NULL only in the standalone
RCU pointers:

net/netlabel/netlabel_domainhash.c:netlbl_domhsh_add() {
	...
	} else {
		INIT_LIST_HEAD(&entry->list);
		switch (entry->family) {
		case AF_INET:
			rcu_assign_pointer(netlbl_domhsh_def_ipv4,
					   entry);
	...
}

while netlbl_domhsh_walk() - the only iteration netlbl_cipsov4_remove() uses
- walks the hash buckets only:

net/netlabel/netlabel_domainhash.c:netlbl_domhsh_walk() {
	...
		iter_list = &rcu_dereference(netlbl_domhsh)->tbl[iter_bkt];
		list_for_each_entry_rcu(iter_entry, iter_list, list)
	...
}

For a configuration like "netlabelctl map add default address:192.168.1.0/24
protocol:cipsov4,1", removing DOI 1 would then never reach this new code,
map4->def.cipso keeps its reference, and cipso_v4_doi_remove() only does:

net/ipv4/cipso_ipv4.c:cipso_v4_doi_remove() {
	...
	list_del_rcu(&doi_def->list);
	spin_unlock(&cipso_v4_doi_list_lock);

	cipso_v4_doi_putdef(doi_def);
}

so the DOI object stays allocated and invisible to LIST while the default
mapping keeps labeling traffic with it.  Isn't that the exact case the
changelog describes as fixed:

>        entries so IPv4 address-selected domain mappings referencing a removed
>        CIPSOv4 DOI are properly cleaned up.

The same gap looks to apply to plain NETLBL_NLTYPE_CIPSOV4 default mappings
created through netlbl_cfg_cipsov4_map_add(doi, NULL, NULL, NULL, ...) from
smackfs.

[Severity: Medium]
This isn't a bug introduced by this patch, but the peer callback is now
asymmetric.  netlbl_calipso_remove_cb() still only matches top-level
entries:

net/netlabel/netlabel_calipso.c:netlbl_calipso_remove_cb() {
	if (entry->def.type == NETLBL_NLTYPE_CALIPSO &&
	    entry->def.calipso->doi == cb_arg->doi)
		return netlbl_domhsh_remove_entry(entry, cb_arg->audit_info);

	return 0;
}

netlbl_domhsh_remove_entry() shows ADDRSELECT entries hold per-selector
CALIPSO references via map6->def.calipso, so "netlabelctl map add domain:X
address:2001:db8::/32 protocol:calipso,5" followed by "netlabelctl calipso
del doi:5" leaves that list6 selector referencing the removed DOI - the same
class of leftover mapping this patch closes on the CIPSOv4 side.  Should the
CALIPSO callback get the matching list6 walk?

Thanks for looking into these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919215243.3472150-1-benquike%40gmail.com
