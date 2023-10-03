Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2A5E75455
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Oct 2023 12:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjJCMsG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Oct 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjJCMsF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Oct 2023 08:48:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857FDB4
        for <linux-security-module@vger.kernel.org>; Tue,  3 Oct 2023 05:48:01 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65b0dad1f98so5928416d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Oct 2023 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696337280; x=1696942080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YZe9z/CDJkweGhxZy3F+7e7AP42NZQg1sBDsRc6xWLw=;
        b=PeRLYOLioqfPAPyhLsjGm3+fHcCyHikDzkDViI+Rdq+SbLRi/yze7XyjZc95a9uN77
         YN1HbMAWxHWMPoaRL/GFvagOUIEwUEnzRv4S5RQz58PqcXShypPksshtOxnOrvWvg7Hm
         CGTEyB8jpw0NY7dr73p/avmPyGHDFZUYbkEpedVaCnjjHCEDBx1eFwQ8e2sY0mdjwo7F
         79Yurn8rvgb5bJ3PKQZcoxXinziOy/LH57awDKyc+1b8frx7JawX1I+o69MF7b2wMnMq
         nGeYnpY2hu3JsSONOtmhe1lfZjsgb2r6R3LQrwLjUxC0GR1RutNB+cpWLdbYmGVE+al0
         A0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337280; x=1696942080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZe9z/CDJkweGhxZy3F+7e7AP42NZQg1sBDsRc6xWLw=;
        b=ggUfyyeAVzQ2LOTzmKOr8U5Q2DOTmGxSaK1TsbilD8i2KNbzSbfoPyPSBMfuAmBeTx
         Weqj+oe8BoPAWhw2xcA7MPs/VwAOMgEgqx6uTGE8Gjv1fFbe3LH6gGAhSlrCAzKrkeY0
         fTAQH5QE3p3AwZlUL+BMu5g/uwvUqCqAaqnAZ04fUWNzlSZx1cJKC21LklfbX+1XK7vN
         yBhjlcbkCGo2mVTVNKow1YVLowTYRq+qVgG++C4GY/ftZOIn14ipGKcDSwz9BEFw/IUO
         59v3pH7zK20yjd5D3vO1CuR2TgRgUjLcCMoQsTROO8jaZIdQ0UrEKTdSOtdlV5xY9kAa
         kxWA==
X-Gm-Message-State: AOJu0YwX1TGEe/4uboJZuli0ZlA+3zAZKxN4+JBL8GlP78xBJ37IiOg2
        2eqCNj5xeUxtfCOmZsdfxOEH1o2khAZqXfIb9EbP5A==
X-Google-Smtp-Source: AGHT+IGdg5KfMiaxwpI9vdrZwCI62gGbA1qcJqHvAfDGqDxEQ2JSHryTMBO/72MMo9L0zK8WyPrlSIxRkNMNwCJdjzY=
X-Received: by 2002:a0c:e493:0:b0:656:347b:ea75 with SMTP id
 n19-20020a0ce493000000b00656347bea75mr13564335qvl.24.1696337280208; Tue, 03
 Oct 2023 05:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
In-Reply-To: <20230914015531.1419405-12-seanjc@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 3 Oct 2023 13:47:23 +0100
Message-ID: <CA+EHjTzSUXx8P9gWmUERg4owxH6r6yNPm1_RL-BzS_2CNPtRKw@mail.gmail.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
To:     Sean Christopherson <seanjc@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index d2d913acf0df..f8642ff2eb9d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1227,6 +1227,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
>  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
>  #define KVM_CAP_USER_MEMORY2 230
> +#define KVM_CAP_MEMORY_ATTRIBUTES 231
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> @@ -2293,4 +2294,17 @@ struct kvm_s390_zpci_op {
>  /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
>  #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
>
> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
> +#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd3, struct kvm_memory_attributes)
> +
> +struct kvm_memory_attributes {
> +       __u64 address;
> +       __u64 size;
> +       __u64 attributes;
> +       __u64 flags;
> +};
> +
> +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +

In pKVM, we don't want to allow setting (or clearing) of
PRIVATE/SHARED attributes from userspace. However, we'd like to use
the attributes xarray to track the sharing state of guest pages at the
host kernel.

Moreover, we'd rather the default guest page state be PRIVATE, and
only specify which pages are shared. All pKVM guest pages start off as
private, and the majority will remain so.

I'm not sure if this is the best way to do this: One idea would be to
move the definition of KVM_MEMORY_ATTRIBUTE_PRIVATE to
arch/*/include/asm/kvm_host.h, which is where
kvm_arch_supported_attributes() lives as well. This would allow
different architectures to specify their own attributes (i.e., instead
we'd have a KVM_MEMORY_ATTRIBUTE_SHARED for pKVM). This wouldn't help
in terms of preventing userspace from clearing attributes (i.e.,
setting a 0 attribute) though.

The other thing, which we need for pKVM anyway, is to make
kvm_vm_set_mem_attributes() global, so that it can be called from
outside of kvm_main.c (already have a local patch for this that
declares it in kvm_host.h), and not gate this function by
KVM_GENERIC_MEMORY_ATTRIBUTES. This would let pKVM select only
KVM_PRIVATE_MEM (as opposed to KVM_GENERIC_PRIVATE_MEM, which selects
KVM_GENERIC_MEMORY_ATTRIBUTES), preventing userspace from setting
these attributes, while allowing pKVM to call
kvm_vm_set_mem_attributes().

What do you think?

Thanks,
/fuad
