Return-Path: <SRS0=4P7i=4X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C2C10F25
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Mar 2020 20:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC360206CC
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Mar 2020 20:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TeavJ82P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCFUhz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:37:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34403 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFUhz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Mar 2020 15:37:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id c21so4039324edt.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Mar 2020 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc8dLNN9aOjew0rb0AyDFlPIotiwljk6L7LwU9CoY10=;
        b=TeavJ82PVNrWgBa3Kaj34DHtzXPK4yDqitgn5cX8deyk3QjDbzI1l1OixBgCb1DfwI
         wCXPZtk1dK5esrg8/8KHMK2negu+JVKQdi/PUsvQqVvyXNssROZccrDFJEoP4B/Rs0a8
         dE2QJQy82pU7wQGv4lfBO+Xsx4Q2kJStpe8sD2ERkKJ6UjFO3xRKx0CHAOrfRj17NhBf
         DEs7xgaBW0x1/nJnAwN7567VfYQ5OKJSVlYnNcYoDL89vIm2gcBse3PDXN8WpVG0EWQO
         Op74AyI6uofWk9uCFnpEga2Oj9ztkNu7FX5c62rfVHRCBn7kCsx3XGhTNJKUSM/JKXBc
         r9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc8dLNN9aOjew0rb0AyDFlPIotiwljk6L7LwU9CoY10=;
        b=CC2sNRjEh5dcKroYPRvAKvK32gIK8XCVUNBpFozGeI69LwuOStCK0DxL6cwtUQjLuE
         bJLIFAorESdIuU55D/zEobVmc8ZSDwQsXEpYiIt2Kxfm+dqS2k+lxvrzJx2FWW7FrlH7
         JwhssKYa3IeWxCAE1XYbA/6UvyGYo+mdRtsrT5fF8ZAGhNLM6UlQWb4F/TiiOKvr5tPR
         QUsfVfFbi1A/HEV5/D7217zEKfX9XjKnAXcCas/whykG9McHeSfm1sjzXxqCm8fQvscT
         HOPd871tqoY90AgmTTj9RWWFB1RlC70fa2qX9V3NKuUxMiSPN1XmJ9RRYO6rRTY9Si4A
         RjAw==
X-Gm-Message-State: ANhLgQ1RNLBaGSsoQSmIdMIGA2VxvK+hQMDx1sbujz0r7MaMdatrt3d/
        N6l3aXoWF2P7Ul2umF9xQPtNWoTHjXmlXrfS8lh1
X-Google-Smtp-Source: ADFU+vvKRyFN7oavHoXHT0qlUXDxV64JJo3Roxl2z0iASYRJ1QWc3S2r3faRTib91H3Dqu4KWhawUy2usvuXTV7uV9E=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr5318390edc.128.1583527072852;
 Fri, 06 Mar 2020 12:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-2-casey@schaufler-ca.com>
In-Reply-To: <20200214234203.7086-2-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 15:37:41 -0500
Message-ID: <CAHC9VhS8KF-BzCFLjDNLWmg1q5-bgfJ9LvPcHy_4sWtPsYaPKA@mail.gmail.com>
Subject: Re: [PATCH v15 01/23] LSM: Infrastructure management of the sock security
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 14, 2020 at 6:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Move management of the sock->sk_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/apparmor/include/net.h   |  6 ++-
>  security/apparmor/lsm.c           | 38 ++++-----------
>  security/security.c               | 36 +++++++++++++-
>  security/selinux/hooks.c          | 78 +++++++++++++++----------------
>  security/selinux/include/objsec.h |  5 ++
>  security/selinux/netlabel.c       | 23 ++++-----
>  security/smack/smack.h            |  5 ++
>  security/smack/smack_lsm.c        | 64 ++++++++++++-------------
>  security/smack/smack_netfilter.c  |  8 ++--
>  10 files changed, 144 insertions(+), 120 deletions(-)

Stephen already ACK'd this patch, but more acks/reviews are always
better so you can add my ACK as well.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
