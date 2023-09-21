Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E35E7D0A6
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 19:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjIUTiA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjIUThp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 15:37:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09AEBCFE
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 12:10:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdae1ef38so45501637b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695323438; x=1695928238; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msCRqftjzvMka6Rl5V/NvDEz768neF2Qswneru1ptF4=;
        b=ANIsopKH6FB/YfeeiHhknjvBJ5XAITWb1M/gbs+yBeC/ao6mEHXNiCijAVIw3AUBEu
         /L10qRlBCqsFUCKjuQ13ougwWzehqWocSM7xFbHiwYegbOYJIt/J8GRTSphAAc/IXNxA
         o/QR0WmMt3Rr9/Z8RTFG6WRUg72slcENJ91CRvg4tLf3p19skDGjdSesRMqooJ1TxrwN
         kPhHasmtBgG5lahnT+KGJMN8FxVv+FrAn5x5/Kv9qYOj8nLmDk3goWg8x91Iiv6qr5n8
         fwxGc9VtkPBY6BwtxtcN575WzcMCKX9wO1T2K3HDKmiEMiuIAhwnOqpeTpRRAHJ8OTQF
         ea5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323438; x=1695928238;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msCRqftjzvMka6Rl5V/NvDEz768neF2Qswneru1ptF4=;
        b=jTN54CbU0Z4IWQA0PeR1jXMBgi1azY+1nSobbaiLUWKTzuwsm+gVVz2R8Qtng5TC3L
         Nq7p5v8w0C0NFdCjqnKAZ9lO5fQFO0vIaXsrsuwWm0tvanIJddbyn0sg+0aEaw1As1A0
         GyyIeEfPY0badI/8/39q9esxDP5IKXYd+ppMYdQdsbdmrEHO3nBA0r37eT2dD2+bzXuG
         NyB3n4qsDxNtiAiegOscCDXctke60dAxhy9u56xO79PeJjTsx4dsilG9Dy/rQqs3GdeY
         iaplFIkVyf24mCb8IXdNNcyZzC3zQl/fsq0qBN43pjlkT1DNLhY5y45jOK2PqBjtWamB
         /r/w==
X-Gm-Message-State: AOJu0YykDzoqSozLsjn+nwPnizG/w6hv5G3kq8v7YIeFOxcsh8bQ5XYn
        X2gAK/VdH4PXfQrA1AyW3MLe9yE4JOk=
X-Google-Smtp-Source: AGHT+IHW881nAqFnjABVXUT4908B5v4pAo/onJespz4HnG5MCVd8NLEq9DsMcDxqDXD3hJb4Zo/K0u0JOVE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:70a:b0:58c:e8da:4d1a with SMTP id
 bs10-20020a05690c070a00b0058ce8da4d1amr8361ywb.2.1695323438500; Thu, 21 Sep
 2023 12:10:38 -0700 (PDT)
Date:   Thu, 21 Sep 2023 12:10:36 -0700
In-Reply-To: <20230914015531.1419405-15-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-15-seanjc@google.com>
Message-ID: <ZQyVLEKXbpJ9Wvud@google.com>
Subject: Re: [RFC PATCH v12 14/33] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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

On Wed, Sep 13, 2023, Sean Christopherson wrote:
>  virt/kvm/guest_mem.c       | 593 +++++++++++++++++++++++++++++++++++++

Getting to the really important stuff...

Anyone object to naming the new file guest_memfd.c instead of guest_mem.c?  Just
the file, i.e. still keep the gmem namespace.

Using guest_memfd.c would make it much more obvious that the file holds more than
generic "guest memory" APIs, and would provide a stronger conceptual connection
with memfd.c.
