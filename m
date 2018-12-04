Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B03DC04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F4020851
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9YrgIJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F4020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLDJWS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:22:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDJWS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u1sDauWBoW0m/iXAgEl2s6GDpZaVeczcV0scpQbiW00=; b=a9YrgIJOzqMw3RL607o0ChWUl
        ol5ZNAUhEsqXKKmBskq7t14m1F2Jy4OqFbACHKiTp4GxiBnMXTwQBRSEXyZz1A8lrQvPyTbzTcA93
        TScTDepR8dqkzGoD2YPvIYrUlbKdTjS6vaPlVudbJFLo9kWrXcmzGa+iFR9YJAv/ksW+L4eKbULqK
        /XYg5vKV8qw0hIO4rjqkhQko7yz0ZvT5VBsYSP0EdNpDHzJZ8C+Pv1auVMFEwOVizwdNjkMBkvz2c
        VXZjrhMr3oAanqYkLQ+9FJz0G9nO1RafWIWHVIOSG5Oo1x7j5z+kJMKPHxUcIu76sfVu1WCrFlST8
        aC4cK/sWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU6uB-0008PS-9q; Tue, 04 Dec 2018 09:22:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 079DB2029FD58; Tue,  4 Dec 2018 10:22:10 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:22:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 12/13] keys/mktme: Save MKTME data if kernel cmdline
 parameter allows
Message-ID: <20181204092209.GS11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:39:59PM -0800, Alison Schofield wrote:
> Change-Id: If57414862f1ac131dd97e29bf4f3937ac33777f6

Does not belong in patches..
