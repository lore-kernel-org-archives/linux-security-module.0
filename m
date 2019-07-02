Return-Path: <SRS0=lFJQ=VA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F86C5B57D
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jul 2019 01:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D152063F
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jul 2019 01:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562117285;
	bh=iRu3VNOe2UUsUii+YtWwRL9+vOwU1d4+9aIcTU3Xflk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C+di4qGLP1K/alss89U2IFkBnBjk2btUh9J0jHHnlMpVaTWRljeGk7rDfpDze9kcb
	 Suh5kqnv8gD3PYuVTRNBKCGWEnnADhgU1Y3K0UyGO9xMQB+D3YL9o13oQ25G+WyCf3
	 DcKvkZqfnpqHdFJfh8xl6t4qPVUX7G7fuOZlOkjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfGCB2F (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfGCB2E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jul 2019 21:28:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B896A21954;
        Tue,  2 Jul 2019 22:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562108356;
        bh=iRu3VNOe2UUsUii+YtWwRL9+vOwU1d4+9aIcTU3Xflk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHdrGlf41wDBUbR8nmq0GhdtDDlZO0yuNmpD6khamveWRyuhExuvwehPTjqBHRhwz
         hDCshEIl1r1SB5ixh6T2DjLlZDgTJZoi1YP+DJAcIwZJ/5+Z5eQBeYolBp+HAyle8g
         EOSCdB/5O0adv8tI4NTLTlB43TBtChALpoIMg8Ho=
Date:   Tue, 2 Jul 2019 15:59:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v10 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-Id: <20190702155915.ab5e7053e5c0d49e84c6ed67@linux-foundation.org>
In-Reply-To: <20190628093131.199499-2-glider@google.com>
References: <20190628093131.199499-1-glider@google.com>
        <20190628093131.199499-2-glider@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 28 Jun 2019 11:31:30 +0200 Alexander Potapenko <glider@google.com> wrote:

> The new options are needed to prevent possible information leaks and
> make control-flow bugs that depend on uninitialized values more
> deterministic.
> 
> This is expected to be on-by-default on Android and Chrome OS. And it
> gives the opportunity for anyone else to use it under distros too via
> the boot args. (The init_on_free feature is regularly requested by
> folks where memory forensics is included in their threat models.)
> 
> init_on_alloc=1 makes the kernel initialize newly allocated pages and heap
> objects with zeroes. Initialization is done at allocation time at the
> places where checks for __GFP_ZERO are performed.
> 
> init_on_free=1 makes the kernel initialize freed pages and heap objects
> with zeroes upon their deletion. This helps to ensure sensitive data
> doesn't leak via use-after-free accesses.
> 
> Both init_on_alloc=1 and init_on_free=1 guarantee that the allocator
> returns zeroed memory. The two exceptions are slab caches with
> constructors and SLAB_TYPESAFE_BY_RCU flag. Those are never
> zero-initialized to preserve their semantics.
> 
> Both init_on_alloc and init_on_free default to zero, but those defaults
> can be overridden with CONFIG_INIT_ON_ALLOC_DEFAULT_ON and
> CONFIG_INIT_ON_FREE_DEFAULT_ON.
> 
> If either SLUB poisoning or page poisoning is enabled, those options
> take precedence over init_on_alloc and init_on_free: initialization is
> only applied to unpoisoned allocations.
> 
> Slowdown for the new features compared to init_on_free=0,
> init_on_alloc=0:
> 
> hackbench, init_on_free=1:  +7.62% sys time (st.err 0.74%)
> hackbench, init_on_alloc=1: +7.75% sys time (st.err 2.14%)
> 
> Linux build with -j12, init_on_free=1:  +8.38% wall time (st.err 0.39%)
> Linux build with -j12, init_on_free=1:  +24.42% sys time (st.err 0.52%)
> Linux build with -j12, init_on_alloc=1: -0.13% wall time (st.err 0.42%)
> Linux build with -j12, init_on_alloc=1: +0.57% sys time (st.err 0.40%)
> 
> The slowdown for init_on_free=0, init_on_alloc=0 compared to the
> baseline is within the standard error.
> 
> The new features are also going to pave the way for hardware memory
> tagging (e.g. arm64's MTE), which will require both on_alloc and on_free
> hooks to set the tags for heap objects. With MTE, tagging will have the
> same cost as memory initialization.
> 
> Although init_on_free is rather costly, there are paranoid use-cases where
> in-memory data lifetime is desired to be minimized. There are various
> arguments for/against the realism of the associated threat models, but
> given that we'll need the infrastructure for MTE anyway, and there are
> people who want wipe-on-free behavior no matter what the performance cost,
> it seems reasonable to include it in this series.
>
> ...
>
>  v10:
>   - added Acked-by: tags
>   - converted pr_warn() to pr_info()

There are unchangelogged alterations between v9 and v10.  The
replacement of IS_ENABLED(CONFIG_PAGE_POISONING)) with
page_poisoning_enabled().


--- a/mm/page_alloc.c~mm-security-introduce-init_on_alloc=1-and-init_on_free=1-boot-options-v10
+++ a/mm/page_alloc.c
@@ -157,8 +157,8 @@ static int __init early_init_on_alloc(ch
 	if (!buf)
 		return -EINVAL;
 	ret = kstrtobool(buf, &bool_result);
-	if (bool_result && IS_ENABLED(CONFIG_PAGE_POISONING))
-		pr_warn("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_alloc\n");
+	if (bool_result && page_poisoning_enabled())
+		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_alloc\n");
 	if (bool_result)
 		static_branch_enable(&init_on_alloc);
 	else
@@ -175,8 +175,8 @@ static int __init early_init_on_free(cha
 	if (!buf)
 		return -EINVAL;
 	ret = kstrtobool(buf, &bool_result);
-	if (bool_result && IS_ENABLED(CONFIG_PAGE_POISONING))
-		pr_warn("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_free\n");
+	if (bool_result && page_poisoning_enabled())
+		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will take precedence over init_on_free\n");
 	if (bool_result)
 		static_branch_enable(&init_on_free);
 	else
--- a/mm/slub.c~mm-security-introduce-init_on_alloc=1-and-init_on_free=1-boot-options-v10
+++ a/mm/slub.c
@@ -1281,9 +1281,8 @@ check_slabs:
 out:
 	if ((static_branch_unlikely(&init_on_alloc) ||
 	     static_branch_unlikely(&init_on_free)) &&
-	    (slub_debug & SLAB_POISON)) {
-		pr_warn("mem auto-init: SLAB_POISON will take precedence over init_on_alloc/init_on_free\n");
-	}
+	    (slub_debug & SLAB_POISON))
+		pr_info("mem auto-init: SLAB_POISON will take precedence over init_on_alloc/init_on_free\n");
 	return 1;
 }
 
_

