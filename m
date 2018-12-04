Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F1C04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 08:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1BE208A3
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 08:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zobwJ6y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1BE208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbeLDI64 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:58:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48112 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLDI64 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 03:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MQO1YVInH9wIY5t210mUa02/v7SfTDJsUahoomOQw3w=; b=zobwJ6y8oeksnGEmQ52+HKQsG
        TnC3xj0O+C9HrRy1elu45l400v3nnbmlQFsmLGCJWLXZQQfkmpzLNEGi4MJIj3piHKSuutHkPRLgF
        SSMlO0ifSnV/v7DvUU24/IZdxEJ9aBjNMdP4CsO0pQ7VvPk6F/16bXXHx41V6J32HsX5TiNHQvrQo
        yq7kWiZiyCip+j5DaBci8BVKbc26DHrFwFKxst7aoVaFAfs2qIWljxFKV39ci0ACeHLMGMfhlisiL
        CNl9cp4vNLzrFI4xAM35T76rjgESYkfnkNcw0Dbbljb4AQdpk4a/+fzWTPDOkC6Hsz/COMpCcLCEz
        w6hary+1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU6XP-0008JK-2e; Tue, 04 Dec 2018 08:58:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04ABD2029FD58; Tue,  4 Dec 2018 09:58:35 +0100 (CET)
Date:   Tue, 4 Dec 2018 09:58:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [RFC v2 07/13] x86/mm: Add helpers for reference counting
 encrypted VMAs
Message-ID: <20181204085835.GO11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <e4407d95c74300c4a6b4c5f9321660e9097fff8f.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4407d95c74300c4a6b4c5f9321660e9097fff8f.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:39:54PM -0800, Alison Schofield wrote:

> +void vma_put_encrypt_ref(struct vm_area_struct *vma)
> +{
> +	if (vma_keyid(vma))
> +		if (refcount_dec_and_test(&encrypt_count[vma_keyid(vma)])) {
> +			mktme_map_lock();
> +			mktme_map_free_keyid(vma_keyid(vma));
> +			mktme_map_unlock();
> +		}

This violates CodingStyle

> +}

> +void key_put_encrypt_ref(int keyid)
> +{
> +	if (refcount_dec_and_test(&encrypt_count[keyid])) {
> +		mktme_map_lock();

That smells like it wants to use refcount_dec_and_lock() instead.

> +		mktme_map_free_keyid(keyid);
> +		mktme_map_unlock();
> +	}
> +}

Also, if you write that like:

	if (!refcount_dec_and_lock(&encrypt_count[keyid], &lock))
		return;

you loose an indent level.
