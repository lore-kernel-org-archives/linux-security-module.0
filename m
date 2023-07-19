Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25434C001B0
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Jul 2023 15:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGSPjY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjGSPjX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Jul 2023 11:39:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F091BE4
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jul 2023 08:39:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ceabb7e8afdso1694943276.3
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jul 2023 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689781150; x=1692373150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uTGEOgXGgjS1mpy4uY8Zn88ggwsAyaWY3/MU5WFUXU=;
        b=zuZWZV29hv7HoMETiCkSKGIHZcpHTMG8TKF9qduMPPS/E1c0SfFLVA6kGEOoP5U9qq
         U77CuEsLMMxKIxLMFnjtp2hpB+IIMkYXVFGsPC5bapP3nIk/nGTrjqlCGcZf5+xPpr8T
         q16/aDqhEkgnoKMdGaA5rz+Gt+5uK6D6P1fr5Zm7R4i7YF7l973NWOrr+c3kq7IzyS9M
         gLZmugAwtecTQMKF7z0UBcPf86RbNReN6ZSKfaBS2Zp8N7kJnMwhsDMUzBHIndlxccW1
         lnFRHUcOrryTZsXwruMmKL2jJUIvic1/Jzr/kaZBJYZOlvirf0tEwgFNXnc0yrJBGF6s
         gFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781150; x=1692373150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uTGEOgXGgjS1mpy4uY8Zn88ggwsAyaWY3/MU5WFUXU=;
        b=GfAJgpdE5pE+4/UooVVmwiX1tqo2LmoO4NHJzJQLqgn9ME/0kvITtFSNxt4broVYdn
         aqf3h+zy/lFFFUzQJweQXkpbskNQ/2W3riJRB9LF5sOlOMccuDlo/MgyXDdfjlYrgEkP
         X82yYv/pffsm8xHRvn4cyx04u6L6eVg4J3iGxm1YfOvSeLIt9nW8+FCCX7OboRL/cItp
         m3dpjvSQTCtCAAC/cEY2vnv9F1kNWPjoQM+Ac5NMqvHpxupDlH7cmlf2ynroos7kKIQs
         D7NeS9/a90uPlgPr8SWGfSD64dwBuYOyd4KF+yMhSZaJy1QbZYdEBTbsR5YEdRAzu0HA
         c9Dg==
X-Gm-Message-State: ABy/qLYgdpsy/UgxVI50JnA1D+ucQGBerZc/3k1n34QULqzCel+IoXcX
        9mf4a0P4pHrvNB3MLynTQLOAyrElBws=
X-Google-Smtp-Source: APBJJlHKX/op8BIXr6hrdN4x6RovTyUJBoPmA+F//tB9wdB4uZjaG/yxyF0KPogxnGD6eEZAy2DX7qXfLUE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:868b:0:b0:c4d:9831:9712 with SMTP id
 z11-20020a25868b000000b00c4d98319712mr26898ybk.0.1689781150625; Wed, 19 Jul
 2023 08:39:10 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:39:09 -0700
In-Reply-To: <CU66VMG4IKSD.33KF2CEZJ2I1@suppilovahvero>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-2-seanjc@google.com>
 <CU66VMG4IKSD.33KF2CEZJ2I1@suppilovahvero>
Message-ID: <ZLgDnYJUX/QR9UJi@google.com>
Subject: Re: [RFC PATCH v11 01/29] KVM: Wrap kvm_gfn_range.pte in a per-action union
From:   Sean Christopherson <seanjc@google.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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

On Wed, Jul 19, 2023, Jarkko Sakkinen wrote:
> On Wed Jul 19, 2023 at 2:44 AM EEST, Sean Christopherson wrote:
> >  	/* Huge pages aren't expected to be modified without first being zapped. */
> > -	WARN_ON(pte_huge(range->pte) || range->start + 1 != range->end);
> > +	WARN_ON(pte_huge(range->arg.pte) || range->start + 1 != range->end);
> 
> Not familiar with this code. Just checking whether whether instead
> pr_{warn,err}()

The "full" WARN is desirable, this is effecitvely an assert on the contract between
the primary MMU, generic KVM code, and x86's TDP MMU.  The .change_pte() mmu_notifier
callback doesn't allow for hugepages, i.e. it's a (likely fatal) kernel bug if a
hugepage is encountered at this point.  Ditto for the "start + 1 == end" check,
if that fails then generic KVM likely has a fatal bug.

> combined with return false would be a more graceful option?

The return value communicates whether or not a TLB flush is needed, not whether
or not the operation was successful, i.e. there is no way to cancel the unexpected
PTE change.
