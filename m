Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC9C433C1
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 19:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F86199F
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 19:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCVTaD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhCVT3q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 15:29:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863DAC061574
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 12:29:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y6so20801314eds.1
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5r8vrk0RmFcttAb72LWQcbklz+HCMJrxiDMKZwe4wg=;
        b=p5erR9PEGFp1swe2diXRMbGO9r+wTbNT2PF+f2EAt7hbHnNgUQvv+xkP+6S2EL1GnR
         U+Uzw6p9rh4c/04ULDSEkp9sv0gcB1BqwkdJqEeoF0z9/AvBcL7A9SY4Oule9LFFQi0F
         hN4ygjX6VidadiMWzgWpnyH+DaEj1rtJnuH+Lt1a8PRyGrx8nGIfjHQF03vhuI0QhVa+
         K0K3RO+w2VtikIWCHOsN4xlP+ThA3c4nluCb+xhRZF7rbQXl/9Mr9OnVnOLaUGGtzlPS
         0/kVpEDakFfd3WGTC+h7HtKhn6xip28qFIbwV1aopml7+ci9Bv8p4EwpUkIW3CqhhPLw
         svPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5r8vrk0RmFcttAb72LWQcbklz+HCMJrxiDMKZwe4wg=;
        b=ZYhEiRjRJAnKrPU7Vpji6m18J8gZL2ql6qYPxpeDvfTpQwD+k+vPWjsGn8HpLYke8e
         rxozqXgB65A8DR0C3fgucihIwDW5DNGFSkSrZ7zJ+JcFA4+AAz7JB6g1DZUcvGyuufFk
         b1nZwnH/YU+EYt9J5bL5OBgA5NgPohLWO6NsUyFgTSJfLX8klQzVmIvczbcJC5f736PE
         pj/7Ok1PJ47AkUm1zOBlA3hCGID42nwtoqDFyT8wO2tyxIb2Ygc2LY0WoBvLC7IoTKm5
         /8xMFZCwwdTOjw9i4YAKFwD1QW2Y4sFUg1hZ3XODdJd4MfBP2XEcEGaqGaF3f6ix5YvK
         uAfw==
X-Gm-Message-State: AOAM533rJD2RgIFTxaSxPhcCGZXdZU2P9ac85EAmQo5cQBysi/T7O1o6
        BarTichYF81D6eRB/6veqOzoJNNMlcKG77rnNGVDYm+pKU4f
X-Google-Smtp-Source: ABdhPJzGU/T9xoph1YWbf4mgQ+693uVmIILpwh/6TNc6el91BsI8BWGqoAEachuvH9/dsXb8UJ6Y+Polb/dHCDpGtRw=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr1227097edt.12.1616441382025;
 Mon, 22 Mar 2021 12:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <161609713992.55424.6906498317563652734.stgit@olly>
In-Reply-To: <161609713992.55424.6906498317563652734.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Mar 2021 15:29:31 -0400
Message-ID: <CAHC9VhRF4xRQiu+iww=G3FkY2vcjFuPAj4=5yVW4dxCYSnF1NA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Split security_task_getsecid() into subj and obj variants
To:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        selinux@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 18, 2021 at 4:42 PM Paul Moore <paul@paul-moore.com> wrote:
>
> An update on the previous RFC patchset found here:
>
> https://lore.kernel.org/linux-security-module/161377712068.87807.12246856567527156637.stgit@sifl/
>
> Aside from being rebased to the current SELinux next branch (which
> in turn is based on v5.12-rc2), this revision changes the binder
> related code to always use the objective credentials as discussed
> in the thread above.  I've also dropped the AppArmor patch as John
> has a better version in progress; in the meantime AppArmor should
> continue to work exactly as it did before this patchset so there
> is no harm in merging this without the AppArmor patch.
>
> Casey, John, and Richard; I dropped your ACKs, Reviewed-by, etc.
> tags as the binder changes seemed substantial enough to not
> carryover your tags.  I would appreciate it if you could re-review
> this revision; the changes should be minimal.  I did leave Mimi's
> tag on this revision as she qualified it for IMA and that code
> didn't change.
>
> ---
>
> Paul Moore (3):
>       lsm: separate security_task_getsecid() into subjective and objective variants
>       selinux: clarify task subjective and objective credentials
>       smack: differentiate between subjective and objective task credentials
>
>
>  security/selinux/hooks.c   | 112 ++++++++++++++++++++++++-------------
>  security/smack/smack.h     |  18 +++++-
>  security/smack/smack_lsm.c |  40 ++++++++-----
>  3 files changed, 117 insertions(+), 53 deletions(-)

All three patches have been merged into selinux/next, thanks for the
help/review everyone!

-- 
paul moore
www.paul-moore.com
