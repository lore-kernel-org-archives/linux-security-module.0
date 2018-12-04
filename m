Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C662C04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AE220851
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rplx13xM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AE220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbeLDJ2t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:28:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDJ2t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zA2CW6J0hjM8++/ql45mRH3ARt2uvvKd0sIHHU06/Pk=; b=Rplx13xMKkQwapvUL65qC93jX
        09zaptiQmjy9FqwRgYp5lK4gH6saNLA83aWa9raEOQUlF/ozBkN3hw4NwxJCplYiUS9vLlikqVvtM
        YTh9E6Qn9Uy+nD8GU8bJXj6+7NYY7ix9apSd/ie3uHl/3M2juXDEme11ctfYmrbvbKTpvCqhbj055
        +ujzCkPj6dDrvZ7hYMWV7wQG8QKEso0zWQ/NxYbrqfuBxk35B7Vh8TwtiCFlUPWzkkxrt895eFRBV
        74BMs2iFDNaLJeKWyg2zj3wmyOSpZEI4v12kCZfOiOkxY67SwT9Vt3ceryJze0zTm4ShUzwC2s4aq
        McsD2yJ3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU70V-0008Ua-DM; Tue, 04 Dec 2018 09:28:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D54692029FD58; Tue,  4 Dec 2018 10:28:41 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:28:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 13/13] keys/mktme: Support CPU Hotplug for MKTME keys
Message-ID: <20181204092841.GU11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:40:00PM -0800, Alison Schofield wrote:
> +	for_each_online_cpu(online_cpu)
> +		if (online_cpu != cpu &&
> +		    pkgid == topology_physical_package_id(online_cpu)) {
> +			cpumask_set_cpu(online_cpu, mktme_leadcpus);
> +			break;
> +	}

That's a capital offence right there.
