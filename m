Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F354FC2FC03
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Sep 2023 21:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjITVD7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Sep 2023 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjITVD5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Sep 2023 17:03:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E6C2
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 14:03:51 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c577fea3dcso1840545ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695243830; x=1695848630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFTXI1M20f8gmG6BvRAdcxEpoXePrbyr+CokqbvWBWc=;
        b=YBB92SBCF7Hff5sSHvPsWLZsVpMrv+Nl0UIbQv7rB4s5KbvjkoryE7ANGFhAl3ZUOY
         XOz5HSz1JykM+i1Yb2lu7wu5YhqpmGp0qiwqGjag6g21TIuaOTtBANkCbe2wlhf62FxN
         1lak6BOZ+i864pP48UrkEPAxbstc16yg2iUAL3kqaQojWszOZsLaQGyqW7Q17wFRA5pS
         YukXT15ZjEfn2V/sRN4udANdKQS7bHzeb1rCtJKrCEAXpTbsKVowFQcM2dYmMaK7zbY1
         ARgNAbrAoaznbzr/fpH9ZnScVlSvAGQdDwVENeAYFHe1suNMj9gpIDcA1dEq4I4cKDvO
         t3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695243830; x=1695848630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFTXI1M20f8gmG6BvRAdcxEpoXePrbyr+CokqbvWBWc=;
        b=IhhF5QmVlw/l6/pKjFDrwMmOsP2BBFX8DXob8B9CPZ5a2TnmC7vF8zSDGcHrZPZfiG
         5qbTbgnSyCO5tK3ZP8uxEbaqtlNKntY4RgdOkxcHcwxot7G8/COimOyOkwJlDR9RblJI
         J/e2JADUv/X0QO9jDfZlEvwN90CKm89lZzsP5LM+g+QbiGtXOetfdRbnWbBRY0s0AEe8
         BJp9GGDBZkwettF2xTBRJFRTFkQi8C3xhwPR0GZmqxNNzh0OYssFJ1rh+qN6jPtLCxsu
         Dh1IHKvm1c5MIKE2GkJzUw5urzJm0ckaFK+Njs8MsBHsaLK2iMKbQyKBIJOtuEq2R6zK
         EvwQ==
X-Gm-Message-State: AOJu0Yzs39QlEebN2VyaHKf9Gj3UaDlM1PAqtuGqFv7EuWAvVfb2K8Ml
        fx/fm81kNnHVI9p5Q7tz1vs0k2q3ivE=
X-Google-Smtp-Source: AGHT+IH5QBEwnaGAG6ouJVZQG2FiwG4z7ywKiDhgLSOOF+0VMXfLus6G3HR8pg7XpQjZrIgu3wnPZ1Tf/l8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c407:b0:1c3:411c:9b7c with SMTP id
 k7-20020a170902c40700b001c3411c9b7cmr51568plk.13.1695243830643; Wed, 20 Sep
 2023 14:03:50 -0700 (PDT)
Date:   Wed, 20 Sep 2023 14:03:49 -0700
In-Reply-To: <d66795f8-e524-2912-4b71-92ca4ffe8807@linux.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <d66795f8-e524-2912-4b71-92ca4ffe8807@linux.intel.com>
Message-ID: <ZQteNbPfx6P3r6B8@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        "Serge E. Hallyn" <serge@hallyn.com>,
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

On Mon, Sep 18, 2023, Binbin Wu wrote:
> 
> 
> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> [...]
> > +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> > +/*
> > + * Returns true if _all_ gfns in the range [@start, @end) have attributes
> > + * matching @attrs.
> > + */
> > +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
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
> IIUIC, xas_find() is inclusive for "end", so here should be "end - 1" ?

Yes, that does appear to be the case.  Inclusive vs. exclusive on gfn ranges has
is the bane of my existence.
