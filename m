Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4FDC04A6A
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Aug 2023 21:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjHNVzU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Aug 2023 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjHNVzH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Aug 2023 17:55:07 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC571BC1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 14:54:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c964d031aso8936772a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692050074; x=1692654874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLV8cwl+q0+MgeCaKnjEbSXBm+ijn/cuT9eg2QvMQy8=;
        b=WyQ6Tn/5h37xMsEIDmbWcY+nQiTqqFoftlXVBTiztMb2A7vinkou0FyJxT5Tj+pa31
         3y4mktmY47itqZcGsKCOeUubQi9MQwPyYS/ntrx9oV/jIdUAoZkwRuGY0yw403B+hUV5
         PyUzYrySs29/O30p+yDsELGRzby+1aqFcxoBBJ6omQFPygNitIVTJAp2Hnd4R0/QcY2H
         EgizfgVBfhm/BlB4owWFjSnqlPuhKRjVS+MvDjPpwOsN8USa7haRJjhrCn+/9m5M/b9b
         HnVauoeuLnwYhNy2SBnjlv/xkJdMMlVKqHESswng1uUarqPNC4oB5B1VogZQC9cpA3Kv
         gLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692050074; x=1692654874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLV8cwl+q0+MgeCaKnjEbSXBm+ijn/cuT9eg2QvMQy8=;
        b=gjISbstOCzZ33Bf6SCi9ill9NE/EIUhwHD4rhNj8hCdQk1MUFuFv6x2JsaC1uMdqcr
         YlqyCB6ny/R+zYHzWpe26qcGukL1S2/68fuZse4tVFshcZnnb/GfxuoWTjm6Oug62EYE
         VdlsT0HcCCOdgDhzRcNWbp9ep32M6XhLud5I0PSvX/yJ8JYgteMx/vsoYSaF5AxyiD51
         iATXmW3qHyFFF6w4t3DtYZIasYVXJiCkA5Iu5Re4b1u89LW+tpC361FvJvdzdOAOVtZc
         BNr+jKuWiCQ6J1/3R5opJubQMogomAiqvnH68X6HVRVf99e4LqRZw1yZQ9q0XpMhspXS
         BRZA==
X-Gm-Message-State: AOJu0Yza/OINZBmLq4kui7YNjD7pyWg15NpUDkWjDcUqtKvH3Fbv0bvI
        rvGeWXlbS0nB8NaOSZg6cjeh4XOsQ20=
X-Google-Smtp-Source: AGHT+IGPzyG2ye2a1feyqcG86dyCHC82qzx5i2/p6ALHRmr0rfFoFMM8MlFz9jxGz9wjwtqC3ppaRbddXVE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:9f12:0:b0:565:3355:87b0 with SMTP id
 g18-20020a639f12000000b00565335587b0mr2044577pge.5.1692050074189; Mon, 14 Aug
 2023 14:54:34 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:54:32 -0700
In-Reply-To: <02239d95-0253-a223-28c2-016cca3ab4d2@linux.intel.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-9-seanjc@google.com>
 <02239d95-0253-a223-28c2-016cca3ab4d2@linux.intel.com>
Message-ID: <ZNqimGhCD+70q/lG@google.com>
Subject: Re: [RFC PATCH v11 08/29] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
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

On Mon, Aug 14, 2023, Binbin Wu wrote:
> 
> On 7/19/2023 7:44 AM, Sean Christopherson wrote:
> > +	struct kvm_mmu_notifier_range post_set_range = {
> > +		.start = start,
> > +		.end = end,
> > +		.arg.attributes = attributes,
> > +		.handler = kvm_arch_post_set_memory_attributes,
> > +		.on_lock = (void *)kvm_null_fn,
> > +		.on_unlock = kvm_mmu_invalidate_end,
> > +		.may_block = true,
> > +	};
> > +	unsigned long i;
> > +	void *entry;
> > +	int r;
> > +
> > +	entry = attributes ? xa_mk_value(attributes) : NULL;
> Why attributes of value 0 is considered not a value? Is it because 0 is not
> a valid value when RWX is considered in the future?

0 values don't require an entry in the xarray, i.e. don't need to be stored and
so don't consume memory.  The potential conflict with a RWX=0 entry has already
been noted, but we'll cross that bridge when we get to it, e.g. KVM can easily
support RWX=0 by using an internal "valid" flag.

> Both the changelog and the document added mention that the address and size
> of attrs will be updated to
> "reflect the actual pages of the memory range have been successfully set to
> the attributes", but it doesn't.

Yeah, on the todo list, all of the changelogs are horribly stale.
