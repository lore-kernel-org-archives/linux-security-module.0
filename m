Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571F5C05024
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Sep 2023 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjITVAb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Sep 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjITVAb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Sep 2023 17:00:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0AFC2
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 14:00:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d818fb959f4so432143276.1
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695243624; x=1695848424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WD85YU6GCdPtOsLZeVlIeZZfzAYdtoOH/7wu6gyWXNI=;
        b=lrXR4KDKyB3CuUyGP5uNfXTfoHTjrrZkUVpu9kQNuYv9InUBqUeB4fMdB30349PPIZ
         RcGYV8CUadyrYi4ihZfTHpQg/09qpPl+c/zYxq0o2P7dwkfgXkXcp+bq3MVEF+9duUBe
         HTtCh9+ypTXfAcyFaAzJk68f4w++iv6tmGozumlieWuG+llNlw0IlHzHC0WhvmQeQ47D
         BIPb11gg7udeYiklPqgWMrsDyd383pwOvV8mQ+zScwuU8lJXO0Vahq5kKfJ4f6dThPzb
         EXaItMpjNVLeAY+6Kq+gMt7n0juNGBqQvhqE4dZEpjqEgFDXknQSWJecxRAUASzTRNFm
         LQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695243624; x=1695848424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD85YU6GCdPtOsLZeVlIeZZfzAYdtoOH/7wu6gyWXNI=;
        b=aYnhnKXp+oZbvcYq01/E/Yb9iaCiYpO68lrc8y51oKKm3NQeAeAys8U/gwYK/+fnSA
         gKCAmuhbqxhKqp3EIaGq38z3ROeyeSb2EppDptTszsDABhFtckkdScWI7WH4EkmDr9bs
         kwotEH4mFhST3jfcYyv1yEGRWC/m+X8iyOEXFZjBrI9bMvK53mOt3mSAhYy0pezRBJVb
         BJGSYQ2PRVZi0AeqYoihuhZO2UnK+4k1bRue6uAkP+kQ4AvX+VLe4Jaq+hMAS/Jtl/fc
         MH0ivz+9lm/TjrdEg+PQU6KxMHm7/pGjU+Vq2Z8PfhGhlVaUghAxuy+VurRSe82mwNZ6
         a6ag==
X-Gm-Message-State: AOJu0Yw9jSOH2zKFC0brVD0XrQsWhOQixiA4FamIhb8mO+1hOduIWhOc
        PGe0OMjRcIQJa3oGS7LGXmYOwXBekPc=
X-Google-Smtp-Source: AGHT+IE6bowhyf6hyHthYBPyW6IZfmwFxVZA3ErkF6QZibGvin1ESoG81Vf7MPhR8G5wDRxCxsmQT8EV7w4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:496:0:b0:d7f:2cb6:7d88 with SMTP id
 144-20020a250496000000b00d7f2cb67d88mr58003ybe.13.1695243624102; Wed, 20 Sep
 2023 14:00:24 -0700 (PDT)
Date:   Wed, 20 Sep 2023 14:00:22 -0700
In-Reply-To: <ZQP6ZqXH81V24Lj/@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <ZQP6ZqXH81V24Lj/@yzhao56-desk.sh.intel.com>
Message-ID: <ZQtdZmJ3SekURjiQ@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 15, 2023, Yan Zhao wrote:
> On Wed, Sep 13, 2023 at 06:55:09PM -0700, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> > 
> > In confidential computing usages, whether a page is private or shared is
> > necessary information for KVM to perform operations like page fault
> > handling, page zapping etc. There are other potential use cases for
> > per-page memory attributes, e.g. to make memory read-only (or no-exec,
> > or exec-only, etc.) without having to modify memslots.
> > 
> ...
> >> +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > +				     unsigned long attrs)
> > +{
> > +	XA_STATE(xas, &kvm->mem_attr_array, start);
> > +	unsigned long index;
> > +	bool has_attrs;
> > +	void *entry;
> > +
> > +	rcu_read_lock();
> > +
> > +	if (!attrs) {
> > +		has_attrs = !xas_find(&xas, end);
> > +		goto out;
> > +	}
> > +
> > +	has_attrs = true;
> > +	for (index = start; index < end; index++) {
> > +		do {
> > +			entry = xas_next(&xas);
> > +		} while (xas_retry(&xas, entry));
> > +
> > +		if (xas.xa_index != index || xa_to_value(entry) != attrs) {
> Should "xa_to_value(entry) != attrs" be "!(xa_to_value(entry) & attrs)" ?

No, the exact comparsion is deliberate.  The intent of the API is to determine
if the entire range already has the desired attributes, not if there is overlap
between the two.

E.g. if/when RWX attributes are supported, the exact comparison is needed to
handle a RW => R conversion.

> > +			has_attrs = false;
> > +			break;
> > +		}
> > +	}
> > +
> > +out:
> > +	rcu_read_unlock();
> > +	return has_attrs;
> > +}
> > +
> ...
> > +/* Set @attributes for the gfn range [@start, @end). */
> > +static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > +				     unsigned long attributes)
> > +{
> > +	struct kvm_mmu_notifier_range pre_set_range = {
> > +		.start = start,
> > +		.end = end,
> > +		.handler = kvm_arch_pre_set_memory_attributes,
> > +		.on_lock = kvm_mmu_invalidate_begin,
> > +		.flush_on_ret = true,
> > +		.may_block = true,
> > +	};
> > +	struct kvm_mmu_notifier_range post_set_range = {
> > +		.start = start,
> > +		.end = end,
> > +		.arg.attributes = attributes,
> > +		.handler = kvm_arch_post_set_memory_attributes,
> > +		.on_lock = kvm_mmu_invalidate_end,
> > +		.may_block = true,
> > +	};
> > +	unsigned long i;
> > +	void *entry;
> > +	int r = 0;
> > +
> > +	entry = attributes ? xa_mk_value(attributes) : NULL;
> Also here, do we need to get existing attributes of a GFN first ?

No?  @entry is the new value that will be set for all entries.  This line doesn't
touch the xarray in any way.  Maybe I'm just not understanding your question.
