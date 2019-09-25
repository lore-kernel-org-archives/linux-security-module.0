Return-Path: <SRS0=elJ9=XU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246FC432C2
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Sep 2019 23:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4FF208C3
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Sep 2019 23:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gTi2p0HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfIYX1a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:27:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34874 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfIYX13 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Sep 2019 19:27:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so169709lji.2
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2019 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sqCXdxl+Of7jf6rJsO8rQ0SGF0MvqeTX3//lE6sq48=;
        b=gTi2p0HMuFn+258nhleL02ZvNEY402U9LWCy+tdYU2Sk6btSfKw/0ugF12eXEQMJDD
         AiCUx2NMw7R2DUnRcunLUwriIwf9m41Jih9BtKp8M0EHefP2r6DzFrUAGM7LRzQBKG6V
         D5qHVcJgrSgHazrW0ieVDxpwzxQmX4JftqmeGr7jsTQ2Jf6wNBm8ptZr84U/ix/TNddQ
         LaFAdntoNdWv4qcPbmmGTKSyXOnItU2ydsiZdwDgwyXzcn/Du2bLeosUtPqaBdKbbdz8
         8ReWy4Tx7TCiwaWLV6F9ULLUyVDiw+SQx3kT8FV4RIWv59mFrauIHVcU5yZdQicd/cy0
         0zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sqCXdxl+Of7jf6rJsO8rQ0SGF0MvqeTX3//lE6sq48=;
        b=qgGigmID/fs6nPbebDhr+vkRJCLppaah5pqHipeRx2+Cp2pHriKT5gGa23yZDSp4r0
         HgxWwgy71xavrzsOHcDnZQx/yD3JE9fPRFAx2c23iwRALQaOIcs7D0yFrgsYE1NLeido
         7CxZvRVUNbXUIiF689yaQIO1qyqEtoPrtJ3PILtBKBIJbCpyDqRfoPUi9mgA04PjdA2f
         lTeloWCf7zHflzKiRWuBAjiq+HTbeyksTFT+fLwZPRjPHZIwebyUbBEIEBZEQipkxkm4
         4kja4VdaA4thMHrTM3bx6yb30k4+8g8ERjdyhXDDK+CaEc3L+RJi++6L3YZM6ON0iBG5
         H31g==
X-Gm-Message-State: APjAAAXr8KLZ10sgN70kT5iqoMknf33Ode5b6QzFD4l7HCYlGISRpYt1
        jgonUjbpf6ccrCggJxtQCfYcWOEzCk5IQtWCZiYMOeQ=
X-Google-Smtp-Source: APXvYqz+rc3PxdRkC9XVh7Yo8Mkknz6GnwWo3ELRdvf9CffUm4W0C9Axdhbp4gFE431jFa9hhWXIevuLhkMI2c4paW4=
X-Received: by 2002:a2e:890c:: with SMTP id d12mr490009lji.85.1569454047520;
 Wed, 25 Sep 2019 16:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190925221009.15523-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190925221009.15523-1-navid.emamdoost@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Sep 2019 19:27:16 -0400
Message-ID: <CAHC9VhR+4pZObDz7kG+rxnox2ph4z_wpZdyOL=WmdnRvdQNH9A@mail.gmail.com>
Subject: Re: [PATCH] genetlink: prevent memory leak in netlbl_unlabel_defconf
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 25, 2019 at 6:10 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In netlbl_unlabel_defconf if netlbl_domhsh_add_default fails the
> allocated entry should be released.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  net/netlabel/netlabel_unlabeled.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

It is worth noting that netlbl_unlabel_defconf() is only called during
kernel boot by netlbl_init() and if netlbl_unlabel_defconf() returns
an error code the system panics, so this isn't currently a very
practical concern.

That said, netlbl_unlabel_defconf() *should* clean up here just on
principal if nothing else.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index d2e4ab8d1cb1..c63ec480ee4e 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1541,8 +1541,10 @@ int __init netlbl_unlabel_defconf(void)
>         entry->family = AF_UNSPEC;
>         entry->def.type = NETLBL_NLTYPE_UNLABELED;
>         ret_val = netlbl_domhsh_add_default(entry, &audit_info);
> -       if (ret_val != 0)
> +       if (ret_val != 0) {
> +               kfree(entry);
>                 return ret_val;
> +       }
>
>         netlbl_unlabel_acceptflg_set(1, &audit_info);
>
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
