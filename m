Return-Path: <SRS0=MGza=UZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B2DC48BD3
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 23:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4329217D8
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 23:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561591718;
	bh=bvxU9GtnxrSS6JL5vSuxzibwl2B9AdNA5bQBLj2CaHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lAmvs+E62spXBmFeJBsW4XtTVUvrpbXXkDKM8sn4qud6XHQtybv2+NczkifmRdmam
	 p5Ef/ExZHnRHrR9NkbDhrLsMAKi34TcoMLYTf8B7+Dq3g0rqhYiCRpMyN3/r7Soifg
	 wMFfLn92BuwRxp1KISWiKFPps/4arqMMJQefEkLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFZX2i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfFZX2h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 19:28:37 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11ECE214DA;
        Wed, 26 Jun 2019 23:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561591716;
        bh=bvxU9GtnxrSS6JL5vSuxzibwl2B9AdNA5bQBLj2CaHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zmegpjl0RaiGNlS93NVud3hTVj0twmtsxSir+O4KVOYh5+Vxzeaoc1YAvUKF3f2na
         9F1F4ANmd9ITzobFe0KSzL85XYPqL1ZmzSjigvfJe/ej50so4Sd4RwAxntdbVjEX1/
         h3edJ8Doi2xX1X0wWnUsOQrr70SVJqduegIQBWf4=
Date:   Wed, 26 Jun 2019 16:28:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-Id: <20190626162835.0947684d36ef01639f969232@linux-foundation.org>
In-Reply-To: <20190626121943.131390-2-glider@google.com>
References: <20190626121943.131390-1-glider@google.com>
        <20190626121943.131390-2-glider@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 26 Jun 2019 14:19:42 +0200 Alexander Potapenko <glider@google.com> wrote:

>  v8:
>   - addressed comments by Michal Hocko: revert kernel/kexec_core.c and
>     apply initialization in dma_pool_free()
>   - disable init_on_alloc/init_on_free if slab poisoning or page
>     poisoning are enabled, as requested by Qian Cai
>   - skip the redzone when initializing a freed heap object, as requested
>     by Qian Cai and Kees Cook
>   - use s->offset to address the freeptr (suggested by Kees Cook)
>   - updated the patch description, added Signed-off-by: tag

v8 failed to incorporate 

https://ozlabs.org/~akpm/mmots/broken-out/mm-security-introduce-init_on_alloc=1-and-init_on_free=1-boot-options-fix.patch
and
https://ozlabs.org/~akpm/mmots/broken-out/mm-security-introduce-init_on_alloc=1-and-init_on_free=1-boot-options-fix-2.patch

it's conventional to incorporate such fixes when preparing a new
version of a patch.

