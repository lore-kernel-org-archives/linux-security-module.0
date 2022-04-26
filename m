Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C1C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Apr 2022 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352003AbiDZTVg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbiDZTVf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Apr 2022 15:21:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4D644FB
        for <linux-security-module@vger.kernel.org>; Tue, 26 Apr 2022 12:18:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so19999313wrv.10
        for <linux-security-module@vger.kernel.org>; Tue, 26 Apr 2022 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D51WhcFY/UMeRUO4RGgJqs3BnSIqLPLR50R7pSPgCJk=;
        b=41hn5Zs+Qibe7XUS82jY/4Yq9kjs81xMeDW2Al5Wv4emYj7RXpxHg9m/a74sGulFA4
         u7y1fTPot16F8zf/57piTeqrziJ+vUuuPyb5/ArPm07y0CptVtmUNy+cPC1+xb7/ZFg6
         hJ+GeLntfyA7sCcy02UFG8KSwAVd49QPBMi0gGNIu/M/Sn6ha74BLytHSk5CuzBBUSdB
         vGt0pDb7OsvHBuTS2jYecFd14v1eBEIRWVzLLoXNdSq6JxWX6Tal26NvfjJkZ0Gj9i+a
         qv0KixQFvy4J/D9N+b5mlflsWKcS/uT4A4UBBU7+ZlGBMMDvcR672AWcOC+20JFsxnhA
         UQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D51WhcFY/UMeRUO4RGgJqs3BnSIqLPLR50R7pSPgCJk=;
        b=Oi9heBUBwGg5HhrUm29FjbLRTK0/mtuIaHWywNB8JdFjMyzOlDH1ItEqvPIdDY2YU/
         CuzoedaBDqTlQcDdm3+k8QEWnYpK7F97UFMFnYiymtWNgFn76XTrQuDw3WekUvS6MWO9
         4GvoUUPAlpukxkRGBK9yCnFhs0mfXQhAZqzRBm6RCdnmrcixBsK5wdXyggXDjmH0Izms
         E8al8ETrAEYwzTHMC9WnikJTaTrgIalOFklHtD6Io+Nzso/a3ismfpsixCRbjy6GI2Tw
         0jw0RJcmsYp7wOm2veoZ4d786xIV7KUhaNizm+Nk6QLdUUeZZKTZYAiJkSs3C34qGpmY
         NjtA==
X-Gm-Message-State: AOAM532UqqQHDok/cmXZCaJxdMJEyzqeKSyCO0BZKJQpDAMA3kCY4Yib
        Bj7g7Nxh7tNZOQi/lGug9BtOdWZU2tQqZiYQEktmDVTqyQ==
X-Google-Smtp-Source: ABdhPJyN5wrn3K+iI2j26/cBIbWY3KxJyXj68+WgqqkU4W4HlKBXb8XI2ye1xUXf6KEOe8QcVbMtcJEumNqu4jkWPrM=
X-Received: by 2002:a5d:590d:0:b0:20a:c3eb:2584 with SMTP id
 v13-20020a5d590d000000b0020ac3eb2584mr18829655wrd.18.1651000705042; Tue, 26
 Apr 2022 12:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com> <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
 <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com> <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com>
In-Reply-To: <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 15:18:13 -0400
Message-ID: <CAHC9VhQQysL8aEt8w5G-nemJzapY-Q4pYKn0TCdnVjpuiTKqhw@mail.gmail.com>
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 26, 2022 at 2:58 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/26/22 11:03, Paul Moore wrote:
> > On Mon, Apr 25, 2022 at 7:31 PM John Johansen
> > <john.johansen@canonical.com> wrote:
> >> On 4/18/22 07:59, Casey Schaufler wrote:
> >>> Replace the timestamp and serial number pair used in audit records
> >>> with a structure containing the two elements.
> >>>
> >>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>> Acked-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>  kernel/audit.c   | 17 +++++++++--------
> >>>  kernel/audit.h   | 12 +++++++++---
> >>>  kernel/auditsc.c | 22 +++++++++-------------
> >>>  3 files changed, 27 insertions(+), 24 deletions(-)
> >
> > ...
> >
> >>> diff --git a/kernel/audit.h b/kernel/audit.h
> >>> index 4af63e7dde17..260dab6e0e15 100644
> >>> --- a/kernel/audit.h
> >>> +++ b/kernel/audit.h
> >>> @@ -108,10 +114,10 @@ struct audit_context {
> >>>               AUDIT_CTX_URING,        /* in use by io_uring */
> >>>       } context;
> >>>       enum audit_state    state, current_state;
> >>> +     struct audit_stamp  stamp;      /* event identifier */
> >>>       unsigned int        serial;     /* serial number for record */
> >>
> >> shouldn't we be dropping serial from the audit_context, since we have
> >> moved it into the audit_stamp?
> >
> > Unless we make some significant changes to audit_log_start() we still
> > need to preserve a timestamp in the audit_context so that regularly
> > associated audit records can share a common timestamp (which is what
> > groups multiple records into a single "event").
> >
> sure, but the patch changes things to use ctx->stamp.serial instead of
> ctx->serial ...

My apologies, I read your original comment wrong; I was thinking you
were suggesting removing the timestamp info from audit_context in
favor of using the timestamp info contained in the audit_buffer.

Yes, audit_context:serial is no longer needed with audit_context:stamp.

-- 
paul-moore.com
