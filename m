Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D45C433C1
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB3B61994
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCWNi1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:38:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62486 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCWNiJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Mar 2021 09:38:09 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12NDbhpU068304;
        Tue, 23 Mar 2021 22:37:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Tue, 23 Mar 2021 22:37:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12NDbhwX068290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 Mar 2021 22:37:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
 <20210319200358.22816-2-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
 <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
 <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
 <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
Date:   Tue, 23 Mar 2021 22:37:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/03/23 21:09, Mimi Zohar wrote:
> Please take a look at the newer version of this patch.   Do you want to
> add any tags?

Oh, I didn't know that you already posted the newer version.

> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 1d20003243c3..0ba01847e836 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -98,6 +98,14 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>  	struct rb_node *node, *parent = NULL;
>  	struct integrity_iint_cache *iint, *test_iint;
>  
> +	/*
> +	 * The integrity's "iint_cache" is initialized at security_init(),
> +	 * unless it is not included in the ordered list of LSMs enabled
> +	 * on the boot command line.
> +	 */
> +	if (!iint_cache)
> +		panic("%s: lsm=integrity required.\n", __func__);
> +

This looks strange. If "lsm=" parameter must include "integrity",
it implies that nobody is allowed to disable "integrity" at boot.
Then, why not unconditionally call integrity_iintcache_init() by
not counting on DEFINE_LSM(integrity) declaration?

>  	iint = integrity_iint_find(inode);
>  	if (iint)
>  		return iint;
> 

