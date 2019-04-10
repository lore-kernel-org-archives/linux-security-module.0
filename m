Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC0C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEAF20830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJtjPCgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfDJR3O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:29:14 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46621 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbfDJR3O (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:29:14 -0400
Received: by mail-vs1-f65.google.com with SMTP id e2so1817908vsc.13
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFgDQfxUWS/AYla6kUelfMTH3QZqU8NQiZEznFW/p78=;
        b=iJtjPCgOOla5ReTubIVYItpQPop808cgX2nIeNlLm+pNnvnH+gLAKOhbsn4jAu3Fv6
         Ee6KhmLVpIgxSHUMBuafD+ZJAsWcM9mNCcPDRJ+xHxRJ4NtT4vTpVS/0DUlxpQbMRorc
         Qbs+TWk/ebc1Uf8ZcgdEmUcpdRkAgkUn37YRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFgDQfxUWS/AYla6kUelfMTH3QZqU8NQiZEznFW/p78=;
        b=T8AYlz5R9qO0bsWEIJ7lx98fvn6SyXqpT7SicGfYcosdR4Ke1kVJ1r/PvLFJHo5ftL
         4fHfmhRivDVoU5ckHgzs9EfubJwFSCte60imi7QR5UcIyhMOnsrl7JzmZTc9JE+PoRZL
         si3jELeCZOvQOqtyRE1fNHlws0jBSwozLJ8Y/LuK0Uj72LpGqm5ATkrUy+N5sLRQjW7c
         XYANA3/lHodCstrw9frpDjdpY1hpHbZWU4fApThdjG6RhIlBdV06yZDX7tpBQHjLhqqn
         bC0WBv8wdrGHm2z+UGOjBN3HsRLGa71qfBqPsTwcyJ8q2j00v1sY74BG1sZQlxGlYyId
         WPJA==
X-Gm-Message-State: APjAAAWM2cxochZYsnl8/uCBobWWxjatL3pmjcjOYkdtsYU+72ol1mt5
        9xm+XzMdbekQLQc+cHxnk1hNCSUop4Q=
X-Google-Smtp-Source: APXvYqyNnE4nKaMIuNcVPgYAgW5C3vUHLfhkpRnJWM4tgKl4TUB0D4ELFJ7iyDUavIdIVCNUGyN4qg==
X-Received: by 2002:a67:de0c:: with SMTP id q12mr25127389vsk.156.1554917352594;
        Wed, 10 Apr 2019 10:29:12 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id y64sm8471382vkd.26.2019.04.10.10.29.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:29:11 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id j184so1824829vsd.11
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:29:11 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr25828962vsc.196.1554917351266;
 Wed, 10 Apr 2019 10:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165627.212572-1-mortonm@chromium.org>
In-Reply-To: <20190410165627.212572-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:28:59 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLETb47pDRbmt4gRJN9+n1WPQAL9n9nhjDg8mhz9Vw8tA@mail.gmail.com>
Message-ID: <CAGXu5jLETb47pDRbmt4gRJN9+n1WPQAL9n9nhjDg8mhz9Vw8tA@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: SafeSetID: fix use of literal -1 in capable hook
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
>
> From: Jann Horn <jannh@google.com>
>
> The capable() hook returns an error number. -EPERM is actually the same as
> -1, so this doesn't make a difference in behavior.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/safesetid/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 4ab4d7cdba31..61b84e20f2dd 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -90,7 +90,7 @@ static int safesetid_security_capable(const struct cred *cred,
>          */
>         pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
>                 __kuid_val(cred->uid));
> -       return -1;
> +       return -EPERM;
>  }
>
>  /*
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
