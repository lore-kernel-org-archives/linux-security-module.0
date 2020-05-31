Return-Path: <SRS0=UHBo=7N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F210C433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1CF2074B
	for <linux-security-module@archiver.kernel.org>; Sun, 31 May 2020 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eavx3EOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgEaQtq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 31 May 2020 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQtq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 31 May 2020 12:49:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C3C061A0E;
        Sun, 31 May 2020 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zHI8YcI5KuBim4k22BPcPxAPjXUnIAezF8YZZy2PJq0=; b=Eavx3EObjthDo3toch0NT8OIoy
        QI9zoKzoDzyBHmP4/jCwVL2nb7pLPV5kO2hqmhiGeGWekVqEWX/KRL/dFJgCXyptxZDk24eHF0Uw0
        tpOS98Gl8uy64T8aUAwiPoAPhFiNdcWc19hOPco1TNGG0b2BijsFaZYwmsJ1I6svpSYc4P+I7Ng8U
        1Kbx60T6aWt3XOz04iWot+4a2rrjbkuQ7qmPos7xZ8CKhVTB7XfOWY8r9S56ojHO3T0rJAWOg1W+0
        jC/O7TIPSrvdSwKMkZ48CXsttpRe3cHKNaiudKs9A4X6hsbhMg4oXDxS/BwOwqdbYrP0eLgC681Lw
        6WNPaDKg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jfR9W-0007y1-QP; Sun, 31 May 2020 16:49:38 +0000
Date:   Sun, 31 May 2020 09:49:38 -0700
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
Message-ID: <20200531164938.GF19604@bombadil.infradead.org>
References: <20200530055953.817666-1-krisman@collabora.com>
 <202005300923.B245392C@keescook>
 <851rn0ejg9.fsf@collabora.com>
 <9a512096-7707-3fc6-34ba-22f969c0f964@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a512096-7707-3fc6-34ba-22f969c0f964@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, May 31, 2020 at 03:39:33PM +0300, Paul Gofman wrote:
> > Paul (cc'ed) is the wine expert, but my understanding is that memory
> > allocation and initial program load of the emulated binary will go
> > through wine.  It does the allocation and mark the vma accordingly
> > before returning the allocated range to the windows application.
> Yes, exactly. Pretty much any memory allocation which Wine does needs
> syscalls (if those are ever encountered later during executing code from
> those areas) to be trapped by Wine and passed to Wine's implementation
> of the corresponding Windows API function. Linux native libraries
> loading and memory allocations performed by them go outside of Wine control.

I don't like Gabriel's approach very much.  Could we do something like
issue a syscall before executing a Windows region and then issue another
syscall when exiting?  If so, we could switch the syscall entry point (ie
change MSR_LSTAR).  I'm thinking something like a personality() syscall.
But maybe that would be too high an overhead.

