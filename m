Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA511C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 09:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFB72082B
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glMkjPMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFB72082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeLEJHr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:07:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEJHq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 04:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7yVJL47kBqGJdE8DAuowqL93Ob44ZzGTMiHOoWV0uow=; b=glMkjPMUoX6eHjcSqpk9F17Z5
        rf4kNv+e3Sk2u4AvsFHyXWtvjGpAvy0i/QcFUS/w05gDOhBGnpilRbOSlXLE92XNjYTypYrZOJR1t
        cX/6pTdq2p8GW6R3LZb/dHjmzZCfSuvM/6eDPMpRfcErcNLJfob3RimmZsGrbc5qLMXaIe/+NdP2S
        L9R6bsfK15qNuWSaiUc7apgp6hOJ9A16ICBonzvxHs2KSZfSet2djMzhkWHICQ3zOztf4I5U+DH67
        7VKb6pKyEdVj4VUgJFLkX19Lf+p/cJPZIe5mKiL+1gp5aoDOM0v8/kE23/YpIBDcjYkVIA6/6gLP7
        nMas3DK7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUT9c-0006rl-5Z; Wed, 05 Dec 2018 09:07:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 171F82029FD58; Wed,  5 Dec 2018 10:07:34 +0100 (CET)
Date:   Wed, 5 Dec 2018 10:07:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 09/13] mm: Restrict memory encryption to anonymous VMA's
Message-ID: <20181205090734.GA4234@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
 <20181204091044.GP11614@hirez.programming.kicks-ass.net>
 <20181205053020.GB18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205053020.GB18596@alison-desk.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 04, 2018 at 09:30:20PM -0800, Alison Schofield wrote:
> On Tue, Dec 04, 2018 at 10:10:44AM +0100, Peter Zijlstra wrote:
> > > + * Encrypted mprotect is only supported on anonymous mappings.
> > > + * All VMA's in the requested range must be anonymous. If this
> > > + * test fails on any single VMA, the entire mprotect request fails.
> > > + */
> > > +bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)
> > 
> > That's a 'weird' interface and cannot do what the comment says it should
> > do.
> 
> More please? With MKTME, only anonymous memory supports encryption.
> Is it the naming that's weird, or you don't see it doing what it says?

It's weird because you don't fully speficy the range -- ie. it cannot
verify the vma argument. It is also weird because the start and end are
not of the same type -- or rather, there is no start at all.

So while the comment talks about a range, there is not in fact a range
(only the implied @start is somewhere inside @vma). The comment also
states all vmas in the range, but again, because of a lack of range
specification it cannot verify this statement.

Now, I don't necessarily object to the function and its implementation,
but that comment is just plain misleading.
