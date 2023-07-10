Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905CBEB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Jul 2023 08:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjGJIsV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Jul 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJIsU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 04:48:20 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F88C9;
        Mon, 10 Jul 2023 01:48:19 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9A2783F323;
        Mon, 10 Jul 2023 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688978898;
        bh=Z/gL9U9h5Em+3aV81BCbewJzSllI5Ghayx0OULbP+so=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ewXq8l5DS0FT2hJCD5L9XG29STBWwsin2ywcbmZbyIth2YiSTym/obgmS6z2LUjvZ
         FN2zHtdCgalJMKVvNKfv59Z6RGSieq8v5CXpiLokMXShOiWEnlVB9oDZyYsZlZT9EX
         yjjc7s1PD65ejF97zvfcbi/+aGb1l+o9N/ik7udsLyvODvENfu7xEO1LWLPGDnwqwx
         ZhzjVkOCWj3e4hE29upYa53rVmkEX4eX2j2ulWiUN2YmErnHPU6y7cOH7PyGUHpDfi
         rB6ZXSOnlcHNzUoW6YLtSyB1RfDIZncKRKgfdxYQnrlC/2UifMaPmo/+xHUQuEv7Wg
         yBttjRbY10TFQ==
Message-ID: <685315da-3a6d-6d1e-03cb-1fc07ff68121@canonical.com>
Date:   Mon, 10 Jul 2023 01:48:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] apparmor: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707080737.49899-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230707080737.49899-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/7/23 01:07, Yang Li wrote:
> Use colons to separate parameter names from their specific meanings.
> silencethe warnings:
> 

Unfortunately Gaosheng Cui beat you to this fix on 6/24 with
[PATCH -next 08/11] apparmor: Fix kernel-doc warnings in apparmor/resource.c

thankyou for taking the time to help make apparmor better

-
john

> security/apparmor/resource.c:111: warning: Function parameter or member 'label' not described in 'aa_task_setrlimit'
> security/apparmor/resource.c:111: warning: Function parameter or member 'task' not described in 'aa_task_setrlimit'
> security/apparmor/resource.c:111: warning: Function parameter or member 'resource' not described in 'aa_task_setrlimit'
> security/apparmor/resource.c:111: warning: Function parameter or member 'new_rlim' not described in 'aa_task_setrlimit'
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   security/apparmor/resource.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
> index e85948164896..2bebc5d9e741 100644
> --- a/security/apparmor/resource.c
> +++ b/security/apparmor/resource.c
> @@ -97,10 +97,10 @@ static int profile_setrlimit(struct aa_profile *profile, unsigned int resource,
>   
>   /**
>    * aa_task_setrlimit - test permission to set an rlimit
> - * @label - label confining the task  (NOT NULL)
> - * @task - task the resource is being set on
> - * @resource - the resource being set
> - * @new_rlim - the new resource limit  (NOT NULL)
> + * @label: label confining the task  (NOT NULL)
> + * @task: task the resource is being set on
> + * @resource: the resource being set
> + * @new_rlim: the new resource limit  (NOT NULL)
>    *
>    * Control raising the processes hard limit.
>    *

