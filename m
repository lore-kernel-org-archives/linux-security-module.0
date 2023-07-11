Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C10EEB64DC
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Jul 2023 04:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGKEij (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Jul 2023 00:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGKEiL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Jul 2023 00:38:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1251C19B2;
        Mon, 10 Jul 2023 21:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=EdZ/uI9qEwSebLzEX2gijde/kmiXWuENRx/hQGoNyQs=; b=bZGfDyB6ARAb7eAafVcUwJEw/8
        O0K10BGUXBHmkcX7IQElvT2MaalAh35WE0rV/K/Sj7ZWJcRJpDRta8k+OMEUvpE0tEaJpK0pwM7dZ
        UdvV/AdAXVc0ozxsuVwf2FPnF9e5t1MBk9QPQKHC+d0LnPfSyoQqoSMepaku0PtCmVzv0d56J7jTE
        szn1ytkfG+teoWv2RROvOH48Gc2wEWx6LzftYP2Y/9Hcr/5018zgFlPIK1bg0dCaLwQgs3TXeAT/S
        8p/gzAZ9lmZJg2weW5nRQVbVTr2zozXiZy9h2nGGPXh8Q5lktsU2TgHC6wE8jwU6ICl2SweMAJMKW
        gsn5OjVA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ57f-00De3B-0l;
        Tue, 11 Jul 2023 04:37:11 +0000
Message-ID: <ab6ab3d2-d168-8c10-b7f5-94a669e212fc@infradead.org>
Date:   Mon, 10 Jul 2023 21:37:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/13] Add TSEM specific documentation.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-3-greg@enjellic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230710102319.19716-3-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi--

On 7/10/23 03:23, Dr. Greg wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..0e6640a78936 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6468,6 +6468,24 @@
>  			with CPUID.16h support and partial CPUID.15h support.
>  			Format: <unsigned int>
>  

These 3 entries should be in alphabetical order: tsem_cache, tsem_digest, tsem_mode.

> +	tsem_mode=	[TSEM] Set the mode that the Trusted Security Event
> +			Modeling LSM is to run in.
> +			Format: 1
> +			1 -- Disable root domain modeling.
> +
> +	tsem_cache=	[TSEM] Define the size of the caches used to hold
> +			pointers to structures that will be used to model
> +			security events occurring in the root modeling
> +			namespace that are called in atomic context.
> +			Format: <integer>
> +			Default: 96

What unit?  KB, MB, bytes, pages?

> +
> +	tsem_digest=	[TSEM] Define the cryptographic hash function that
> +			will be used to create security event coefficients
> +			for in the root modeling namespace.

			for in
?

> +			Format: {name of the cryptographic hash function}
> +			Default: sha256

-- 
~Randy
