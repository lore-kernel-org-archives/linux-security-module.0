Return-Path: <SRS0=UcS9=VB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EBCC0651F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jul 2019 19:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0DA218A3
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jul 2019 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562270032;
	bh=D8dJJX8KT2Xl8Nh7bMvZgekUUmiAou9NFBVZsil11Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BU8ZksWGGstkjBzlswPalgVdcofE4ceVgnXco9ME66v5ch714kHmb9VPffIcPoQtC
	 rmgUdX7T/1FMNYG81B8VGFZL1ptxz1Yk/1tBfxQ+vYM0n0EiVd3qrBi5g5NbYhPWRh
	 /IKnwFy+bIwud5BixGTYdA33FbD/GJHH/rBTYh9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGDTxw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Jul 2019 15:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfGDTxv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Jul 2019 15:53:51 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBADA21852;
        Thu,  4 Jul 2019 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562270030;
        bh=D8dJJX8KT2Xl8Nh7bMvZgekUUmiAou9NFBVZsil11Lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YrQuDPw+rga1xtwxOX16kcC0a03XtrEZuxO6OMtfMYRlXCWQXEwoRhtzXiTaMi7UH
         aY85ep5KDVRdkbbC3GGx6CKhK/VzlWNWBObEqB0mE5xBp8a7JvEcKmCN57ocm/RBNl
         1jkz+TotL/QtoBgpN+wyIXo03MdfNEnor9UGm1Tk=
Date:   Thu, 4 Jul 2019 12:53:49 -0700
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
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v10 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-Id: <20190704125349.0dd001629a9c4b8e4cb9f227@linux-foundation.org>
In-Reply-To: <CAG_fn=XYRpeBgLpbwhaF=JfNHa-styydOKq8_SA3vsdMcXNgzw@mail.gmail.com>
References: <20190628093131.199499-1-glider@google.com>
        <20190628093131.199499-2-glider@google.com>
        <20190702155915.ab5e7053e5c0d49e84c6ed67@linux-foundation.org>
        <CAG_fn=XYRpeBgLpbwhaF=JfNHa-styydOKq8_SA3vsdMcXNgzw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 3 Jul 2019 13:40:26 +0200 Alexander Potapenko <glider@google.com> wrote:

> > There are unchangelogged alterations between v9 and v10.  The
> > replacement of IS_ENABLED(CONFIG_PAGE_POISONING)) with
> > page_poisoning_enabled().
> In the case I send another version of the patch, do I need to
> retroactively add them to the changelog?

I don't think the world could stand another version ;)

Please simply explain this change for the reviewers?
