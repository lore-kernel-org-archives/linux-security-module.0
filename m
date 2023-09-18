Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB17CD37B0
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Sep 2023 16:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjIRQSa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjIRQSS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 12:18:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F549F6
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 09:09:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bfccec7f3so49343197b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695053392; x=1695658192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s17YssV/eLMk3v6BQw21PztJLVQ1uDSUDnGyHA0nJic=;
        b=qX+BtdOnVRHNQXTUm2TRlG4JWP9Ko3PcF6I9U2bIP0SD1mERSxOG6nVDmmoVV79+Kn
         EhesEMZmOkyH0JgbFtFQt0ltV/RjMipelXNSDklRdEUX3y+C5Y/tMR3+J7eqq0QscCS3
         a/Hm1dWP1IMYx3FSxL5vctPaFIs1mgtHhg7ppBsOgCil2EBnFS2L2U/tHpNx+LpKxdId
         /AsZK5ehsVJ/26dX9ATP9iJcksIzHNockou5OtEeo8vWbboCpcjdpcwq16eG87GyMO0C
         OokEGWoD0UXvyx0KcMzb+823CkZ2BOxISdz7WJ8Pa1HYOcNCDRWMNObb8IT3M0Nr9piV
         snFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053392; x=1695658192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s17YssV/eLMk3v6BQw21PztJLVQ1uDSUDnGyHA0nJic=;
        b=I7v2fyGcvyTsdaDixXbAeNCSasBa2GITeyzkeYeLvoAx8f8afAmwZ8nBLBNk6H8eLI
         dd/CbmKfFd93D/vuvvLqb5NPo9L1/Qe1Sf1apKmiHdcIhw8aMr5WkaUgEyKUte0DEXqu
         jplreNlUJaV8RsEkq6eGAzryzjlvXdgMniLEEBpc5Q7Bllef+/eyZE/MlW36G9CBCZ6H
         vVucC0YrQ5nMMPKpFfM2CcU8UhW2x0JiGdF27QcUWQdhRmbQzC7hIDjx4wmOJGthzgu7
         +f1VEuCkbJQ/kzKhYBxa79FeTSI9SXFGWZ4sfY0rBt38QeoYWOt1jwwj+MIWhNwCPsXP
         DgPg==
X-Gm-Message-State: AOJu0YyimyhdY9ixkOQuQFk280DrIFjf2C7pOrQjuC5+eIb2VWBdkaVD
        +dRrjau/yRUvSZc+SWuArgJCtM8Dfr8=
X-Google-Smtp-Source: AGHT+IFqXVMaW5EWUR3sn7RRHAULv1S9Ax+JzluU+Y462jgw29bgpZAEkbL739S68Hx7QOlYkiFqSLcGAUw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4cf:b0:d7f:f3e:74ab with SMTP id
 v15-20020a05690204cf00b00d7f0f3e74abmr227961ybs.1.1695052667494; Mon, 18 Sep
 2023 08:57:47 -0700 (PDT)
Date:   Mon, 18 Sep 2023 08:57:45 -0700
In-Reply-To: <9925e01b-7fa9-95e4-dc21-1d760ef9cde4@linux.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-11-seanjc@google.com>
 <9925e01b-7fa9-95e4-dc21-1d760ef9cde4@linux.intel.com>
Message-ID: <ZQhzeQLbB5zz2yIc@google.com>
Subject: Re: [RFC PATCH v12 10/33] KVM: Set the stage for handling only shared
 mappings in mmu_notifier events
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
> > Add flags to "struct kvm_gfn_range" to let notifier events target only
> > shared and only private mappings, and write up the existing mmu_notifier
> > events to be shared-only (private memory is never associated with a
> > userspace virtual address, i.e. can't be reached via mmu_notifiers).
> > 
> > Add two flags so that KVM can handle the three possibilities (shared,
> > private, and shared+private) without needing something like a tri-state
> > enum.
> 
> How to understand the word "stage" in short log?

Sorry, it's an idiom[*] that essentially means "to prepare for".  I'll rephrase
the shortlog to be more straightforward (I have a bad habit of using idioms).

[*] https://dictionary.cambridge.org/us/dictionary/english/set-the-stage-for
