Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603CEB64DA
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Jul 2023 14:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjGSOPQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSOPO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Jul 2023 10:15:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63C1719
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jul 2023 07:15:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55ac8fcc887so3438574a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jul 2023 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689776112; x=1692368112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpT1srfgRytmcGt7uikxVNkA3BifxPUMvb756SCoWfo=;
        b=j6O4A4Kn8RrMiTsmWugcLoaBmDhdEOi6nm13D61dQWbrv/4yDEEVo/KZUz/JqdfsPo
         ZnKg9K95Lj7ZE2/dyLjlrZe55VZWZdtTVn9fgyfdtCrw5ElGnLLq/Qm5V23hi657OpUr
         Ebqn7DpgmWmZ6MQquOf5BjnPEIp0JeTMJYNB26HnYKqlFJQ9PECoKhiIFC6MpAGppjwD
         QEmzIJjuF0aS8nAXfMaVCs/HL9rulvVWCoWXejxaQyjwn7Vpfe71Kirx4tiYJoYvfJy1
         s3tsizGDD9BtrGq0rYlfmNI7dH4xGaeqfoCnPAOEbyXtpSJtpl3/bu64M8d1b+aFanZ/
         4psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776112; x=1692368112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpT1srfgRytmcGt7uikxVNkA3BifxPUMvb756SCoWfo=;
        b=cVuQbXewtXiN2hzucylNXRxd999aGobcJ0uQCSwgruhVBGNKDlrHdr7dK/qAt0cAOM
         extsLcHzIcwL/qQfeSS2I5J+V23xxotXRnDiqI6xtIEbKXti9Nxsvm31EGPIEDWukW4G
         aPwgMYYTulsoRtDOF3u1D1H8tkZmajsHZIRRQrEE+LiEEEPwjQdodT/2olNQU5NBDbvO
         10mShwL3Z0Lmqd6YCY42Xd9lBaCEF0iNn3lyMWYl7LXc1lT8Of7kk4Bzjmu0+KbVZjmb
         /TO+WC1aJIMHcsJ27yyAR0IgIifSwUSie/S+hseXX3QM/7j1wXriWYJjGMJatk0RZGjn
         whyQ==
X-Gm-Message-State: ABy/qLYmmbVjKHi9xBfXlIJgeEEuqbx9X254lptEPBJQ5rwcetovw+Yr
        5Re/KwBZuRLHtlTnjPy/+r79intvDPg=
X-Google-Smtp-Source: APBJJlG/y4qA2BEDL4k7hIJJKli+sdbNpvQf/prgfQp/iya4mlyKn4vdU0WvDm35KgLLUXfLwfwgiDZvoZw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e812:b0:1ae:6895:cb96 with SMTP id
 u18-20020a170902e81200b001ae6895cb96mr14210plg.5.1689776111918; Wed, 19 Jul
 2023 07:15:11 -0700 (PDT)
Date:   Wed, 19 Jul 2023 07:15:09 -0700
In-Reply-To: <20230719073115.vuedo2cf3mp27xm4@yy-desk-7060>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-6-seanjc@google.com>
 <20230719073115.vuedo2cf3mp27xm4@yy-desk-7060>
Message-ID: <ZLfv7aRq5W52ezek@google.com>
Subject: Re: [RFC PATCH v11 05/29] KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to CONFIG_KVM_GENERIC_MMU_NOTIFIER
From:   Sean Christopherson <seanjc@google.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
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

On Wed, Jul 19, 2023, Yuan Yao wrote:
> On Tue, Jul 18, 2023 at 04:44:48PM -0700, Sean Christopherson wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 90a0be261a5c..d2d3e083ec7f 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -255,7 +255,9 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
> >  #endif
> >
> > -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> > +struct kvm_gfn_range;
> 
> Not sure why a declaration here, it's defined for ARCHs which defined
> KVM_ARCH_WANT_MMU_NOTIFIER before.

The forward declaration exists to handle cases where CONFIG_KVM=n, specifically
arch/powerpc/include/asm/kvm_ppc.h's declaration of hooks to forward calls to
uarch modules:

	bool (*unmap_gfn_range)(struct kvm *kvm, struct kvm_gfn_range *range);
	bool (*age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
	bool (*test_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
	bool (*set_spte_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);

Prior to using a Kconfig, a forward declaration wasn't necessary because
arch/powerpc/include/asm/kvm_host.h would #define KVM_ARCH_WANT_MMU_NOTIFIER even
if CONFIG_KVM=n.

Alternatively, kvm_ppc.h could declare the struct.  I went this route mainly to
avoid the possibility of someone encountering the same problem on a different
architecture.
