Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3A1C4338F
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jul 2021 23:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2065B60EBD
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jul 2021 23:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhG3XZG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Jul 2021 19:25:06 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:38584
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233500AbhG3XZG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Jul 2021 19:25:06 -0400
Received: from [192.168.192.153] (unknown [50.53.57.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BD8333F0B9;
        Fri, 30 Jul 2021 23:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627687499;
        bh=R2NzCKKbyRjZX2qftJHyl3+a3Qvsi60rhgsy0EBiLdU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=qCjCqQe+AR3SYMVkzD5FHOL3Hgcyd2Gmjtcbk6UTTQqFajgm+oF26shEi4YFCMntw
         WuvcZG9ULRWh2yHqtybWEj0Lp6eT8JyN7hkJckTUTZX0mslW2yzR1pt18TmwpWgrfF
         RhFzUr/dxsxa1aazt1X9VxFcVoV7xwe5GO339bfuQYp7SmNjrNz40RMotnhegRqUwt
         TGQKyBedoJ8p4AkzUSE21wD1ywyO0O9K681Qa2FMI779q6Y4Ri3sLOpa+c3ImdIjAF
         csOhu7j5Z+uP6wV8qP19hzZNsQm+ID4TLSvzaZs1HczbV3DEmeY9SnZV3i5zfhmvS6
         dA7oh3n+nxn5g==
Subject: Re: [PATCH] apparmor: use per file locks for transactional queries
To:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20210730052355.77289-1-someguy@effective-light.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <de92defa-13f5-6226-10f7-8f182efcfd8e@canonical.com>
Date:   Fri, 30 Jul 2021 16:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730052355.77289-1-someguy@effective-light.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/29/21 10:23 PM, Hamza Mahfooz wrote:
> As made mention of in commit 1dea3b41e84c5 ("apparmor: speed up
> transactional queries"), a single lock is currently used to synchronize
> transactional queries. We can, use the lock allocated for each file by
> VFS instead.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I'll pull this into my tree asap

> ---
>  security/apparmor/apparmorfs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 2ee3b3d29f10..c0b626a271a0 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -812,8 +812,6 @@ struct multi_transaction {
>  };
>  
>  #define MULTI_TRANSACTION_LIMIT (PAGE_SIZE - sizeof(struct multi_transaction))
> -/* TODO: replace with per file lock */
> -static DEFINE_SPINLOCK(multi_transaction_lock);
>  
>  static void multi_transaction_kref(struct kref *kref)
>  {
> @@ -847,10 +845,10 @@ static void multi_transaction_set(struct file *file,
>  	AA_BUG(n > MULTI_TRANSACTION_LIMIT);
>  
>  	new->size = n;
> -	spin_lock(&multi_transaction_lock);
> +	spin_lock(&file->f_lock);
>  	old = (struct multi_transaction *) file->private_data;
>  	file->private_data = new;
> -	spin_unlock(&multi_transaction_lock);
> +	spin_unlock(&file->f_lock);
>  	put_multi_transaction(old);
>  }
>  
> @@ -879,9 +877,10 @@ static ssize_t multi_transaction_read(struct file *file, char __user *buf,
>  	struct multi_transaction *t;
>  	ssize_t ret;
>  
> -	spin_lock(&multi_transaction_lock);
> +	spin_lock(&file->f_lock);
>  	t = get_multi_transaction(file->private_data);
> -	spin_unlock(&multi_transaction_lock);
> +	spin_unlock(&file->f_lock);
> +
>  	if (!t)
>  		return 0;
>  
> 

