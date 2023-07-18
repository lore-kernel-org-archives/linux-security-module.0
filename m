Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F186CC04A94
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jul 2023 23:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGRXvg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGRXvN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jul 2023 19:51:13 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E105272E
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 16:49:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8af49a5d2so48848245ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724141; x=1692316141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RgixHOC4KKphqTDNjO+JFitY6BYM03Mxe9+IG67pQW4=;
        b=Z2PDbS4gr+5Nj7HMCcZWGl1tZ5vDnWWr9UFOQWyuTPq4Le6J/DFchZREN78jDoLiNt
         wTz7e++DKf3xxvC6DQWmhlq9LCfY+6KJt/akai9MDfl4MMETtQmADEUIv6Xp3eUItkoI
         NKXA4wzFrdqI7D5dAv6Q1VzIxZDb5WlT5tngMM6tJ9RELglZJ0tflV4y4Fx6tBq8Fkd7
         IUaHstDT6jWDiTJMcGXK9/WvGtGUecGjPCcXL17rHlO1OrRDwY7hH4OFFmMTb1EkgUWD
         ajOHXv3Kb54FHrD7lrS77IvTEUoejEKSKqlZdb+IK0Gyxo6V/0vyTGpUfmajaUotfr3l
         le4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724141; x=1692316141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgixHOC4KKphqTDNjO+JFitY6BYM03Mxe9+IG67pQW4=;
        b=JldGrJynLPulwEAAVj0mUo7dPq5naxiJ/dNQFly8m2ZdGByGV1GQFuBdVVBqHhSk70
         hgfmgRG3Thcm/L2SavZg0tbxI2xn9/oo4SK4LV0SURDGkHrCPdxR6PXYjl24wEdMQlxO
         Rj74L+z0iZetP1gTtJJOSXHwBVceKVDdz2o2lzF69tzKucrqDyavQNsfRQLaRWlEJPq5
         2zNPAGJUCUoAB65YKWFfQRp9I446kL8DPzaFDOgDGX+j6qDcJ3bAT9MsicDamZGnlSlw
         96XP+mYLwRwPTc87sK8tOwQo4ev6KJqDEEJBJhDjhUYflrfoUGenseb7OY9p4Wfo7osI
         iJug==
X-Gm-Message-State: ABy/qLaeqAp9DTqiVoH/VeGhtBewWYtrAfQos6FP4PVloc+PQDhr+UI6
        MNy3B8HPTR3icLyVX6FLNUK60wGMoKI=
X-Google-Smtp-Source: APBJJlGmnxKpuVWpCwuKlcGO555af6O2CzLSJLrftIAb/WXIRBmN0a0otiSNa7LmthtetMuC6YJJMcmnlto=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2cf:b0:1ba:a36d:f82c with SMTP id
 n15-20020a170902d2cf00b001baa36df82cmr7700plc.7.1689724140625; Tue, 18 Jul
 2023 16:49:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:58 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-16-seanjc@google.com>
Subject: [RFC PATCH v11 15/29] KVM: Drop superfluous __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
 macro
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 include/linux/kvm_host.h        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b87ff7b601fa..7a905e033932 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2105,7 +2105,6 @@ enum {
 #define HF_SMM_MASK		(1 << 1)
 #define HF_SMM_INSIDE_NMI_MASK	(1 << 2)
 
-# define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
 # define KVM_ADDRESS_SPACE_NUM 2
 # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0d1e2ee8ae7a..5839ef44e145 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -693,7 +693,7 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
 #define KVM_MEM_SLOTS_NUM SHRT_MAX
 #define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
 
-#ifndef __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
+#if KVM_ADDRESS_SPACE_NUM == 1
 static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 {
 	return 0;
-- 
2.41.0.255.g8b1d071c50-goog

