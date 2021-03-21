Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2424AC433DB
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 05:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D248561929
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 05:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCUFrq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Mar 2021 01:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCUFr1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Mar 2021 01:47:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A63C061574;
        Sat, 20 Mar 2021 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2rYY5m91Uk0WpY8ivu01sa3Z6BkSgmUTA+3bdWhH+cA=; b=zqSX3zxAC+R45kNnjXAceCvsNx
        9JSetYSeBm9xwcD5HoLGW2qR/gxLt/StPV0wCcj28cXsKODtB5h/nVIxGY/MlY+sHzHSPyLL6twcU
        ledKGXVUAULqTKIy+9MEky7k/RIo3xSQAyjeJKGMJrCtJlymDdspgHuGWduQfVmNdZiMy96PpUlf/
        uhtXu7kA1ttG3R0s2Rs1G+ncPRG4TfeUhB5qOk+RjmOLr18pxWzyXE7WM7pWPEh85sOSIGuQzCIef
        5bWSKGFZuBC1ZYf4cuw87RYTlQiM5ZEfBH8MM3EiDLVgmyCee58o+zCqof3xlNocsjV+Q5HgEi1pW
        vMgRW02g==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNqvj-002BWW-7Q; Sun, 21 Mar 2021 05:47:16 +0000
Date:   Sat, 20 Mar 2021 22:47:15 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: A typo fix
In-Reply-To: <20210321033845.13735-1-unixbhaskar@gmail.com>
Message-ID: <1bc3b0b4-667b-399c-9ada-cea689101d5d@bombadil.infradead.org>
References: <20210321033845.13735-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_224715_291244_D5CFB8B1 
X-CRM114-Status: GOOD (  11.44  )
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/programers/programmers/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> security/lsm_audit.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 82ce14933513..ddcf572105be 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -212,7 +212,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> 	char comm[sizeof(current->comm)];
>
> 	/*
> -	 * To keep stack sizes in check force programers to notice if they
> +	 * To keep stack sizes in check force programmers to notice if they
> 	 * start making this union too large!  See struct lsm_network_audit
> 	 * as an example of how to deal with large data.
> 	 */
> --
> 2.20.1
>
>
