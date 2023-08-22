Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91757EE4993
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Aug 2023 19:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjHVTak (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjHVTak (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Aug 2023 15:30:40 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C026CFE
        for <linux-security-module@vger.kernel.org>; Tue, 22 Aug 2023 12:30:38 -0700 (PDT)
Received: from [10.8.192.2] (unknown [50.47.144.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C00D6400FF;
        Tue, 22 Aug 2023 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692732637;
        bh=at8HYuilsf1mN5scGD0Hw3VEqy4NFm7MwZDMSX8u5fc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bX9j+upKM1/nWAlEy3D84jkB16TeKbu1lOCui/VOAD+oAWHFOzEOFAHYkGl24RLxX
         aPGXYOOxfkqf+0hCl5KgpdHkMZ81INnGc4grCJxKPuanN/8E+6rrpvz14Ir+tigXLt
         7q797O4/HUsMjm09wyoqtv4j4RH7eJEAKYxU3XodTGhg6EoGNRkoll6vQV8mHcrMbh
         OXvF4tJ6X3FVw0GjiRXnDZ5QwuAXWNLB6NQo+OSoJ6mvaFcTQsfonzD5q8qOwTCbH5
         VX02W9ExXKS+Tvp/mHYiDwmYLKrblGotJ+vHg/zh5o4n/K9XS0JbROaUCHoE6NszRu
         VkQOhjxsNx5nQ==
Message-ID: <b42223a6-231f-94f0-63b0-d5e6c4abd460@canonical.com>
Date:   Tue, 22 Aug 2023 12:30:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] apparmor: Remove unused declarations
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20230816131010.39320-1-yuehaibing@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230816131010.39320-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/16/23 06:10, Yue Haibing wrote:
> Commit f1bd904175e8 ("apparmor: add the base fns() for domain labels")
> declared but never implemented aa_label_make_newest().
> Commit 98849dff90e2 ("apparmor: rename namespace to ns to improve code line lengths")
> declared but never implemented aa_free_ns_kref().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: John Johansen <john.johansen@canonical.com>

this has pulled into apparmor-next-next so it will land
next cycle

> ---
>   security/apparmor/include/label.h     | 3 ---
>   security/apparmor/include/policy_ns.h | 2 --
>   2 files changed, 5 deletions(-)
> 
> diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
> index 2a72e6b17d68..c952a0b07855 100644
> --- a/security/apparmor/include/label.h
> +++ b/security/apparmor/include/label.h
> @@ -288,9 +288,6 @@ struct aa_profile *__aa_label_next_not_in_set(struct label_it *I,
>   bool aa_label_remove(struct aa_label *label);
>   struct aa_label *aa_label_insert(struct aa_labelset *ls, struct aa_label *l);
>   bool aa_label_replace(struct aa_label *old, struct aa_label *new);
> -bool aa_label_make_newest(struct aa_labelset *ls, struct aa_label *old,
> -			  struct aa_label *new);
> -
>   struct aa_label *aa_label_find(struct aa_label *l);
>   
>   struct aa_profile *aa_label_next_in_merge(struct label_it *I,
> diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
> index 33d665516fc1..d52311e86d23 100644
> --- a/security/apparmor/include/policy_ns.h
> +++ b/security/apparmor/include/policy_ns.h
> @@ -86,8 +86,6 @@ const char *aa_ns_name(struct aa_ns *parent, struct aa_ns *child, bool subns);
>   void aa_free_ns(struct aa_ns *ns);
>   int aa_alloc_root_ns(void);
>   void aa_free_root_ns(void);
> -void aa_free_ns_kref(struct kref *kref);
> -
>   struct aa_ns *aa_find_ns(struct aa_ns *root, const char *name);
>   struct aa_ns *aa_findn_ns(struct aa_ns *root, const char *name, size_t n);
>   struct aa_ns *__aa_lookupn_ns(struct aa_ns *view, const char *hname, size_t n);

