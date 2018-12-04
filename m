Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60632C04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2CC2082B
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3Uop85m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2CC2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeLDJOr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:14:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJOr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vZqQHn/o6aunIITRm85lV7F/dqkbgDiMwIT59mJUSi8=; b=t3Uop85mPytBiNpATTzG/a/lq
        PKGHzn9R4sBQ0qb1JYf9IrwNmVJyvhhpu2F/AIb6zG9GzBz6gnpjxpAiX7/2OCM9h9Xyc+uz4EgO6
        L79T5ackpAR5bU8w8I9LjOjI9UGTALwcpEsLXL8YvwhBKq1fXTP65szCffGQuJqrt20PzV0Y1Bgjo
        rL5jL8cKzcQWYu4xpsknppRBwG03yUyWvB8Zwx9OuVrANhtb26LrzD5wmkmr+xC9jBjTOcr5c836t
        +MdBFSdDfnupEyQdY0SXpHWPKL5ZS8bnGjgYxGIwIecwsLSJaBlGMQtRvbrWGD3q3IFrdhfK7iwPc
        bp2t5lnuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU6mp-0008NC-Jq; Tue, 04 Dec 2018 09:14:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50F3C2029FD58; Tue,  4 Dec 2018 10:14:34 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:14:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory
 encryption keys
Message-ID: <20181204091434.GQ11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:39:51PM -0800, Alison Schofield wrote:
> +int mktme_map_keyid_from_key(void *key)
> +{
> +	int i;
> +
> +	for (i = 1; i <= mktme_nr_keyids; i++)
> +		if (mktme_map->key[i] == key)
> +			return i;

CodingStyle

> +	return 0;
> +}
> +int mktme_map_get_free_keyid(void)
> +{
> +	int i;
> +
> +	if (mktme_map->mapped_keyids < mktme_nr_keyids) {
> +		for (i = 1; i <= mktme_nr_keyids; i++)
> +			if (mktme_map->key[i] == 0)
> +				return i;

CodingStyle

> +	}
> +	return 0;
> +}
