Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03ADC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7920E2133D
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WW7MXZyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDJNS2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:18:28 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39792 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfDJNS1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 09:18:27 -0400
Received: by mail-qt1-f202.google.com with SMTP id n13so2182297qtn.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+o0Ntb7SIwLZWETPV/HKtZApObcLc4LkdcmnujOUhts=;
        b=WW7MXZyLEov6of9VamS4HiPQ7LAvDWgQ5zadnCGCZfiCLyiKuAN54I+r/cAmhRdXXs
         x8yj36lwSwcA8fIXGkIM3lMgNBfp1LF/kJPpuoTGF5qAqvtnOqEtufgJdIvvPRnVc60W
         0au9oSQBcRUDKbg/lfpAu6ajEmD4mofbWuQRyHtehs1cVpIg0KT95kfMl/ZhsxAvvkmI
         g143SFWYmodicWfFhaNr7IzCOMfzVJvS7h79wmS5fcU6VCMPK0mOcGF2pRCo2LhfK8zK
         kHRpV4gF7x/FPvhI+LGE7hiV/lhsmnBXhn2l9SgVofpsKJ4nvsXANRaIamDBdFYAnIDH
         b0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+o0Ntb7SIwLZWETPV/HKtZApObcLc4LkdcmnujOUhts=;
        b=XFc6FeJXWbUuqRqnX4XlnZhIANm+FQH6iO45rMDHQjL6IVkJL5kAmSOExzRBCwOeVH
         bUHd6Gs7Xl0yPQLhb/TzsaGIpty5omsbOPIoWbxZuP+NY9Zh3T+Xj6OXe5HpywNIJVln
         JfcdWSDEFDju9RNRFs+pvXkjfi54JJtqJyiGJaA9JjCpWui/y9hkUGyVEsz5Ch50CBxH
         vIMXs5yYbsKWk8LQK+VHS0WHbKe0Qqdynsm2nUmwahuhl9nHB5ecsu4ObwxOu5N8c0JT
         sZ8AFM0mOoYgKWEwQIit03qI7cWi+ONuzMCeauQQ8ZUNFq654qOLi3qwKxkva9piAzbU
         PXhQ==
X-Gm-Message-State: APjAAAXi2ieRN+vGxlxbFJsxf9BJuJ16yU29d/0yqjBNvfQr2KkCgqNw
        xsOU/1pUo33rZQlvEUtKU8H0Q52mnr0=
X-Google-Smtp-Source: APXvYqwveKOK6/gPL1azSWe6krfPpA8mwyeT4i7ZjQopcXRe0G7RzaUhUVvY70xaNvyLIgNeA+WhLaI+jL4=
X-Received: by 2002:a37:b05:: with SMTP id 5mr4960772qkl.25.1554902306520;
 Wed, 10 Apr 2019 06:18:26 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:17:25 +0200
In-Reply-To: <20190410131726.250295-1-glider@google.com>
Message-Id: <20190410131726.250295-3-glider@google.com>
Mime-Version: 1.0
References: <20190410131726.250295-1-glider@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4 2/3] initmem: introduce CONFIG_INIT_ALL_HEAP
From:   Alexander Potapenko <glider@google.com>
To:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, labbott@redhat.com,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This config option adds the possibility to initialize newly allocated
pages and heap objects with a 0xAA pattern.
There's already a number of places where allocations are initialized
based on the presence of __GFP_ZERO flag. We just change this code so
that under CONFIG_INIT_ALL_HEAP these allocations are always initialized
with either 0x00 or 0xAA depending on the __GFP_ZERO.

No performance optimizations are done at the moment to reduce double
initialization of memory regions.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sandeep Patil <sspatil@android.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
---
 v3:
  - addressed comments by Masahiro Yamada (Kconfig fixes)
 v4:
  - addressed Randy Dunlap's comments: remove redundant "depends on"
  - replaced code wiring SLUB_DEBUG and page poisoning with a more
    lightweight implementation (Laura Abbott mentioned turning on
    debugging has serious performance issues)
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/page.h          |  1 +
 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/page_64.h         | 10 ++++++++++
 arch/x86/lib/clear_page_64.S           | 24 ++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_ioctl.c |  4 ++--
 include/linux/gfp.h                    | 10 ++++++++++
 include/linux/highmem.h                |  8 ++++++++
 kernel/kexec_core.c                    |  8 ++++++--
 mm/dmapool.c                           |  4 ++--
 mm/page_alloc.c                        |  9 +++++++--
 mm/slab.c                              | 19 +++++++++++++------
 mm/slub.c                              | 12 ++++++++----
 security/Kconfig.initmem               | 15 +++++++++++++++
 14 files changed, 108 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e34b9eba5de..3548235752f6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,6 +110,7 @@ config ARM64
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
 	select HAVE_ARCH_HUGE_VMAP
+	select HAVE_ARCH_INIT_ALL_HEAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index c88a3cb117a1..a7bea266c16d 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -33,6 +33,7 @@ extern void copy_page(void *to, const void *from);
 extern void clear_page(void *to);
 
 #define clear_user_page(addr,vaddr,pg)  __cpu_clear_user_page(addr, vaddr)
+#define clear_page_pattern(addr) __memset((addr), GFP_POISON_BYTE, PAGE_SIZE)
 #define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from, vaddr)
 
 typedef struct page *pgtable_t;
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..2058beaf3582 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -116,6 +116,7 @@ config X86
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
+	select HAVE_ARCH_INIT_ALL_HEAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..8e6e0c00f8c8 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -54,6 +54,16 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+#ifdef CONFIG_INIT_ALL_HEAP
+
+void clear_page_pattern_orig(void *page);
+// FIXME: add rep and erms.
+static inline void clear_page_pattern(void *page)
+{
+	clear_page_pattern_orig(page);
+}
+#endif
+
 void copy_page(void *to, void *from);
 
 #endif	/* !__ASSEMBLY__ */
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 88acd349911b..b64dab97d4ba 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -49,3 +49,27 @@ ENTRY(clear_page_erms)
 	ret
 ENDPROC(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
+
+#ifdef CONFIG_INIT_ALL_HEAP
+ENTRY(clear_page_pattern_orig)
+	movq   $0xAAAAAAAAAAAAAAAA,%rax
+	movl   $4096/64,%ecx
+	.p2align 4
+.Lloop_pat:
+	decl	%ecx
+	movq %rax,(%rdi)
+	PUT(1)
+	PUT(2)
+	PUT(3)
+	PUT(4)
+	PUT(5)
+	PUT(6)
+	PUT(7)
+	leaq	64(%rdi),%rdi
+	jnz	.Lloop_pat
+	nop
+	ret
+ENDPROC(clear_page_pattern_orig)
+EXPORT_SYMBOL_GPL(clear_page_pattern_orig)
+#endif
+
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index e1379949e663..1ad0eb28e651 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -127,8 +127,8 @@ __malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
 	res = (void *)pbundle->internal_buffer + pbundle->internal_used;
 	pbundle->internal_used =
 		ALIGN(new_used, sizeof(*pbundle->internal_buffer));
-	if (flags & __GFP_ZERO)
-		memset(res, 0, size);
+	if (GFP_INIT_ALWAYS_ON || (flags & __GFP_ZERO))
+		memset(res, INITMEM_FILL_BYTE(flags), size);
 	return res;
 }
 EXPORT_SYMBOL(_uverbs_alloc);
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index fdab7de7490d..a0016357a91a 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -213,6 +213,16 @@ struct vm_area_struct;
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
 
+#define GFP_POISON_BYTE (0xAA)
+#ifdef CONFIG_INIT_ALL_HEAP
+#define GFP_INIT_ALWAYS_ON (1)
+#define INITMEM_FILL_BYTE(gfp_flags) \
+	(((gfp_flags) & __GFP_ZERO) ? (0) : GFP_POISON_BYTE)
+#else
+#define GFP_INIT_ALWAYS_ON (0)
+#define INITMEM_FILL_BYTE(gfp_flags) (0)
+#endif
+
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ea5cdbd8c2c3..b48a04c7b046 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -215,6 +215,14 @@ static inline void clear_highpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
+static inline void clear_highpage_pattern(struct page *page)
+{
+	void *kaddr = kmap_atomic(page);
+
+	clear_page_pattern(kaddr);
+	kunmap_atomic(kaddr);
+}
+
 static inline void zero_user_segments(struct page *page,
 	unsigned start1, unsigned end1,
 	unsigned start2, unsigned end2)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..63104a71cf60 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -315,9 +315,13 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
 		arch_kexec_post_alloc_pages(page_address(pages), count,
 					    gfp_mask);
 
-		if (gfp_mask & __GFP_ZERO)
+		if (GFP_INIT_ALWAYS_ON || (gfp_mask & __GFP_ZERO)) {
 			for (i = 0; i < count; i++)
-				clear_highpage(pages + i);
+				if (!INITMEM_FILL_BYTE(gfp_mask))
+					clear_highpage(pages + i);
+				else
+					clear_highpage_pattern(pages + i);
+		}
 	}
 
 	return pages;
diff --git a/mm/dmapool.c b/mm/dmapool.c
index 76a160083506..f36dd9065f2b 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -381,8 +381,8 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 #endif
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-	if (mem_flags & __GFP_ZERO)
-		memset(retval, 0, pool->size);
+	if (GFP_INIT_ALWAYS_ON || (mem_flags & __GFP_ZERO))
+		memset(retval, INITMEM_FILL_BYTE(mem_flags), pool->size);
 
 	return retval;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d96ca5bc555b..c8477db5ac94 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2014,9 +2014,14 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 
 	post_alloc_hook(page, order, gfp_flags);
 
-	if (!free_pages_prezeroed() && (gfp_flags & __GFP_ZERO))
+	if (!free_pages_prezeroed() && (GFP_INIT_ALWAYS_ON ||
+					(gfp_flags & __GFP_ZERO))) {
 		for (i = 0; i < (1 << order); i++)
-			clear_highpage(page + i);
+			if (!INITMEM_FILL_BYTE(gfp_flags))
+				clear_highpage(page + i);
+			else
+				clear_highpage_pattern(page + i);
+	}
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
diff --git a/mm/slab.c b/mm/slab.c
index 47a380a486ee..6d30db845dbd 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3331,8 +3331,11 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
 
-	if (unlikely(flags & __GFP_ZERO) && ptr)
-		memset(ptr, 0, cachep->object_size);
+	if ((unlikely(flags & __GFP_ZERO) ||
+			(GFP_INIT_ALWAYS_ON && !cachep->ctor &&
+			!(cachep->flags & SLAB_TYPESAFE_BY_RCU))) &&
+			ptr)
+		memset(ptr, INITMEM_FILL_BYTE(flags), cachep->object_size);
 
 	slab_post_alloc_hook(cachep, flags, 1, &ptr);
 	return ptr;
@@ -3388,8 +3391,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
 
-	if (unlikely(flags & __GFP_ZERO) && objp)
-		memset(objp, 0, cachep->object_size);
+	if (((GFP_INIT_ALWAYS_ON && !cachep->ctor &&
+			!(cachep->flags & SLAB_TYPESAFE_BY_RCU)) ||
+			unlikely(flags & __GFP_ZERO)) && objp)
+		memset(objp, INITMEM_FILL_BYTE(flags), cachep->object_size);
 
 	slab_post_alloc_hook(cachep, flags, 1, &objp);
 	return objp;
@@ -3596,9 +3601,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	cache_alloc_debugcheck_after_bulk(s, flags, size, p, _RET_IP_);
 
 	/* Clear memory outside IRQ disabled section */
-	if (unlikely(flags & __GFP_ZERO))
+	if ((GFP_INIT_ALWAYS_ON && !s->ctor &&
+			!(flags & SLAB_TYPESAFE_BY_RCU)) ||
+			unlikely(flags & __GFP_ZERO))
 		for (i = 0; i < size; i++)
-			memset(p[i], 0, s->object_size);
+			memset(p[i], INITMEM_FILL_BYTE(flags), s->object_size);
 
 	slab_post_alloc_hook(s, flags, size, p);
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
diff --git a/mm/slub.c b/mm/slub.c
index d30ede89f4a6..f89c39b01578 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2750,8 +2750,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 		stat(s, ALLOC_FASTPATH);
 	}
 
-	if (unlikely(gfpflags & __GFP_ZERO) && object)
-		memset(object, 0, s->object_size);
+	if (((GFP_INIT_ALWAYS_ON && !s->ctor &&
+			!(s->flags & SLAB_TYPESAFE_BY_RCU)) ||
+			unlikely(gfpflags & __GFP_ZERO)) && object)
+		memset(object, INITMEM_FILL_BYTE(gfpflags), s->object_size);
 
 	slab_post_alloc_hook(s, gfpflags, 1, &object);
 
@@ -3172,11 +3174,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	local_irq_enable();
 
 	/* Clear memory outside IRQ disabled fastpath loop */
-	if (unlikely(flags & __GFP_ZERO)) {
+	if ((GFP_INIT_ALWAYS_ON && !s->ctor &&
+			!(s->flags & SLAB_TYPESAFE_BY_RCU)) ||
+			unlikely(flags & __GFP_ZERO)) {
 		int j;
 
 		for (j = 0; j < i; j++)
-			memset(p[j], 0, s->object_size);
+			memset(p[j], INITMEM_FILL_BYTE(flags), s->object_size);
 	}
 
 	/* memcg and kmem_cache debug support */
diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
index cdad1e185b10..93bc6fe32536 100644
--- a/security/Kconfig.initmem
+++ b/security/Kconfig.initmem
@@ -1,5 +1,8 @@
 menu "Initialize all memory"
 
+config HAVE_ARCH_INIT_ALL_HEAP
+	bool
+
 config CC_HAS_AUTO_VAR_INIT
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
@@ -24,5 +27,17 @@ config INIT_ALL_STACK
 	  Initialize uninitialized stack data with a fixed pattern
 	  (0x00 in GCC, 0xAA in Clang).
 
+if HAVE_ARCH_INIT_ALL_HEAP
+
+config INIT_ALL_HEAP
+	bool "Initialize all heap"
+	depends on SLAB || SLUB
+	default y
+	help
+	  Initialize uninitialized pages and SL[AOU]B allocations with 0xAA
+	  pattern.
+
+endif # HAVE_ARCH_INIT_ALL_HEAP
+
 endif # INIT_ALL_MEMORY
 endmenu
-- 
2.21.0.392.gf8f6787159e-goog

