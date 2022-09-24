Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7245C07E9D
	for <linux-security-module@archiver.kernel.org>; Sat, 24 Sep 2022 09:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIXJVY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Sep 2022 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXJVX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Sep 2022 05:21:23 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2A12F758
        for <linux-security-module@vger.kernel.org>; Sat, 24 Sep 2022 02:21:23 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2B9943F121;
        Sat, 24 Sep 2022 09:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664011281;
        bh=o4c3l0kNYfnCILC+LMrCcqunU9BVFBwuA+Uw3QWtLmA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KplvA8MJ4AapHEy7QV5fKanMj4I6BnyLH/eW4wGYW0/8bQuT0oqTv0tLrA+KFyFPU
         zQW0L1bEyW/jYAE0gUS6RieFgH1FjewpCRru0h+4d056puLLG0k8ZMrAk3ggD9LvkD
         EKBcM2LRrTsJJxJG+6wd+kwGTOm43q8jqpul2w+KGEbo9GAMRIjZOirpsSnbR7+Vqd
         Oq15b3K9S1GWVZlLzFyCpFQIZoWxjKsTdeK6+fZHFg18YcbAuX0hnkyyuFLIP3lekS
         3gEKeHQZtNlFc6/ADWZn3FIjWDvRDahac6yLg9x4m5Eht4BNXzQE/Z2vlCUAraFZsB
         SlEubRXFwKxHw==
Message-ID: <b493f609-3dbd-77fd-8290-1e48eb0059f8@canonical.com>
Date:   Sat, 24 Sep 2022 02:21:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] apparmor: make __aa_path_perm() static
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20220914074607.194838-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220914074607.194838-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/14/22 00:46, Xiu Jianfeng wrote:
> Make __aa_path_perm() static as it's only used inside apparmor/file.c.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/file.c         | 6 +++---
>   security/apparmor/include/file.h | 3 ---
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index e1b7e93602e4..14f7d7ef3f54 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -265,9 +265,9 @@ unsigned int aa_str_perms(struct aa_dfa *dfa, unsigned int start,
>   	return state;
>   }
>   
> -int __aa_path_perm(const char *op, struct aa_profile *profile, const char *name,
> -		   u32 request, struct path_cond *cond, int flags,
> -		   struct aa_perms *perms)
> +static int __aa_path_perm(const char *op, struct aa_profile *profile, const char *name,
> +			  u32 request, struct path_cond *cond, int flags,
> +			  struct aa_perms *perms)
>   {
>   	int e = 0;
>   
> diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
> index 029cb20e322d..17dca3502230 100644
> --- a/security/apparmor/include/file.h
> +++ b/security/apparmor/include/file.h
> @@ -189,9 +189,6 @@ unsigned int aa_str_perms(struct aa_dfa *dfa, unsigned int start,
>   			  const char *name, struct path_cond *cond,
>   			  struct aa_perms *perms);
>   
> -int __aa_path_perm(const char *op, struct aa_profile *profile,
> -		   const char *name, u32 request, struct path_cond *cond,
> -		   int flags, struct aa_perms *perms);
>   int aa_path_perm(const char *op, struct aa_label *label,
>   		 const struct path *path, int flags, u32 request,
>   		 struct path_cond *cond);

