Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ED8C433B4
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Apr 2021 09:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2408361405
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Apr 2021 09:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhD2JWv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Apr 2021 05:22:51 -0400
Received: from smtp-190f.mail.infomaniak.ch ([185.125.25.15]:56009 "EHLO
        smtp-190f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237004AbhD2JWs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Apr 2021 05:22:48 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FW9401zqZzMqwr5;
        Thu, 29 Apr 2021 11:21:36 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4FW93z0c2bzlh8TL;
        Thu, 29 Apr 2021 11:21:34 +0200 (CEST)
Subject: Re: [PATCH v2] samples/landlock: fix path_list memory leak
To:     trix@redhat.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210428213852.2874324-1-trix@redhat.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <20b46fb2-94e2-989a-9102-5e5c7be3b8ba@digikod.net>
Date:   Thu, 29 Apr 2021 11:22:06 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20210428213852.2874324-1-trix@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 28/04/2021 23:38, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this error
> 
> sandboxer.c:134:8: warning: Potential leak of memory
>   pointed to by 'path_list'
>         ret = 0;
>               ^
> path_list is allocated in parse_path() but never freed.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>

Previous version:
https://lore.kernel.org/r/20210427183755.2790654-1-trix@redhat.com

> ---
> v2:
>   - Remove NULL ptr check
> ---
>  samples/landlock/sandboxer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 7a15910d2171..8859fc193542 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -134,6 +134,7 @@ static int populate_ruleset(
>  	ret = 0;
>  
>  out_free_name:
> +	free(path_list);
>  	free(env_path_name);
>  	return ret;
>  }
> 
