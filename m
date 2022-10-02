Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B8C433FE
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Oct 2022 11:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJBLf7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 2 Oct 2022 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJBLf6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 2 Oct 2022 07:35:58 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C3C33E21
        for <linux-security-module@vger.kernel.org>; Sun,  2 Oct 2022 04:35:56 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 38C6B3F158;
        Sun,  2 Oct 2022 11:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664710554;
        bh=i05npNUv8AxjzmFIhx4Pi/dxS4BApxW1IpkftrzrgEs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=cwKKxaDywzDqU9ZWiUUc7YzoSk0qlrYfZKvn0fKFRnkaN30i4p7oUKIBp5JI7Edw0
         8ULAZwfQ4isx9K8qrq3POABZutIFlaKhtcHOiI+TC6udSzv5H0MK2bwvk2uxxyh7o7
         eJd0zs1kk4xezSZRDvYOkj+Wy8Pw7vhpXG6LDERTm38vTR5L7sGMS3TbcKGHq3kL+R
         kR7EpONygj3X3AZsW7jbneMMxSaXtlSTMWPZk9+RQJ7uD6t5MC46mp83R+9dWYUXx3
         vthBh+hljN5mGzXFtloBg+BeAib1Mq/j+J7oGE7j1NkxXVL7ug92I/eVienIr+7J6c
         B3aqbOdQL8xfQ==
Message-ID: <3e77ba53-c93a-8361-4125-115d14094b50@canonical.com>
Date:   Sun, 2 Oct 2022 04:35:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] apparmor: remove useless static inline functions
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20220926022839.1504520-1-cuigaosheng1@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220926022839.1504520-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/25/22 19:28, Gaosheng Cui wrote:
> Remove the following useless static inline functions:
> 
> 1. label_is_visible() is a static function in
> security/apparmor/label.c, and it's not used, aa_ns_visible()
> can do the same things as it, so it's redundant.
> 
> 2. is_deleted() is a static function in security/apparmor/file.c,
> and it's not used since commit aebd873e8d3e ("apparmor: refactor
> path name lookup and permission checks around labels"), so it's
> redundant.
> 
> They are redundant, so remove them.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Acked-by: John.johansen@canonical.com

I have pulled this into my tree

> ---
>   security/apparmor/file.c  | 13 -------------
>   security/apparmor/label.c |  6 ------
>   2 files changed, 19 deletions(-)
> 
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index e1b7e93602e4..ee43c48b9c3f 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -141,19 +141,6 @@ int aa_audit_file(struct aa_profile *profile, struct aa_perms *perms,
>   	return aa_audit(type, profile, &sa, file_audit_cb);
>   }
>   
> -/**
> - * is_deleted - test if a file has been completely unlinked
> - * @dentry: dentry of file to test for deletion  (NOT NULL)
> - *
> - * Returns: true if deleted else false
> - */
> -static inline bool is_deleted(struct dentry *dentry)
> -{
> -	if (d_unlinked(dentry) && d_backing_inode(dentry)->i_nlink == 0)
> -		return true;
> -	return false;
> -}
> -
>   static int path_name(const char *op, struct aa_label *label,
>   		     const struct path *path, int flags, char *buffer,
>   		     const char **name, struct path_cond *cond, u32 request)
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 0f36ee907438..cd2d0242df91 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1254,12 +1254,6 @@ struct aa_label *aa_label_merge(struct aa_label *a, struct aa_label *b,
>   	return label;
>   }
>   
> -static inline bool label_is_visible(struct aa_profile *profile,
> -				    struct aa_label *label)
> -{
> -	return aa_ns_visible(profile->ns, labels_ns(label), true);
> -}
> -
>   /* match a profile and its associated ns component if needed
>    * Assumes visibility test has already been done.
>    * If a subns profile is not to be matched should be prescreened with

