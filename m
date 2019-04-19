Return-Path: <SRS0=lufb=SV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F3FC282DA
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A560620643
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wf+87+EI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfDSS7m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:59:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44271 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfDSS7m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Apr 2019 14:59:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so5341247ljg.11
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2019 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z76qy/WYscT8yTKM3EVAchBs4dSJCLcS1D6tVIKxsTY=;
        b=wf+87+EIb4rIEjz9uA3YYlHwFC3NCiKJzU1g3OwuHSDIOFGIJAlWBstHMWhRp7nkIS
         zCy5nf6ld0NM/LDfTksi/wCqE0+6If9RD16LFxinXexEd7E7T8KXK+QjVPjz5F8wSVdM
         BXEZSpPUgmrKZeL0N3GbAqToD6N+V+zdTxthwVitP1WmLdHBzCzOu3pQUdeLXJqZ94uw
         ni4k51U+rpsJlGbmX6yHGaW6WAyp6MIN4FaQpw3hbEv9Aee9i9+BFBl/g/YX6iL6XbtO
         W5y9uFJWkWqpIGsdxPu2z1BJxM7Cere3gvBR46oLWGfcxcFXfoRt9lb6Msos5GHuEBze
         ZiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z76qy/WYscT8yTKM3EVAchBs4dSJCLcS1D6tVIKxsTY=;
        b=nSQbN33Z/+Iw6pAdiJX32K2RCIMjLzmFn4kNUwkHUBx6i2alDqHK6upf5iMA+l98iM
         41+5qzL4hI5i/mXCqYY0UquZE9faTSMVHQUxNudbhacx0SmECAveTFEPNuzuBrjwX8lV
         Wk+HHe8kKIfBsSt+mnDgeLy7KpDY/rIQxU+HfqSuSgV0qwayg1spvOWfsKsZ1Z+5Gd7I
         LtuHeLF5BIG4aKBA+zWEvYm87qgfy+P6BfhF3efmADIx30YHTJSrQ95kQpgwSMOrKh/w
         CGhr64gsg70n4LPUhTAB41wDe/BZ6sOc8HjWWT7cmXBgTu0a0dmEKgek8DlSSmLBhfMo
         KiCw==
X-Gm-Message-State: APjAAAV2bkV86sjL4s+IGDcapTP8tyMRK/aZZVCIeahPGZW7eag6iiXn
        zXzoQ8vTgVMkF91Zh0Pg+2nQtvPWo3Sz09uoh9Kleyo=
X-Google-Smtp-Source: APXvYqxD7fUYbYeicEBXyFM/4ELy//HHhu/G6PToGa+1DO64dMOqfSBCIafdH7SlNyjg0wLa2bPphC8ua/9dXY5ljrA=
X-Received: by 2002:a2e:b01a:: with SMTP id y26mr3090917ljk.38.1555700379256;
 Fri, 19 Apr 2019 11:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <155570011247.27135.12509150054846153288.stgit@chester>
In-Reply-To: <155570011247.27135.12509150054846153288.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Apr 2019 14:59:28 -0400
Message-ID: <CAHC9VhQKE3Rnbz8qxm0UKNB=GT6xPu-Le=ZZM0_XisOS+v3jKg@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent changes to overridden credentials
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, cj.chengjian@huawei.com,
        john.johansen@canonical.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 19, 2019 at 2:55 PM Paul Moore <paul@paul-moore.com> wrote:
> Prevent userspace from changing the the /proc/PID/attr values if the
> task's credentials are currently overriden.  This not only makes sense
> conceptually, it also prevents some really bizarre error cases caused
> when trying to commit credentials to a task with overridden
> credentials.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/proc/base.c |    5 +++++
>  1 file changed, 5 insertions(+)

I sent this to the LSM list as I figure it should probably go via
James' linux-security tree since it is cross-LSM and doesn't really
contain any LSM specific code.  That said, if you don't want this
James let me know and I'll send it via the SELinux tree assuming I can
get ACKs from John and Casey (this should only affect SELinux,
AppArmor, and Smack).

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..87ba007b86db 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2539,6 +2539,11 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>                 rcu_read_unlock();
>                 return -EACCES;
>         }
> +       /* Prevent changes to overridden credentials. */
> +       if (current_cred() != current_real_cred()) {
> +               rcu_read_unlock();
> +               return -EBUSY;
> +       }
>         rcu_read_unlock();
>
>         if (count > PAGE_SIZE)
>

-- 
paul moore
www.paul-moore.com
