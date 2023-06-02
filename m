Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58FEC77B7A
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjFBAX7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Jun 2023 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFBAX5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Jun 2023 20:23:57 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E649193
        for <linux-security-module@vger.kernel.org>; Thu,  1 Jun 2023 17:23:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-52857fc23b1so1341408a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jun 2023 17:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685665435; x=1688257435;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfVTz/MFdf1BdTl2DJtaA5MVU5d+x7qUPBQRynuzbEs=;
        b=lsng6iSxrqz9R88Q59ewsOGcDaYkTH4vRqDXC5iFszzkH/L48SReX+ccLn2qqVohKu
         SqRTT3wIMGLiTNYWwIKvQpUQy1rlArmCydKGFHXCUSm4HDybF/yCCEi4ngNdiHPHHIAO
         IvE9MObzfShr0WlQx7CjRaOodhTuihevv7Kvb25V0NnX+aCj6e89Z3iKFeAL+lLhSweK
         djWxmTAZR53Gd6ZwAEJJraDzBmWjEDJjAVLEUoTCsaFeXmgf0aQGIJKaiMkaQzmwqMTm
         MDcuVqxl1ntCRLEQ+YYvdB2O6IC0xaDBz4EXjfHWwXcBoneakB4xjWXpWdEkTnS2DRwX
         Al0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685665435; x=1688257435;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfVTz/MFdf1BdTl2DJtaA5MVU5d+x7qUPBQRynuzbEs=;
        b=QPEphtNPcyZiDRc8uAp33K17OgEqvRB8y/0MQR8hn4dQS29a2auSvwKsF+17LXYXTM
         XF9iWj/e1jeVbnZZ4jmCvuDeGf7kDSzh/VnwFoqRa1Rwb0wMTzCOhq+4ybfJBUx2QeKf
         WI6BChEu90ZqTCsLzFa53GiOj+pUb/elf1dwd09i9Y9ogu7qpQu3n1TlpIk5DJ3lNdGP
         cPMJ6zlY+Jtk+rnfWxAk7uZCmPmvJjMQyP6JNc3x/j7PhQDtlTcDdfllzXjBGfOoINoX
         lBbXIRkNPI0UDyTUor5KzzSSg7mo/MtaZkperM9naQsf3AyophfL3Vh1KaC9A4P1fSm8
         aaxA==
X-Gm-Message-State: AC+VfDy9nixYTnrYTr4GVsdxIre49E/PS+hCfTDBgvRKtOnoa29KJ0fL
        xy7QkmrbLjliB32DXkbmDK6JdBPhBi4=
X-Google-Smtp-Source: ACHHUZ4sKaezOgXXrB+dL2dh8BcQkqJaicrwtBGNqgWl2x1iGIzS7OMmnpETOlVJ/dFfp6qtQmgVV4r4kJ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:fd47:0:b0:53f:5067:64ec with SMTP id
 m7-20020a63fd47000000b0053f506764ecmr2104111pgj.0.1685665434956; Thu, 01 Jun
 2023 17:23:54 -0700 (PDT)
Date:   Thu, 1 Jun 2023 17:23:53 -0700
In-Reply-To: <9a4edc66-a0a3-73e4-09c5-db68d4cfbb68@digikod.net>
Mime-Version: 1.0
References: <2f19f26e-20e5-8198-294e-27ea665b706f@redhat.com>
 <4142c8dc-5385-fb1d-4f8b-2a98bb3f99af@digikod.net> <9a4edc66-a0a3-73e4-09c5-db68d4cfbb68@digikod.net>
Message-ID: <ZHk2mVcBycjKCfGw@google.com>
Subject: Re: [ANNOUNCE] KVM Microconference at LPC 2023
From:   Sean Christopherson <seanjc@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Marc Zyngier <maz@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Alexander Graf <graf@amazon.com>,
        Forrest Yuan Yu <yuanyu@google.com>,
        John Andersen <john.s.andersen@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Marian Rotariu <marian.c.rotariu@gmail.com>,
        "Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>,
        "=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thara Gopinath <tgopinath@microsoft.com>,
        Will Deacon <will@kernel.org>,
        Zahra Tarkhani <ztarkhani@microsoft.com>,
        "=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>,
        dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 01, 2023, Micka=EF=BF=BDl Sala=EF=BF=BDn wrote:
> Hi,
>=20
> What is the status of this microconference proposal? We'd be happy to tal=
k
> about Heki [1] and potentially other hypervisor supports.

Proposal submitted (deadline is/was today), now we wait :-)  IIUC, we shoul=
d find
out rather quickly whether or not the KVM MC is a go.
