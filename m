Return-Path: <SRS0=UHBo=7N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BCBC433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E89206E2
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 17:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3QBm8SS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgEaRcB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 31 May 2020 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgEaRcB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 31 May 2020 13:32:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12793C061A0E;
        Sun, 31 May 2020 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j209R3MIJNW0AmdXt4PuONxQE6mEpvM3Y45tjx0sIg8=; b=a3QBm8SS+gWyaXsiQwSf8fYdOG
        NucDt/msSaafhoTuXevyNBKu7wKLWpsYmIpBL8HluJTO9AYr7ezSYDFHgRx8w5flsTMlFv5XX2nsx
        1Hgr6+fd76mPBd1EOohPTEFANvw7HjFqMr9NpYZZCVKDSqc7VdJUV2jdp9t6S7Jw4HTn7UtDn14uh
        pzfXNvUck9G1+JZOw6c/NKoh8afnwG7SC01YDW7QrXwpNNMj9af3ByqUxVxi2dMlmGjV/xfkIDZq/
        mAc1Q1sghAipYSYngcp8n0XZJMuErJD13dJ5PuELRN/gvykQTWUpItzcQRgyAGgHEP/RHt4suuLkT
        ZSACtiHA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jfRoT-0007Ll-FD; Sun, 31 May 2020 17:31:57 +0000
Date:   Sun, 31 May 2020 10:31:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Paul Gofman <gofmanp@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-security-module@vger.kernel.org,
        Zebediah Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
Message-ID: <20200531173157.GG19604@bombadil.infradead.org>
References: <20200530055953.817666-1-krisman@collabora.com>
 <202005300923.B245392C@keescook>
 <851rn0ejg9.fsf@collabora.com>
 <9a512096-7707-3fc6-34ba-22f969c0f964@gmail.com>
 <20200531164938.GF19604@bombadil.infradead.org>
 <c007e3e9-e915-16f3-de31-c811ad37c44c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c007e3e9-e915-16f3-de31-c811ad37c44c@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, May 31, 2020 at 08:10:18PM +0300, Paul Gofman wrote:
> On 5/31/20 19:49, Matthew Wilcox wrote:
> > On Sun, May 31, 2020 at 03:39:33PM +0300, Paul Gofman wrote:
> >>> Paul (cc'ed) is the wine expert, but my understanding is that memory
> >>> allocation and initial program load of the emulated binary will go
> >>> through wine.  It does the allocation and mark the vma accordingly
> >>> before returning the allocated range to the windows application.
> >> Yes, exactly. Pretty much any memory allocation which Wine does needs
> >> syscalls (if those are ever encountered later during executing code from
> >> those areas) to be trapped by Wine and passed to Wine's implementation
> >> of the corresponding Windows API function. Linux native libraries
> >> loading and memory allocations performed by them go outside of Wine control.
> > I don't like Gabriel's approach very much.  Could we do something like
> > issue a syscall before executing a Windows region and then issue another
> > syscall when exiting?  If so, we could switch the syscall entry point (ie
> > change MSR_LSTAR).  I'm thinking something like a personality() syscall.
> > But maybe that would be too high an overhead.
>
> IIRC Gabriel had such idea that we discussed. We can potentially track
> the boundary between the Windows and native code exectution. But issuing
> syscall every time we cross that boundary may have a prohibitive
> performance impact, that happens way too often. What we could do is to
> put the flag somewhere, but that flag has to be per thread. E. g., we
> could use Linux gs: based thread local storage, or fs: based address
> (that's what Windows using for thread local data and thus Wine maintains
> also). If Seccomp filters could access such a memory location (fetch a
> byte from there and put into the structure accessible by BPF_LD) we
> could use SECCOMP_MODE_FILTER, I think.

If it's the cost of the syscall that's the problem, there are ways
around that.  We'd still want a personality() call to indicate that
the syscall handler should look (somewhere) to determine the current
personality, but that could be issued at the start of execution rather
than when we switch between Windows & Linux code.
