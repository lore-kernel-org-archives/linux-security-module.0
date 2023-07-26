Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E919C001E0
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jul 2023 19:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjGZT2R (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGZT2P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jul 2023 15:28:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D182D44
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jul 2023 12:28:13 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bba7a32a40so1027005ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jul 2023 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690399693; x=1691004493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JT2UHI+2Np7L7QsdeetNAkLhraffv5kgEdfCjKl11Yk=;
        b=VVF1b7RUawi3/QYYQt22u1jH5OUH1Tf8XnLnE4b/agwXthOwpe69728aWprc+cBAPp
         m1NzpejyJPFn+J7cEl/k4Xfw7NV/DNs921DAj4mD25qN63m2UV8rxLRjeMa24TJWqXH7
         YevHJEPTBXycw8cNMxRiQayY5davffRodPeaquNPMlG3yhTbW+l2TZNv0KoNxIAjUf1u
         vx7QnvYOOpb+Nn9iea9EFg+zAfgVPq5/2O4eLtzlraYz5aepPr1S1PEGRUkv/ClpXjx1
         oD0KN8QbT88DXT6sIsMyGXbNhhlwFsmmZRUM0BDYakuaZeCUCb/tpsShC/zQA5q7Janp
         MXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399693; x=1691004493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JT2UHI+2Np7L7QsdeetNAkLhraffv5kgEdfCjKl11Yk=;
        b=AC2RHPpgPPoDMqq5fMR1gnFv6nrkZ18nFWQGrLOGKPTntah/XcFTFd10YBema+SYwY
         eBsoQhGdaWgc7MzSM4Q7wJPIBURSP68zQ3doGML5yHx4DytcGOrwQNC6/VvHmGUpdgIV
         isd5yftcVlYj5v5ED3iJSq0HqNfj6Oui1b1lj1EYxctwOLYsblBCF5bLLroWVYUuq7Bb
         kPc5Vn8kSF+X4ZuekIu47eX4qIw5f8itGxY7P7wpRCR7odhKNtCQPE0MSPTseYquhGzZ
         csKZVqvYJ/ZlzpBYJJRYZh1G7aORw0xEfPQPMIEapm6JvSBiph/8GzOLCTsbuk7gJTo7
         nZag==
X-Gm-Message-State: ABy/qLbfUxHJG7wMZgGRYOvzyehwQbLeDhieUs1/pnSXU+Z9PiqyQlF5
        hro5c8hDQY5LtsrzLMtbBMHgr9ParHk=
X-Google-Smtp-Source: APBJJlGcmwLcdH6TXOymYc9nTB5UyZup+2YRvQp3iON5gHoKZStwU7nqu5mwxNJ6DvyQEbhf1ifDNjwDMJ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce8b:b0:1b8:2055:fc1f with SMTP id
 f11-20020a170902ce8b00b001b82055fc1fmr13036plg.2.1690399693010; Wed, 26 Jul
 2023 12:28:13 -0700 (PDT)
Date:   Wed, 26 Jul 2023 12:28:11 -0700
In-Reply-To: <8f7ea958-7caa-a185-10d2-900024aeddf0@quicinc.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-13-seanjc@google.com>
 <8f7ea958-7caa-a185-10d2-900024aeddf0@quicinc.com>
Message-ID: <ZMFzyy5mZVxLn4uo@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
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

On Wed, Jul 26, 2023, Elliot Berman wrote:
> 
> 
> On 7/18/2023 4:44 PM, Sean Christopherson wrote:
> > TODO
>  <snip>
> > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > index 6325d1d0e90f..15041aa7d9ae 100644
> > --- a/include/uapi/linux/magic.h
> > +++ b/include/uapi/linux/magic.h
> > @@ -101,5 +101,6 @@
> >   #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
> >   #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
> >   #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> > +#define GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */
> 
> 
> Should this be:
> 
> #define GUEST_MEMORY_KVM_MAGIC
> 
> or KVM_GUEST_MEMORY_KVM_MAGIC?
> 
> BALLOON_KVM_MAGIC is KVM-specific few lines above.

Ah, good point.  My preference would be either KVM_GUEST_MEMORY_MAGIC or
KVM_GUEST_MEMFD_MAGIC.  Though hopefully we don't actually need a dedicated
filesystem, I _think_ it's unnecessary if we don't try to support userspace
mounts.

> ---
> 
> Originally, I was planning to use the generic guest memfd infrastructure to
> support Gunyah hypervisor, however I see that's probably not going to be
> possible now that the guest memfd implementation is KVM-specific. I think
> this is good for both KVM and Gunyah as there will be some Gunyah specifics
> and some KVM specifics in each of implementation, as you mentioned in the
> previous series.

Yeah, that's where my headspace is at too.  Sharing the actual uAPI, and even
internal APIs to some extent, doesn't save all that much, e.g. wiring up an ioctl()
is the easy part.  Whereas I strongly suspect each hypervisor use case will want
different semantics for the uAPI.

> I'll go through series over next week or so and I'll try to find how much
> similar Gunyah guest mem fd implementation would be and we can see if it's
> better to pull whatever that ends up being into a common implementation?

That would be awesome!  

> We could also agree to have completely divergent fd implementations like we
> do for the UAPI. Thoughts?

I'd like to avoid _completely_ divergent implementations, e.g. the majority of
kvm_gmem_allocate() and __kvm_gmem_create() isn't KVM specific.  I think there
would be value in sharing the core allocation logic, even if the other details
are different.  Especially if we fully commit to not supporting migration or
swap, and decide to use xarray directly to manage folios instead of bouncing
through the filemap APIs.

Thanks!
