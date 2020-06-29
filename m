Return-Path: <SRS0=lc+5=AK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D84C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BC3206E2
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEJizO2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgF2TjF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbgF2Thn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FDC0307B5
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jun 2020 09:01:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so17074709wrw.5
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jun 2020 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5yWLAmrjP+HUE9xuw2mUWHUEAQL6o66O+XdJK9Xwzm0=;
        b=BEJizO2GxVqUFqQaVQ53DedgK+SmvRgtkazROcEAyi+qU9DZyMgtfuQXTUIqMcgA2J
         SzLrFz6+XuNM5oeI7mXOi0I4Z32kZM5iAZ399LbQh1+/w8spKIHvkv/iQXvv6N4KZ4Iw
         wqD+gsyVzZ2jEGO9PSc59JbNCQEMzfXkbg7Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5yWLAmrjP+HUE9xuw2mUWHUEAQL6o66O+XdJK9Xwzm0=;
        b=DtHW62VC2F1hXeoWIFP01CdX7PdDnOap2ArmBXmTHUV4J6btWAe8BpNAuo2nzYgmXg
         tzJw45C4tXwzgFva8YqUEBaGtVZN3qNbeMQxJuLPO9rmQV7Sb/Yq6ju07p4RTz+HLqJw
         PFLYHeGc2RQPOmE3q+TvzP2LNp6z7QDtUEzh7wleCn8WA6KJADs4i6sk4aU5dN0/N0yr
         C3g0oPsMWwhGZ5BtaFIMgovPMpwcFBHBmgOaYINJ0dV6/AjQ7HIa+ufh+PiVj7Fue1mn
         35VFCWxX5j5oc+xqNqnOpxz0cTt76Vtq7rTzCadThFggH6xeAc3DqiZoZERIbwm1luxE
         okDA==
X-Gm-Message-State: AOAM531qAQvf1XaLbJ3dwih7xUfTJGhw8ZAdFT2w/nxkF8sCwgRIzccK
        zWLw3daZR2CdVoQk+yp+3IiVdA==
X-Google-Smtp-Source: ABdhPJzCgc7NzKu0yVjVQT4tYYa6mOFm31PXB1QzHZcJG8Pbw4bv5l43oogdQqOAc4bA8wMDk4OgVg==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr17554602wrq.91.1593446463496;
        Mon, 29 Jun 2020 09:01:03 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id r3sm173899wrg.70.2020.06.29.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:01:02 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 29 Jun 2020 18:01:00 +0200
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Generalize bpf_sk_storage
Message-ID: <20200629160100.GA171259@google.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-2-kpsingh@chromium.org>
 <20200619064332.fycpxuegmmkbfe54@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619064332.fycpxuegmmkbfe54@kafai-mbp.dhcp.thefacebook.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for your feedback! Apologies it took some time for me
to incorporate this into another revision.

On 18-Jun 23:43, Martin KaFai Lau wrote:
> On Wed, Jun 17, 2020 at 10:29:38PM +0200, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > Refactor the functionality in bpf_sk_storage.c so that concept of
> > storage linked to kernel objects can be extended to other objects like
> > inode, task_struct etc.
> > 
> > bpf_sk_storage is updated to be bpf_local_storage with a union that
> > contains a pointer to the owner object. The type of the
> > bpf_local_storage can be determined using the newly added
> > bpf_local_storage_type enum.
> > 
> > Each new local storage will still be a separate map and provide its own
> > set of helpers. This allows for future object specific extensions and
> > still share a lot of the underlying implementation.
> Thanks for taking up this effort to refactor sk_local_storage.
> 
> I took a quick look.  I have some comments and would like to explore
> some thoughts.
> 
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -1,19 +1,22 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (c) 2019 Facebook  */
> > +#include "linux/bpf.h"
> > +#include "asm-generic/bug.h"
> > +#include "linux/err.h"
> "<" ">"
> 
> >  #include <linux/rculist.h>
> >  #include <linux/list.h>
> >  #include <linux/hash.h>
> >  #include <linux/types.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/bpf.h>
> > -#include <net/bpf_sk_storage.h>
> > +#include <linux/bpf_local_storage.h>
> >  #include <net/sock.h>
> >  #include <uapi/linux/sock_diag.h>
> >  #include <uapi/linux/btf.h>
> >  
> >  static atomic_t cache_idx;
> inode local storage and sk local storage probably need a separate
> cache_idx.  An improvement on picking cache_idx has just been
> landed also.

I see, thanks! I rebased and I now see that cache_idx is now a:

  static u64 cache_idx_usage_counts[BPF_STORAGE_CACHE_SIZE];

which tracks the free cache slots rather than using a single atomic
cache_idx. I guess all types of local storage can share this now
right?

> 
> [ ... ]
> 
> > +struct bpf_local_storage {
> > +	struct bpf_local_storage_data __rcu *cache[BPF_STORAGE_CACHE_SIZE];
> >  	return NULL;

[...]

> >  }
> >  
> > -/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
> > +static void __unlink_local_storage(struct bpf_local_storage *local_storage,
> > +				   bool uncharge_omem)
> Nit. indent is off.  There are a few more cases like this.

Thanks, will fix this. (note to self: don't trust the editor's
clang-format blindly).

> 
> > +{
> > +	struct sock *sk;
> > +
> > +	switch (local_storage->stype) {
> Does it need a new bpf_local_storage_type?  Is map_type as good?
> 
> Instead of adding any new member (e.g. stype) to
> "struct bpf_local_storage",  can the smap pointer be directly used
> here instead?
> 
> For example in __unlink_local_storage() here, it should
> have a hold to the selem which then has a hold to smap.

Good point, Updated to using the map->map_type.

> 
> > +	case BPF_LOCAL_STORAGE_SK:
> > +		sk = local_storage->sk;
> > +		if (uncharge_omem)
> > +			atomic_sub(sizeof(struct bpf_local_storage),
> > +				   &sk->sk_omem_alloc);
> > +
> > +		/* After this RCU_INIT, sk may be freed and cannot be used */
> > +		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
> > +		local_storage->sk = NULL;
> > +		break;
> > +	}
> Another thought on the stype switch cases.
> 
> Instead of having multiple switches on stype in bpf_local_storage.c which may
> not be scalable soon if we are planning to support a few more kernel objects,
> have you considered putting them into its own "ops".  May be a few new
> ops can be added to bpf_map_ops to do local storage unlink/update/alloc...etc.

Good idea, I was able to refactor this with the following ops:

        /* Functions called by bpf_local_storage maps */
	void (*map_local_storage_unlink)(struct bpf_local_storage *local_storage,
                                         bool uncharge_omem);
	struct bpf_local_storage_elem *(*map_selem_alloc)(
		struct bpf_local_storage_map *smap, void *owner, void *value,
		bool charge_omem);
	struct bpf_local_storage_data *(*map_local_storage_update)(
		void  *owner, struct bpf_map *map, void *value, u64 flags);
	int (*map_local_storage_alloc)(void *owner,
				       struct bpf_local_storage_map *smap,
				       struct bpf_local_storage_elem *elem);

Let me know if you have any particular thoughts/suggestions about
this.

> 
> > +}
> > +
> > +/* local_storage->lock must be held and selem->local_storage == local_storage.
> >   * The caller must ensure selem->smap is still valid to be
> >   * dereferenced for its smap->elem_size and smap->cache_idx.
> > + *
> > + * uncharge_omem is only relevant when:

[...]

> > +	/* bpf_local_storage_map is currently limited to CAP_SYS_ADMIN as
> >  	 * the map_alloc_check() side also does.
> >  	 */
> >  	if (!bpf_capable())
> > @@ -1025,10 +1127,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
> >  }
> >  EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
> Would it be cleaner to leave bpf_sk specific function, map_ops, and func_proto
> in net/core/bpf_sk_storage.c?

Sure, I can also keep the sk_clone code their as well for now.

> 
> There is a test in map_tests/sk_storage_map.c, in case you may not notice.

I will try to make it generic as a part of this series. If it takes
too much time, I will send a separate patch for testing
inode_storage_map and till then we have some assurance with
test_local_storage in test_progs.

- KP
