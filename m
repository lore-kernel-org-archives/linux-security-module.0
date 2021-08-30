Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824FC432BE
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965F860ED4
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 15:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhH3PcZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:32:25 -0400
Received: from mail.hallyn.com ([178.63.66.53]:50644 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237085AbhH3PcZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Aug 2021 11:32:25 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id E9C38774; Mon, 30 Aug 2021 10:31:29 -0500 (CDT)
Date:   Mon, 30 Aug 2021 10:31:29 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Implement file local storage
Message-ID: <20210830153129.GA30961@mail.hallyn.com>
References: <20210826133913.627361-1-memxor@gmail.com>
 <20210826133913.627361-2-memxor@gmail.com>
 <20210830042346.GA26321@mail.hallyn.com>
 <20210830051719.xfl4llkiarmvk4r2@apollo.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830051719.xfl4llkiarmvk4r2@apollo.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 30, 2021 at 10:47:19AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Mon, Aug 30, 2021 at 09:53:46AM IST, Serge E. Hallyn wrote:
> > On Thu, Aug 26, 2021 at 07:09:09PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > +static struct bpf_local_storage_data *
> > > +file_storage_lookup(struct file *file, struct bpf_map *map, bool cacheit_lockit)
> > > +{
> > > +	struct bpf_local_storage *file_storage;
> > > +	struct bpf_local_storage_map *smap;
> > > +	struct bpf_storage_blob *bsb;
> > > +
> > > +	bsb = bpf_file(file);
> > > +	if (!bsb)
> > > +		return NULL;
> > > +
> > > +	file_storage = rcu_dereference(bsb->storage);
> >
> > It's possible that I am (and the docs are) behind the times, or (very likely)
> > I'm missing something else, but Documentation/RCU/whatisRCU.rst says that
> > rcu_dereference result is only valid within a rcu read-side critical section.
> >
> > Here it doesn't seem like you're in a rcu_read_unlock at all.  Will the
> > callers (bpf_map_ops->map_lookup_elem) be called that way?
> >
> 
> This function will either be called from the BPF program, which is run under RCU
> protection, or from bpf_map_* bpf command, which also has rcu_read_lock
> protection (see map_copy_value, bpf_map_update_value in kernel/bpf/syscall.c
> called from map_lookup_elem, map_update_elem) when calling the map_ops.

Thanks.  That was my guess, but wanted to make sure.

(I've made a note to study map_copy_value and bpf_map_update_value, thanks)

> > > +	if (!file_storage)
> > > +		return NULL;
> > > +
> > > +	smap = (struct bpf_local_storage_map *)map;
> > > +	return bpf_local_storage_lookup(file_storage, smap, cacheit_lockit);
> > > +}
> > > +
> > > +void bpf_file_storage_free(struct file *file)
> > > +{
> > > +	struct bpf_local_storage *local_storage;
> > > +	struct bpf_local_storage_elem *selem;
> > > +	bool free_file_storage = false;
> > > +	struct bpf_storage_blob *bsb;
> > > +	struct hlist_node *n;
> > > +
> > > +	bsb = bpf_file(file);
> > > +	if (!bsb)
> > > +		return;
> > > +
> > > +	rcu_read_lock();
> > > +
> > > +	local_storage = rcu_dereference(bsb->storage);
> >
> > Here you've called rcu_read_lock, but you use the result of it,
> > 'local_storage', after dropping the rcu_read_unlock, which whatisRCU.rst
> > explicitly calls out as a bug.
> >
> 
> It is only used without rcu_read_lock protection in one place, in the branch
> that depends on 'free_file_storage', at which point we are responsible for
> freeing the local_storage after unlinking the last storage element from its
> list and resetting the owner.

Makes sense.  Both of these seem worth a brief comment in the code,
but I'll leave it to you in case you think it's so obvious it'll
just be needless clutter.

-serge
