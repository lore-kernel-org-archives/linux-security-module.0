Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F0BC7EE23
	for <linux-security-module@archiver.kernel.org>; Wed, 31 May 2023 22:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjEaWM7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 May 2023 18:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjEaWM6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 May 2023 18:12:58 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC6E56;
        Wed, 31 May 2023 15:12:34 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 08D7A4025D;
        Wed, 31 May 2023 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685571144;
        bh=+nmIKvT8Ba+dN10imTlWRtRDyfWTnTxdKB1XxYUU3pk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=f27qCkFfqf3knIJRXDS4D3TcS6NUryEZpa0RCOkMFCOlMLc2YG4Zq+y2qbt6QK72O
         28JPjvDAfFiXWxv6Sj+IHjOCefAUS/8rmI1A6gOhI2lkxVxdmkwlGjpHvuKxON+xLD
         j2ca406SsQe+m6fvjxKYxAAJTL9TZYcV7tOhJzpLjGV9jd/2r/eZEr+v+FLpthkiPn
         e1QoHbeaaBskZcSGMtcMen9y7MOE9xiT6MCQSyzB70ssLo01nL1ql/lZDfWSk5Kttb
         6UaE873H19SvnW5eWSQEDjxzwiAzMC2XESVYnf+WwJd01+oXm0a059JhkmxGJYgc9o
         VP/gxWtc19WEA==
Message-ID: <202ffe3e-689f-d824-1f8c-c9f99835e0b5@canonical.com>
Date:   Wed, 31 May 2023 15:12:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] apparmor: remove unused macro
Content-Language: en-US
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
References: <20230531111833.144628-1-gongruiqi@huaweicloud.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230531111833.144628-1-gongruiqi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/31/23 04:18, GONG, Ruiqi wrote:
> SOCK_ctx() doesn't seem to be used anywhere in the code, so remove it.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I will pull this into the apparmor-next tree

> ---
>   security/apparmor/include/net.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
> index 6fa440b5daed..64a0112bf62d 100644
> --- a/security/apparmor/include/net.h
> +++ b/security/apparmor/include/net.h
> @@ -52,7 +52,6 @@ struct aa_sk_ctx {
>   };
>   
>   #define SK_CTX(X) ((X)->sk_security)
> -#define SOCK_ctx(X) SOCK_INODE(X)->i_security
>   #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
>   	struct lsm_network_audit NAME ## _net = { .sk = (SK),		  \
>   						  .family = (F)};	  \

