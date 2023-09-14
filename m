Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23F7EE0212
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Sep 2023 02:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjINCLv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Sep 2023 22:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjINBzz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Sep 2023 21:55:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68AC2100
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 18:55:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d9e327d3aso6069787b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656542; x=1695261342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ipMZPiP5QxzJYr8+L2XHaFOQ2agfNk5lTTsPLIZe0Eo=;
        b=IYqzzwJlcplJX/r3J2tz2Ie0U2pJa6yJcoFIB2mB3qtz8aNbHRzP/mQbr+c1Q4EAD9
         WzQ6HwL6/29VikUHsAqcBLdxf2EvUtO2LVzfI30VLqUj3j6/z36Z3ki3tYTVTuWVQ0JX
         eQqYMl9YiacRKgBEVR+bHlHlUvWTxHAcMvGXmw0pOgmG2GxWIOR2hFPo4S5hUmw4jhhF
         X0k81+npQ2v0TL4UTz84eaHb9zta3wNn+5IKYz4udxRG0wLrqCUIWlM37rOk87V68NqQ
         ZN4axMlE4i8JIPbNMc00N0jXXDwV7FgxAcYSAueGtP0VB/6fETCF571k696jITYuJl5D
         ovqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656542; x=1695261342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipMZPiP5QxzJYr8+L2XHaFOQ2agfNk5lTTsPLIZe0Eo=;
        b=UGYf3cAflqRcqQ4cWtqP1rwYJIaDq3CVtUtsWC9SukyDECLMBdfPM1LtlzSQl2toG+
         1PoWkXD/Mbgp+4lfpg8rPs3cU07vptoFU9Uu7ZTsj/Je7xqB/SvSUZW1m0WCmOAWtLFz
         YVMD3qcuKja/OHkxvtQD4JoRaWa2IjxjC5SXw709Z/zxbeOeU0IhaYUvroY9sI7bEW0L
         vLrvombejWBlENmW135c06RvtbQbeBqvVpNwQ6ShGc3/xoJnexOFWt1Z7CIg802COGWY
         RkQ5+wG1lPDvSYD4B4nGgvOcpI0IJjbgsseK8Q2Ohq2y+MOJdo3FCPRTq7OVyOWyZVsn
         o0Aw==
X-Gm-Message-State: AOJu0Yx9PpkM7wci982ammA+7dohDLV8Stlf4z0Y7RjCYay9laE9qrt7
        9wfxAoRhzG7uIMnwZv6/rJLOq2wOvjw=
X-Google-Smtp-Source: AGHT+IHZ9maMkZbk/mDeS4QG3cCYdpuky8EXqvBvcYXtjkjg3bX1mPxWKIK7RZclMdxYQ1SdoMO1l2xcItw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:b0a:b0:59b:ebe0:9fd6 with SMTP id
 cj10-20020a05690c0b0a00b0059bebe09fd6mr14465ywb.6.1694656542028; Wed, 13 Sep
 2023 18:55:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:01 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-4-seanjc@google.com>
Subject: [RFC PATCH v12 03/33] KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Assert that both KVM_ARCH_WANT_MMU_NOTIFIER and CONFIG_MMU_NOTIFIER are
defined when KVM is enabled, and return '1' unconditionally for the
CONFIG_KVM_BOOK3S_HV_POSSIBLE=n path.  All flavors of PPC support for KVM
select MMU_NOTIFIER, and KVM_ARCH_WANT_MMU_NOTIFIER is unconditionally
defined by arch/powerpc/include/asm/kvm_host.h.

Effectively dropping use of KVM_ARCH_WANT_MMU_NOTIFIER will simplify a
future cleanup to turn KVM_ARCH_WANT_MMU_NOTIFIER into a Kconfig, i.e.
will allow combining all of the

  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)

checks into a single

  #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER

without having to worry about PPC's "bare" usage of
KVM_ARCH_WANT_MMU_NOTIFIER.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/powerpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 7197c8256668..b0a512ede764 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -632,12 +632,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
+#if !defined(CONFIG_MMU_NOTIFIER) || !defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+		BUILD_BUG();
+#endif
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 		r = hv_enabled;
-#elif defined(KVM_ARCH_WANT_MMU_NOTIFIER)
-		r = 1;
 #else
-		r = 0;
+		r = 1;
 #endif
 		break;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-- 
2.42.0.283.g2d96d420d3-goog

