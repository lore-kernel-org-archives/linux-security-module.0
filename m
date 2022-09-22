Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8253C6FA86
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Sep 2022 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiIVO4S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIVO4R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Sep 2022 10:56:17 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2717E1192
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 07:56:15 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 8B5FF9CA; Thu, 22 Sep 2022 09:56:12 -0500 (CDT)
Date:   Thu, 22 Sep 2022 09:56:12 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] apparmor: Simply obtain the newest label on a cred
Message-ID: <20220922145612.GA23772@mail.hallyn.com>
References: <20220922030024.1282700-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922030024.1282700-1-cuigaosheng1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 22, 2022 at 11:00:24AM +0800, Gaosheng Cui wrote:
> aa_get_newest_cred_label(__task_cred(task)) can do the same things as
> aa_get_newest_label(__aa_task_raw_label(task)), so we can replace it
> and remove __aa_task_raw_label() to simply code.

nitpick -

"to simplify the code".

> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/apparmor/include/cred.h | 13 -------------
>  security/apparmor/task.c         |  2 +-
>  2 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
> index 0b9ae4804ef7..58fdc72af664 100644
> --- a/security/apparmor/include/cred.h
> +++ b/security/apparmor/include/cred.h
> @@ -63,19 +63,6 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
>  	return aa_get_newest_label(aa_cred_raw_label(cred));
>  }
>  
> -/**
> - * __aa_task_raw_label - retrieve another task's label
> - * @task: task to query  (NOT NULL)
> - *
> - * Returns: @task's label without incrementing its ref count
> - *
> - * If @task != current needs to be called in RCU safe critical section
> - */
> -static inline struct aa_label *__aa_task_raw_label(struct task_struct *task)
> -{
> -	return aa_cred_raw_label(__task_cred(task));
> -}
> -
>  /**
>   * aa_current_raw_label - find the current tasks confining label
>   *
> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
> index 503dc0877fb1..0a8f9fa7ca0a 100644
> --- a/security/apparmor/task.c
> +++ b/security/apparmor/task.c
> @@ -31,7 +31,7 @@ struct aa_label *aa_get_task_label(struct task_struct *task)
>  	struct aa_label *p;
>  
>  	rcu_read_lock();
> -	p = aa_get_newest_label(__aa_task_raw_label(task));
> +	p = aa_get_newest_cred_label(__task_cred(task));
>  	rcu_read_unlock();
>  
>  	return p;
> -- 
> 2.25.1
