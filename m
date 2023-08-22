Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B645BEE49AB
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Aug 2023 19:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjHVTa1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjHVTa0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Aug 2023 15:30:26 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70443E53
        for <linux-security-module@vger.kernel.org>; Tue, 22 Aug 2023 12:30:16 -0700 (PDT)
Received: from [10.8.192.2] (unknown [50.47.144.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D90D8400FF;
        Tue, 22 Aug 2023 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692732615;
        bh=7UGJKiMwREX7/31Oko06508K+pkv6d1OnT5I882h52Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IDrLVBDyKuVt/8mIdzJXNDmAeO7EXxTvdChGCS4gN96FwdcRem3FwauyhmhbLejDq
         G4D9RcJtuYXZVg0A+lLb9RGxxZcb4laV5MPTbzdHOJpiVZtF3ZL2Gi0grTNI+x0eqr
         Cgwg9pVKICWEDG8x7ckVpnic10TZVhvy3eZxusRNuWfQblz4PzwkkelrVG4PBW+kpO
         CMHX8YLUsoaLZqw+JtmcN/UQNUWEzN3T8PLBnS5h0Gc8sq0K+9COK3qXOIvC5mYEcV
         eXTE1vvskO4A08eUZnnRCm9lqyCFN0917dMjBie2NGNH+l6+LnL9dH4yk/ezwCkOD8
         UcAicGcUvER0g==
Message-ID: <2ea99c70-1be1-c0bb-bf3c-ed65a25744de@canonical.com>
Date:   Tue, 22 Aug 2023 12:30:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] apparmor: remove unused functions in policy_ns.c/.h
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20230810201056.429575-1-xiujianfeng@huaweicloud.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230810201056.429575-1-xiujianfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/10/23 13:10, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> These functions are not used now, remove them.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: John Johansen <john.johansen@canonical.com>

this has pulled into apparmor-next-next so it will land
next cycle

> ---
>   security/apparmor/include/policy_ns.h | 14 ----------
>   security/apparmor/policy_ns.c         | 37 ---------------------------
>   2 files changed, 51 deletions(-)
> 
> diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
> index 33d665516fc1..d646070fd966 100644
> --- a/security/apparmor/include/policy_ns.h
> +++ b/security/apparmor/include/policy_ns.h
> @@ -86,10 +86,7 @@ const char *aa_ns_name(struct aa_ns *parent, struct aa_ns *child, bool subns);
>   void aa_free_ns(struct aa_ns *ns);
>   int aa_alloc_root_ns(void);
>   void aa_free_root_ns(void);
> -void aa_free_ns_kref(struct kref *kref);
>   
> -struct aa_ns *aa_find_ns(struct aa_ns *root, const char *name);
> -struct aa_ns *aa_findn_ns(struct aa_ns *root, const char *name, size_t n);
>   struct aa_ns *__aa_lookupn_ns(struct aa_ns *view, const char *hname, size_t n);
>   struct aa_ns *aa_lookupn_ns(struct aa_ns *view, const char *name, size_t n);
>   struct aa_ns *__aa_find_or_create_ns(struct aa_ns *parent, const char *name,
> @@ -151,15 +148,4 @@ static inline struct aa_ns *__aa_find_ns(struct list_head *head,
>   	return __aa_findn_ns(head, name, strlen(name));
>   }
>   
> -static inline struct aa_ns *__aa_lookup_ns(struct aa_ns *base,
> -					   const char *hname)
> -{
> -	return __aa_lookupn_ns(base, hname, strlen(hname));
> -}
> -
> -static inline struct aa_ns *aa_lookup_ns(struct aa_ns *view, const char *name)
> -{
> -	return aa_lookupn_ns(view, name, strlen(name));
> -}
> -
>   #endif /* AA_NAMESPACE_H */
> diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
> index fd5b7afbcb48..1f02cfe1d974 100644
> --- a/security/apparmor/policy_ns.c
> +++ b/security/apparmor/policy_ns.c
> @@ -159,43 +159,6 @@ void aa_free_ns(struct aa_ns *ns)
>   	kfree_sensitive(ns);
>   }
>   
> -/**
> - * aa_findn_ns  -  look up a profile namespace on the namespace list
> - * @root: namespace to search in  (NOT NULL)
> - * @name: name of namespace to find  (NOT NULL)
> - * @n: length of @name
> - *
> - * Returns: a refcounted namespace on the list, or NULL if no namespace
> - *          called @name exists.
> - *
> - * refcount released by caller
> - */
> -struct aa_ns *aa_findn_ns(struct aa_ns *root, const char *name, size_t n)
> -{
> -	struct aa_ns *ns = NULL;
> -
> -	rcu_read_lock();
> -	ns = aa_get_ns(__aa_findn_ns(&root->sub_ns, name, n));
> -	rcu_read_unlock();
> -
> -	return ns;
> -}
> -
> -/**
> - * aa_find_ns  -  look up a profile namespace on the namespace list
> - * @root: namespace to search in  (NOT NULL)
> - * @name: name of namespace to find  (NOT NULL)
> - *
> - * Returns: a refcounted namespace on the list, or NULL if no namespace
> - *          called @name exists.
> - *
> - * refcount released by caller
> - */
> -struct aa_ns *aa_find_ns(struct aa_ns *root, const char *name)
> -{
> -	return aa_findn_ns(root, name, strlen(name));
> -}
> -
>   /**
>    * __aa_lookupn_ns - lookup the namespace matching @hname
>    * @view: namespace to search in  (NOT NULL)

