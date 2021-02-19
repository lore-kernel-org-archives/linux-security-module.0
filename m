Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59870C433DB
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Feb 2021 17:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE1A64E33
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Feb 2021 17:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSRjm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhBSRjf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Feb 2021 12:39:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E198564E33;
        Fri, 19 Feb 2021 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613756334;
        bh=PRgn0JzVqMdEHk5W3ypxrOZxNdNz397PLJzB5TG1AAA=;
        h=Date:From:To:Cc:Subject:From;
        b=HCV6yJFnmUoT+eR0dyO4NfUS0Gyf6WxtsYM91leQ7Z/454zAT5YAPJ/ayy73d6luq
         yqupfoQV7sAvuwsemTTiD4wg+5v9M6R44rA7xmw5a6SswRytBhWgkN9/2PYBC7GWIR
         MtmVkV+TEClY90CL1WvuJnvklNp1jOkGiWTJYgAMWhCnUu63CpjHslJC+XiUlmlE32
         6hHp97Z2tCgrnyG7KANtJAxTiHJ53UqclrmBAI7pkxxeleOyHQh+eS/uYsJ/gthfcY
         I60XhUH3XRfrcptCliNZP3a1ozYrz2EG0cpPjlBoWJKCAnzTFKd/nqc2u3PQjiplnN
         M26Bx33pMxE/Q==
Date:   Fri, 19 Feb 2021 19:38:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Palash Oswal <hello@oswalpalash.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Replacing deprecated strlcpy with strscpy ~~~~~~~~~
 Replace
Message-ID: <YC/3n585TNJ500Ps@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reply-To: 
In-Reply-To: <20210219084038.GA7564@g3.oswalpalash.com>

On Fri, Feb 19, 2021 at 02:10:38PM +0530, Palash Oswal wrote:
> The strlcpy() function is unsafe in that the source buffer length
> is unbounded or possibly be non NULL terminated. This can cause
> memory over-reads, crashes, etc.
> 
> Link: https://github.com/KSPP/linux/issues/89
> Signed-off-by: Palash Oswal <hello@oswalpalash.com>

The long description does not explain what the commit does, and
does not include any details about deprecation of strlcpy(), which
at least I'm not aware of.

I don't think *length* ever is NULL terminated. The first sentence
is somewhat weird. Also strlcpy() does have a bounds check.

Generally, the description and reasoning is sloppy to say the
least.

/Jarkko


> ---
>  security/integrity/ima/ima_api.c    | 2 +-
>  security/integrity/ima/ima_policy.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 1dd70dc68ffd..2f3b8257181d 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -399,7 +399,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
>  	}
>  
>  	if (!pathname) {
> -		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
> +		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
>  		pathname = namebuf;
>  	}
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9b45d064a87d..010839aef6ba 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -791,7 +791,7 @@ static int __init ima_init_arch_policy(void)
>  		char rule[255];
>  		int result;
>  
> -		result = strlcpy(rule, *rules, sizeof(rule));
> +		strscpy(rule, *rules, sizeof(rule));
>  
>  		INIT_LIST_HEAD(&arch_policy_entry[i].list);
>  		result = ima_parse_rule(rule, &arch_policy_entry[i]);
> 
> base-commit: f6692213b5045dc461ce0858fb18cf46f328c202
> -- 
> 2.27.0
> 
> 
