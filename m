Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FFDC04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291BD20666
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w1XP3vDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291BD20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbeLDJK6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:10:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeLDJK6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 04:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f7MpDqqQD2Al3j071MXBTnpquIzEfRe2bDyHk05Ku/g=; b=w1XP3vDmlviwzryrBXZ6b1quM
        9DlX+mcRzu4O1zbtP0x6SpK4mLfdLQlfVbDf15/cJ9rME4dOoGdbii0mHgbJFqvLdtedsPPDZXLEV
        yQNUjRFpGs6tH9xXb/e+0C1dQhHofjJ7ZS4KbIlYMp+R/kAH7AHDuUjpFbhddGuke4KTsxOUkDFRw
        qzTNvMD+XvZNi+tH1BypmGpUt9xEB3j8v/lYavFYfb3idyu2fc68xlhpTe0hc6N+OcvwYxxQIxomU
        KUmOk2HqZdvM55FTHXZ0TusBVgPQ9BTWHMCbHwmfleB3tR8VTLCqza5sFlL9JOb2Z0tcNiEJ8LrwC
        dCOuq7KLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU6j7-0008M8-RY; Tue, 04 Dec 2018 09:10:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E16D2029FD58; Tue,  4 Dec 2018 10:10:44 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:10:44 +0100
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
Message-ID: <20181204091044.GP11614@hirez.programming.kicks-ass.net>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 03, 2018 at 11:39:56PM -0800, Alison Schofield wrote:
> Memory encryption is only supported for mappings that are ANONYMOUS.
> Test the entire range of VMA's in an encrypt_mprotect() request to
> make sure they all meet that requirement before encrypting any.
> 
> The encrypt_mprotect syscall will return -EINVAL and will not encrypt
> any VMA's if this check fails.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

That SoB doesn't make sense; per the From you wrote the patch and signed
off on it, wth is Kirill's SoB doing there?

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ad8127dc9aac..f1c009409134 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -345,6 +345,24 @@ static int prot_none_walk(struct vm_area_struct *vma, unsigned long start,
>  	return walk_page_range(start, end, &prot_none_walk);
>  }
>  
> +/*
> + * Encrypted mprotect is only supported on anonymous mappings.
> + * All VMA's in the requested range must be anonymous. If this
> + * test fails on any single VMA, the entire mprotect request fails.
> + */
> +bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)

That's a 'weird' interface and cannot do what the comment says it should
do.

> +{
> +	struct vm_area_struct *test_vma = vma;

That variable is utterly pointless.

> +	do {
> +		if (!vma_is_anonymous(test_vma))
> +			return false;
> +
> +		test_vma = test_vma->vm_next;
> +	} while (test_vma && test_vma->vm_start < end);
> +	return true;
> +}
