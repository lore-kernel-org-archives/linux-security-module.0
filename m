Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A03CCCF9F0
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Sep 2023 23:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbjIEX4j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Sep 2023 19:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjIEX4i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Sep 2023 19:56:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF21BB
        for <linux-security-module@vger.kernel.org>; Tue,  5 Sep 2023 16:56:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7b9a334ccfso752941276.0
        for <linux-security-module@vger.kernel.org>; Tue, 05 Sep 2023 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693958193; x=1694562993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTMdUX0G2lv2+kU2WiYySTJObpffzgV002stI1a1W7I=;
        b=e7n6Yjksn2CMZRtFHL5RDakHGb5NbF8DYWqlKCV2VtvDz+bekmAxT60g6N1QEt4Q9x
         TnsqFvLITcWcza8/3XwZpqAt0gi0gYzd1nGQYtSJxMLnJNH2oHGZIMTvMrQVoz/ZFZik
         tbKvfANIdod5uVbLAZYsDMDpiT3PiNLOr8kAox4fLx9MwiOZYQKmhuLC6uF8FytOaf5d
         qY3XUntd/mCB+S4TE8YGHPYj5zzee1tN1PA42iKcQUw5WQLVQW/JKAEVFoQlof+IXjgO
         Fcy86VDmQgAqbHsdDgcGCn8ZxzB3Jb49XYlt7LU9Mv15oAV8iTZFBLCCmUqI4wpgNEW6
         QFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693958193; x=1694562993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTMdUX0G2lv2+kU2WiYySTJObpffzgV002stI1a1W7I=;
        b=ToDPHueBjyP0JD+WlobkALq5l/WAwNXudw78V70Ebk4DvmY/PNJ94yVd1ocmLjMThf
         lvvSKSSr08lOtNKMRoX0wQ8ZjFfr3/aUypMRzdhxyKaLmW0XiHpSeaVNR/bJ7964nBZh
         hXq22GNDcoMRas6yv64s2dVtoNN1NAJ/QCY7bHRTsG8HlMFT3UpG4tVTGgICDIQHnzeC
         ktZ3Izawb202qcSneAh/wFcH3zVA2L3CXGKRtthHgbeux2FjvM3lwB9YTCVWaRnzAgSF
         ps5l7fPdqcn+IqWyLDlrCIMURVzxLxsn3PPEq/Xi8+rSAXfUqY653lyCEN4ovbPnSwRa
         xoHA==
X-Gm-Message-State: AOJu0YzVAm97tvBVgjF6QvIiM5J2WrHueT9xSjfg/ypbnGcDP78C/Gz0
        2eRVBhf5o0Y8n6RDcCmN2ZYI6SmNgQA=
X-Google-Smtp-Source: AGHT+IGHRLIyxOEOlqNogao+wtJt3d7D+zZNTRSCijTepfZz1QuZZsrU81NGe3dzgdfi+rQuqyfdUQCuPic=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4211:0:b0:d7e:c4af:22d2 with SMTP id
 p17-20020a254211000000b00d7ec4af22d2mr293199yba.4.1693958192804; Tue, 05 Sep
 2023 16:56:32 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:56:31 -0700
In-Reply-To: <20230901082025.20548-2-vbabka@suse.cz>
Mime-Version: 1.0
References: <20230901082025.20548-2-vbabka@suse.cz>
Message-ID: <ZPfAL0D95AwXD9tg@google.com>
Subject: Re: [PATCH gmem FIXUP] mm, compaction: make testing
 mapping_unmovable() safe
From:   Sean Christopherson <seanjc@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ackerleytng@google.com, akpm@linux-foundation.org,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        chao.p.peng@linux.intel.com, chenhuacai@kernel.org,
        david@redhat.com, isaku.yamahata@gmail.com, jarkko@kernel.org,
        jmorris@namei.org, kirill.shutemov@linux.intel.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, liam.merwick@oracle.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mail@maciej.szmigiero.name,
        maz@kernel.org, michael.roth@amd.com, mpe@ellerman.id.au,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, paul@paul-moore.com, pbonzini@redhat.com,
        qperret@google.com, serge@hallyn.com, tabba@google.com,
        vannapurve@google.com, wei.w.wang@intel.com, willy@infradead.org,
        yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 01, 2023, Vlastimil Babka wrote:
> As Kirill pointed out, mapping can be removed under us due to
> truncation. Test it under folio lock as already done for the async
> compaction / dirty folio case. To prevent locking every folio with
> mapping to do the test, do it only for unevictable folios, as we can
> expect the unmovable mapping folios are also unevictable - it is the
> case for guest memfd folios.

Rather than expect/assume that unmovable mappings are always unevictable, how about
requiring that?  E.g. either through a VM_WARN_ON in mapping_set_unmovable(), or by
simply having that helper forcefully set AS_UNEVICTABLE as well.
