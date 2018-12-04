Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9851CC04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAF420851
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CQvx00SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAF420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeLDJZ5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:25:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJZ5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TLzleUrvqTkZJtbVUO3xO7uLEVsze/XQ2A0+ux7KwYo=; b=CQvx00SRDuRvXlZfqrkkiFZCq
        3gvVcfZrHsC34GysoePiTPV4mWDPMffefZvlHZJdhf5syQflV8VdPq+IvibHlQl7Bk5W24X2EpBJX
        EzucrvPjElxvDFH9yi2YS46ytZXk23vcBU2zK8wma+tXLImGykvC3Ep+mJ/DpWFxGZRfNJngyE2Mv
        71cDIFz6HERFPAu9Fv9nmWUYz21E76yBcK53L3u8NV+0xUw2pLe3r2u83+5qFw/GQ60ATUXyZVast
        Jr9c5Mg9ZgspwZKWPYa/smzzmjtjf6QQbxt00gh2/p9pyqe1pcgJwcg/bXoi2gttktZ3BhMrODQ9O
        VN8o3v2HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU6xk-0007pF-2t; Tue, 04 Dec 2018 09:25:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32F962029FD58; Tue,  4 Dec 2018 10:25:50 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:25:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-ID: <20181204092550.GT11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:39:47PM -0800, Alison Schofield wrote:
> (Multi-Key Total Memory Encryption)

I think that MKTME is a horrible name, and doesn't appear to accurately
describe what it does either. Specifically the 'total' seems out of
place, it doesn't require all memory to be encrypted.
