Return-Path: <SRS0=sHE6=MN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658DDC43143
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89620666
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 21:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vb0xabXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C89620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeJBE2H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:28:07 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38552 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeJBE2H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 00:28:07 -0400
Received: by mail-yb1-f195.google.com with SMTP id e190-v6so6301264ybb.5
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vuVbGBvdO2o1Skd/DkZnyO58kitCvUZdXNxmr8f8Yxg=;
        b=Vb0xabXjhFv6avYkENO2GloQmgPMmOwjzDr7+6MCMTnrwL+nkM65bPmcsmdmasyv5N
         HMyZ6mxwtjn+zx2GVuKaAyxxjP4Iit7/phIsPhYDQhxOvweh4PeG7PDb11BTppxUGSLt
         sDm8VYEiHVHm97ZbPfX5+sJV3GVb1eu6dHTqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vuVbGBvdO2o1Skd/DkZnyO58kitCvUZdXNxmr8f8Yxg=;
        b=fc4kONkGNqwoH1F5S79DhDeyqs9dliwqUA6gV3ZwHez9LyZU9wL4RcRt81big59MxB
         QtR0jTz5qM0XhIqu/IvgvQUywiup3ZLcItzqxBk6V3OEa6E/jdb+ZHnUIoIBituS5YDZ
         n/XD/mQj23JUDhUFbe/9m1JBMB8Bhs5oTtyjtW3ncRUNWr6b7vkQFZeWS31c5KM7OAJs
         vwoWbNh7LllAmPJCthEmM+hZFEvCcfHEU5Ma2W4djbYiTyw1FxXcM8GEKPDwCym0D7Fu
         6MQRNGfgXByGKB4o6MnKqsW33Rgopj2Sf1wlMANsiweJWUZPuwC+KWVr007eObC9e8Un
         k2Yw==
X-Gm-Message-State: ABuFfoiDHdRmr1oRe5Iom0+tV74AQI59NV2bDka7t7HgPu5cQfkS0KU5
        C56DXW6UJYj2Wsxt/im0gk1BSuwKzos=
X-Google-Smtp-Source: ACcGV62W6OQvmYUKvwwRJmfHrBsPejv4gEquSP2pYRnNBk+JgMGiJ78HLJ4nJXc/Ge3kvdrh0i82Qg==
X-Received: by 2002:a25:5107:: with SMTP id f7-v6mr2546945ybb.438.1538430495163;
        Mon, 01 Oct 2018 14:48:15 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id o202-v6sm33560689ywo.38.2018.10.01.14.48.12
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:48:12 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id d14-v6so6297333ybs.8
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 14:48:12 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr7279029ybd.403.1538430491782;
 Mon, 01 Oct 2018 14:48:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 14:48:10 -0700 (PDT)
In-Reply-To: <8010a7d0-c6a0-b327-d5dd-6857d6d42561@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <8010a7d0-c6a0-b327-d5dd-6857d6d42561@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 14:48:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+XTMcqdPQK=E6KV3-oMCFA+UkiGsfHN2T6CCfAA7X9Qw@mail.gmail.com>
Message-ID: <CAGXu5j+XTMcqdPQK=E6KV3-oMCFA+UkiGsfHN2T6CCfAA7X9Qw@mail.gmail.com>
Subject: Re: [PATCH 21/19] LSM: Cleanup and fixes from Tetsuo Handa
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 26, 2018 at 2:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> lsm_early_cred()/lsm_early_task() are called from only __init functions.
>
> lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .
>
> lsm_early_inode() should be avoided because it is not appropriate to
> call panic() when lsm_early_inode() is called after __init phase.
>
> Since all free hooks are called when one of init hooks failed, each
> free hook needs to check whether init hook was called.
>
> The original changes are from Tetsuo Handa. I have made minor
> changes in some places, but this is mostly his code.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  6 ++----
>  security/security.c               | 27 ++++-----------------------
>  security/selinux/hooks.c          |  5 ++++-
>  security/selinux/include/objsec.h |  2 ++
>  security/smack/smack_lsm.c        |  8 +++++++-
>  5 files changed, 19 insertions(+), 29 deletions(-)

I've split this across the various commits they touch:

Infrastructure management of the cred security blob
LSM: Infrastructure management of the file security
LSM: Infrastructure management of the inode security
LSM: Infrastructure management of the task security
LSM: Blob sharing support for S.A.R.A and LandLock

Based on these changes, I've uploaded the "v4.1", or "Casey is on
vacation", tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/blob-sharing-v4.1

I'm going to work on a merged series for the "arbitrary ordering" and
"blob-sharing" trees next...

-Kees

-- 
Kees Cook
Pixel Security
