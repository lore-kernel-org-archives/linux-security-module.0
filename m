Return-Path: <SRS0=A2NQ=A5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E8C433E3
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jul 2020 02:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961022070E
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jul 2020 02:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgGRCyJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:54:09 -0400
Received: from mail.hallyn.com ([178.63.66.53]:35050 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbgGRCyJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 22:54:09 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 2ACDBC13; Fri, 17 Jul 2020 21:54:07 -0500 (CDT)
Date:   Fri, 17 Jul 2020 21:54:07 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities: Replace HTTP links with HTTPS ones
Message-ID: <20200718025407.GA11982@mail.hallyn.com>
References: <20200713103428.33342-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713103428.33342-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 13, 2020 at 12:34:28PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  kernel/capability.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 1444f3954d75..a8a20ebc43ee 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -40,7 +40,7 @@ __setup("no_file_caps", file_caps_disable);
>  /*
>   * More recent versions of libcap are available from:
>   *
> - *   http://www.kernel.org/pub/linux/libs/security/linux-privs/
> + *   https://www.kernel.org/pub/linux/libs/security/linux-privs/
>   */
>  
>  static void warn_legacy_capability_use(void)
> -- 
> 2.27.0
