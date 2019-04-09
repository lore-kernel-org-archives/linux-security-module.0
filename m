Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0058CC10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 09:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF5F20833
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 09:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDIJcn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:32:43 -0400
Received: from foss.arm.com ([217.140.101.70]:34532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfDIJcn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 05:32:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CB90374;
        Tue,  9 Apr 2019 02:32:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 670583F59C;
        Tue,  9 Apr 2019 02:32:38 -0700 (PDT)
Date:   Tue, 9 Apr 2019 10:32:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
Message-ID: <20190409093234.GB21979@lakrids.cambridge.arm.com>
References: <20190408170418.148554-1-glider@google.com>
 <20190408170418.148554-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408170418.148554-3-glider@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 08, 2019 at 07:04:18PM +0200, Alexander Potapenko wrote:
> This config option enables CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING
> without the need to pass any boot parameters.
> 
> No performance optimizations are done at the moment to reduce double
> initialization of memory regions.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sandeep Patil <sspatil@android.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> ---
>  v3:
>   - addressed comments by Masahiro Yamada (Kconfig fixes)
> ---
>  mm/page_poison.c         |  5 +++++
>  mm/slub.c                |  2 ++
>  security/Kconfig.initmem | 11 +++++++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index 21d4f97cb49b..a1985f33f635 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -12,9 +12,14 @@ static bool want_page_poisoning __read_mostly;
>  
>  static int __init early_page_poison_param(char *buf)
>  {
> +#ifdef CONFIG_INIT_ALL_HEAP
> +	want_page_poisoning = true;
> +	return 0;
> +#else
>  	if (!buf)
>  		return -EINVAL;
>  	return strtobool(buf, &want_page_poisoning);
> +#endif
>  }
>  early_param("page_poison", early_page_poison_param);

IIUC this is only called if page_poison is passed on the command line,
so want_page_poisoning won't be set automatically unless that's passed.

Presumably you want to initialize it at definition with:

static bool want_page_poisoning __read_mostly = IS_ENABLED(CONFIG_INIT_ALL_HEAP);

with:

#ifndef CONFIG_INIT_ALL_HEAP
static int __init early_page_poison_param(char *buf)
{
	...
}
early_param("page_poison", early_page_poison_param);
#endif

... so that it can't be disabled?

Thanks,
Mark.
