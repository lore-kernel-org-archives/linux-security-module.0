Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F3CA0FED
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Sep 2023 16:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbjIAQqh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348292AbjIAQqg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Sep 2023 12:46:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8210EC
        for <linux-security-module@vger.kernel.org>; Fri,  1 Sep 2023 09:46:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bf703dd21fso25176885ad.3
        for <linux-security-module@vger.kernel.org>; Fri, 01 Sep 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693586793; x=1694191593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xCon5474F9WwphxhfgFhUzbwn0ALvK9xFv6P5Xz3AWM=;
        b=hqU4wmxbesZHmpksagWiQXpeohEWVSELxtPPYGBcPYGHLzd4PgAZfKgihohM8nieNL
         x3j7YDZ7OFe1og77j691yrddLu54oFaBwlTOnLguDHh5p7+BR6+/NS0Pvahur84Awr49
         bkuD34JPS3lDemn9o374Aub5/hANryTKiGgwBpMkhQipD2xt1GjE8Tr7x8dvTJm1yuUP
         N4OflW4yEADxpThIY2D6fG6q7dWUsDZ8Me2Lye9Qu/RXCmRg6gJabmzXwP2Q72T9eIcR
         awghr/9a/lXoGNWrdpu9mabpbW5iiXix8awk61LcoVpzwdYHAKz7wJ9oNjs2LMhAzZ1M
         yjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693586793; x=1694191593;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCon5474F9WwphxhfgFhUzbwn0ALvK9xFv6P5Xz3AWM=;
        b=VdmC5WLpq+DrWAM/ccMcDzlLHac3WtPtgrsAFklQYsk+rzR95yLoA+0zTnenHFkW+E
         yfvUgM4JimnF9uEU0tm+WAfm5a+f5JxkjMGU2ycUHqSHMqtqXdRLI6IfGEqtlOMy3q1H
         ropeTYYrUh5xxztmBgw7w4/iXyKFOiZgd4w0cIsprpfzu4pl45COFoi0lYKRd7VPIZCc
         w7WODcmi5QrHiEKs0r9oGVVKaB6t0hI9RtSeI//DNam24bSUjZQHb9GiWdcbcMbVukC9
         iogkX3mZr3f2l3K1mHaB11OJsqRgeCB+a7KMo+ZYlr1iAAiOybg9e+Kn+11ZuHAawkFE
         V3dw==
X-Gm-Message-State: AOJu0YzPkj/BGRgM/uXnwLOzrr+H6gg8XsLwpOlbtErNEEGHuVuCyoBL
        F6nGwqx+8TFW0Av1q48Mm7fUlahOiuJkTbQJ0g==
X-Google-Smtp-Source: AGHT+IE7IWuztjp33Ush39YmsLck94qkQHf2UcyeDE5trFHuf5V0W6HBwaqY0C7q2Vl17GPr3mAIvAb6tklgxvjU0g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:e887:b0:1bc:e6a:205e with SMTP
 id w7-20020a170902e88700b001bc0e6a205emr1066486plg.5.1693586792693; Fri, 01
 Sep 2023 09:46:32 -0700 (PDT)
Date:   Fri, 01 Sep 2023 16:46:31 +0000
In-Reply-To: <f7aaf097-6f83-0ee9-e16d-713d392b2299@linux.intel.com> (message
 from Binbin Wu on Fri, 1 Sep 2023 11:45:43 +0800)
Mime-Version: 1.0
Message-ID: <diqz34zxg7tk.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, yu.c.zhang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        chao.p.peng@linux.intel.com, linux-riscv@lists.infradead.org,
        isaku.yamahata@gmail.com, maz@kernel.org, paul@paul-moore.com,
        anup@brainfault.org, chenhuacai@kernel.org, jmorris@namei.org,
        willy@infradead.org, wei.w.wang@intel.com, tabba@google.com,
        jarkko@kernel.org, serge@hallyn.com, mail@maciej.szmigiero.name,
        aou@eecs.berkeley.edu, vbabka@suse.cz, michael.roth@amd.com,
        paul.walmsley@sifive.com, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, qperret@google.com,
        seanjc@google.com, liam.merwick@oracle.com,
        linux-mips@vger.kernel.org, oliver.upton@linux.dev,
        linux-security-module@vger.kernel.org, palmer@dabbelt.com,
        kvm-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        pbonzini@redhat.com, akpm@linux-foundation.org,
        vannapurve@google.com, linuxppc-dev@lists.ozlabs.org,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Binbin Wu <binbin.wu@linux.intel.com> writes:

> <snip>
>
>>
>> I'm not sure whose refcount the folio_put() in kvm_gmem_allocate() is
>> dropping though:
>>
>> + The refcount for the filemap depends on whether this is a hugepage or
>>    not, but folio_put() strictly drops a refcount of 1.
>> + The refcount for the lru list is just 1, but doesn't the page still
>>    remain in the lru list?
>
> I guess the refcount drop here is the one get on the fresh allocation.
> Now the filemap has grabbed the folio, so the lifecycle of the folio now 
> is decided by the filemap/inode?
>

This makes sense! So folio_put() here is saying, I'm not using this
folio anymore, but the filemap and the lru list are stil using the
folio.

> <snip>
