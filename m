Return-Path: <SRS0=MF6I=UR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC3C31E5D
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3721A2082C
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560844047;
	bh=D6idtN2vuJNZSoRrBJEbsCDVqnmpSZdTylzmezC3ViA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bGrkyYKfqRBvi+su5ZXBYcs8wWrnJN3Uwz1iF/EOzfuS4a4V2z1Yn/c0mjg+el8ak
	 TmhgS5hTONCbCnuporJ6dod8uKQ50aqZWdNo0IcSKa4zIYft6ov7ZVoC4Wjw1kNrh+
	 Bq2Km6xialNP0ppjT62jzDq9qMWTtNAMUyEmJ1SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfFRHr0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfFRHrX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jun 2019 03:47:23 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 097272084D;
        Tue, 18 Jun 2019 05:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560835173;
        bh=D6idtN2vuJNZSoRrBJEbsCDVqnmpSZdTylzmezC3ViA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zpPILBBCAqMR9mMbYvimRhFwP9kZjL2AU5MfjZJzY+WvSEkteYVoW+sbq7pdcFPzw
         7gcuAso+EV/aRtthzZDjhBmjrmxqfdLWq9frm+edibB8kMEZifuHcKNvThHI+539eX
         cWp7GyxgMkZgpW/SDbOJ6lRDGCDBgF5xmFGDc2Io=
Date:   Mon, 17 Jun 2019 22:19:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
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
        Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-Id: <20190617221932.7406c74b6a8114a406984b70@linux-foundation.org>
In-Reply-To: <201906172157.8E88196@keescook>
References: <20190617151050.92663-1-glider@google.com>
        <20190617151050.92663-2-glider@google.com>
        <20190617151027.6422016d74a7dc4c7a562fc6@linux-foundation.org>
        <201906172157.8E88196@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 17 Jun 2019 22:07:41 -0700 Kees Cook <keescook@chromium.org> wrote:

> This is expected to be on-by-default on Android and Chrome
> OS. And it gives the opportunity for anyone else to use it under distros
> too via the boot args. (The init_on_free feature is regularly requested
> by folks where memory forensics is included in their thread models.)

Thanks.  I added the above to the changelog.  I assumed s/thread/threat/
