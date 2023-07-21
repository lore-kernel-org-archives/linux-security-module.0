Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C529DEB64DD
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jul 2023 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGURlT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGURlS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 13:41:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301730DF
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 10:41:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0f35579901so2084062276.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689961276; x=1690566076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0EsEuc6ZrLkBpjfXrbTj3wl8CGw2RCGPAyUMK4WwkjA=;
        b=DoHzE6IB/gTaLmkueM9yb30EUG6tzOb2A5AXrz9PQw1Ifq3ks790NG9A8kHnulrV92
         RNCrZzNkmPOc83fANNDf5nXf1wPVFL2y5FNAhz+fPjDVllxc5Oizeq9OoCoSO3jrCWPO
         Fdo3zuU1ITNzecPSKDNY0XL2xmTCfJibF/rCjlkemXFUh+Sr371B5TqkScdP+lHN0Bsv
         l8bJ71cW4eJgHOkXZEVFnapIkfHWHqvRivBGgXBk81wx3rhHxJzYdjltDTwHbRDPypPU
         FqCvfBjArc5TGgWA7G3s9Jm2aOIc06rnT78obfljmzEALSkpFg35cZZdMznfZTRdtzpx
         x88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961276; x=1690566076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EsEuc6ZrLkBpjfXrbTj3wl8CGw2RCGPAyUMK4WwkjA=;
        b=Sys4AwIHmQFwlGkbtmJJe+OVF9zKBmneGQDeJrAarCTV427TvJnMMHE4yHIzq3IiSm
         D5iJv6lsQoQ6jwqpP6BCdY+OZjnlmmKZ3Vu/sRLPHvywsXVks2t6ZMQ6Yf+tK9femYRY
         NTFdr8pkbeIj7uV85nmhR/4vsMQAg14ZnKgO9TWwMJGEy0rqKNQeMwYFxl58N75LqwV+
         IN8s4AWrxF9XQI1vf75FU3FHq20fWFjxPj8yVlzEbpqTRfTizV2/SyGluXtbWrSnaft3
         iA5VmYqyNfPA5tDngct1W1RKX33bJMq/qWm7/LxRZ92dkjm4gJmHxXlxGt86GlhMnuqw
         CfWg==
X-Gm-Message-State: ABy/qLZghA4cejb0j2IXEMkGIxm0NNOXFArwbGC0p9vpxFnjvbtAs/QC
        DGgMp5/yMD0psDQT0SEuTgNZb7BMb7c=
X-Google-Smtp-Source: APBJJlFxyzDv1jxbiR1ec3ea79Hb3YohAr96lgMadcKGyfL8Br8SJoCJpXRoXSNCjiu8EtZhgF/6XBpHBow=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4f41:0:b0:cb6:6c22:d0f8 with SMTP id
 d62-20020a254f41000000b00cb66c22d0f8mr17638ybb.4.1689961276130; Fri, 21 Jul
 2023 10:41:16 -0700 (PDT)
Date:   Fri, 21 Jul 2023 10:41:14 -0700
In-Reply-To: <6118063e-5c91-acc4-129f-3bacc19f25ce@redhat.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-10-seanjc@google.com>
 <6118063e-5c91-acc4-129f-3bacc19f25ce@redhat.com>
Message-ID: <ZLrDOljnluTrt+l+@google.com>
Subject: Re: [RFC PATCH v11 09/29] KVM: x86: Disallow hugepages when memory
 attributes are mixed
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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

On Fri, Jul 21, 2023, Paolo Bonzini wrote:
> On 7/19/23 01:44, Sean Christopherson wrote:
> > +static bool range_has_attrs(struct kvm *kvm, gfn_t start, gfn_t end,
> > +			    unsigned long attrs)
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
> 
> Can you move this function to virt/kvm/kvm_main.c?

Ah, yeah, that's a good idea.
