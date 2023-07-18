Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF6FEB64DD
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jul 2023 23:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGRXwU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjGRXv2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jul 2023 19:51:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2121BEB
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 16:49:40 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c04f5827eso2851930a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724146; x=1692316146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jNVa/iQ+AVctjdypzscw/wZ/omqP7xdpmmirAsZhWLw=;
        b=S9i20yQ7jB4hVddDMJ4CkO5T1TWmd4hfWWkq8Xl9LowlAEQdj2ZBN4AmHJWPyNUeoT
         CkrrWKNwK4ZqQLVQM2y6BQWzimiT4YCPNLG/XY2OgxS9elbM94AeEwd6oVkZtS5CMdNQ
         enYmJItt+taFRfJF03P5U3tsXYvhEykGsai5MRAd/rpILORWE8Nwwq/35e1lrZlSdKCf
         nnux/I5fy00kI9O4nAFwoaKQfkECwHaMBer7UN6aWCOBJCp2NOyFIamjX8g6Muuevcj+
         zN2G8rzvgNhVTfZL/D1gpgeoLq9Z9aveGPtzRcTPzuDzimSMVNdowxyXn99BRYpLpXYL
         a5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724146; x=1692316146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNVa/iQ+AVctjdypzscw/wZ/omqP7xdpmmirAsZhWLw=;
        b=XRLdEOtX6hV3i9cRPPD7AXJ96cCfhX5Cckp/muJH5+0yOIFtYPXyotU7qUC0572swp
         s6c+gapGgrzXLfp7pk0HyHqXL/i+2lHigpVLukxG09hw17mH1uR9/ncFT4AP++Z6sRvX
         q5RXGG3qlokhraWrcLl16wJKcaev3UB2RUtuJqIHjtovq5maUzJTCDH1ac+UcnbIL4hS
         jUsAs6/j3dFUhxExPfMlcRGsbND7FKxNuvUD9BUDlI24U5dQFHld+XekrNfFvmgE0CDe
         LxABE4S3y/YRKyHAJU2Lm35KV1F56RcsE5cPY392tML0TdaJHcEKuEx3ek33S2GVpSuU
         wOeA==
X-Gm-Message-State: ABy/qLa1i3kyDLKFQ2AiTYMxwKlrk4mP+zWkHzPe44Y6kra1uM2UBZZT
        XK6mdi9OOpR8HCTRCSFWI1V3WGSUpAM=
X-Google-Smtp-Source: APBJJlG/sMr3G/sYhFjIAPMZFMzUGPYNnqDIC48VMqcoxoy+9ZQXw2cmdVjFEV6r5k/FZaKWiRT4xFOW180=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d503:b0:1b8:8c7:31e6 with SMTP id
 b3-20020a170902d50300b001b808c731e6mr17710plg.1.1689724146247; Tue, 18 Jul
 2023 16:49:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:45:01 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-19-seanjc@google.com>
Subject: [RFC PATCH v11 18/29] KVM: selftests: Drop unused kvm_userspace_memory_region_find()
 helper
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

Drop kvm_userspace_memory_region_find(), it's unused and a terrible API
(probably why it's unused).  If anything outside of kvm_util.c needs to
get at the memslot, userspace_mem_region_find() can be exposed to give
others full access to all memory region/slot information.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  4 ---
 tools/testing/selftests/kvm/lib/kvm_util.c    | 29 -------------------
 2 files changed, 33 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 07732a157ccd..6aeb008dd668 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -753,10 +753,6 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
 	return n;
 }
 
-struct kvm_userspace_memory_region *
-kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
-				 uint64_t end);
-
 #define sync_global_to_guest(vm, g) ({				\
 	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
 	memcpy(_p, &(g), sizeof(g));				\
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9741a7ff6380..45d21e052db0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -586,35 +586,6 @@ userspace_mem_region_find(struct kvm_vm *vm, uint64_t start, uint64_t end)
 	return NULL;
 }
 
-/*
- * KVM Userspace Memory Region Find
- *
- * Input Args:
- *   vm - Virtual Machine
- *   start - Starting VM physical address
- *   end - Ending VM physical address, inclusive.
- *
- * Output Args: None
- *
- * Return:
- *   Pointer to overlapping region, NULL if no such region.
- *
- * Public interface to userspace_mem_region_find. Allows tests to look up
- * the memslot datastructure for a given range of guest physical memory.
- */
-struct kvm_userspace_memory_region *
-kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
-				 uint64_t end)
-{
-	struct userspace_mem_region *region;
-
-	region = userspace_mem_region_find(vm, start, end);
-	if (!region)
-		return NULL;
-
-	return &region->region;
-}
-
 __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
 {
 
-- 
2.41.0.255.g8b1d071c50-goog

