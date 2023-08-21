Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED84CEE4996
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Aug 2023 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjHUQgI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjHUQgH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Aug 2023 12:36:07 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8B91
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 09:36:05 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58419517920so39532537b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692635764; x=1693240564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQv4L/PA9hY8HSrQBW7aq0hnDdsWEt0E4rTSB2AJsSQ=;
        b=eCm7qrdJyE2vyrdWru739gXzUHVd7nDroZbazHk3m4LdOlmuY9Zf1hYfM/OfnRiS6V
         ZGTKAkwkofBh6wEWRfBMBFGm7XKQ4xbcK8CU9gIiBbZskylojuiNMSJDVtUljoFut2nf
         F8qq6YeU/QXL2THHwhiOg31jGrCFGeH0kjl13TzORg3cMqgF5YNsPa/fXwaNkkT3wsoj
         ujMnk7IIUHmBZxgaG8CP6cYdGkVHnzJXm3T7RxRk4dQ+1tC+9hazLCpxbbHd9vfv4wjL
         I064OnKsZh+wLTrbr37YL6kZJNEAqjQ60d2G98CAiNuSVEpQZHb7sdaFlzSAY4+OO6u7
         2Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635764; x=1693240564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQv4L/PA9hY8HSrQBW7aq0hnDdsWEt0E4rTSB2AJsSQ=;
        b=FtqLuYsmFQz1Uv8IhM7DKt0/02XM0HMV/h8VGDFCuj03QjUBMzBFUTk0QEtveqz8Nr
         6i1UFY/l0itPCJFM48mawZkfBWThWKOCguoWoS+woPlKBBRRdLVVc4BECMdwdP/s+WdM
         vLVPTTFOSF+ijn8ryvmR0gbT+QBT0HcEmcPtCMWfRfOVeznlzU7+Sxix986wCfwvnLhl
         8+vxYhgIHkSI/FxJDVCeHw4dpbVe7JQI9UZi7fDHXMudzX2pnM0bfRHW9Lz8s2v584E/
         mS93vieXwCB4XM3xSX0hFDCniwI7EVqXPaQv7aZRaCgYqFxmkRC3G/ZErA3j+pOFl1Pd
         uJJw==
X-Gm-Message-State: AOJu0YxGIPEtqBodYUKLvL0wVx1t8D5Ndt/LCDajrkpPLVlWtfEFyIBR
        WSBrL+N2yz9qPDj0qFm+IgIOCLa3Kq3Y8hWp/SBx
X-Google-Smtp-Source: AGHT+IGvrYxl2ATR99fLkx+ccMWXaAajiFR3da/YtTYl68Cg1mIR3qSvlj19aljN17/0G+gBMNsEw321rCUGMLHiEws=
X-Received: by 2002:a81:6d0c:0:b0:581:2887:22be with SMTP id
 i12-20020a816d0c000000b00581288722bemr8465445ywc.37.1692635764580; Mon, 21
 Aug 2023 09:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com> <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
In-Reply-To: <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Aug 2023 12:35:53 -0400
Message-ID: <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Aug 19, 2023 at 3:09=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/18 23:59, Paul Moore wrote:
> > Except we are not talking SELinux or LSMs here, we are talking about
> > audit and the audit subsystem is very different from the LSM layer.
> > The LSM layer is designed to be pluggable with support for multiple
> > individual LSMs, whereas the audit subsystem is designed to support a
> > single audit implementation.  It is my opinion that the audit patch
> > you have proposed here does not provide an audit administrator with
> > any new capabilities that they do not currently have as an option.
>
> Before explaining why an audit administrator cannot afford emulating
> this patch, I explain what this patch will do.
>
> There are three system calls for managing a process: fork()/execve()/exit=
().
>
>   https://I-love.SAKURA.ne.jp/tomoyo/fork.gif
>   https://I-love.SAKURA.ne.jp/tomoyo/execve.gif
>   https://I-love.SAKURA.ne.jp/tomoyo/exit.gif
>
> As a result, history of a process can be represented as a tree, where the
> root of the tree is the kernel thread which is started by the boot loader=
.
>
>   https://I-love.SAKURA.ne.jp/tomoyo/railway.gif
>
> This fundamental mechanism cannot be changed as long as Linux remains as =
a
> Unix-like OS. That is, adding this information will not cause what you ca=
ll
> "the support burden" ...

Any new functionality added to the kernel, especially user visible
functionality or some sort of interface, adds a support burden.
Nothing is "free".

> > There are also concerns around field formatting, record length, etc.,
> > but those are secondary issues compared to the more important issue of
> > redundant functionality.
>
> If someone tries to emulate this patch, we need to be able to trace all
> fork()/execve()/exit() system calls. Or, the history tree will be broken.
>
> If an audit administrator tries to emulate this patch using system call
> auditing functionality, we need to make sure that
>
>   "auditctl -D" must not clear rules for tracing fork()/execve()/exit()
>   system calls. This is impossible because this change will break userspa=
ce
>   programs expecting that "auditctl -D" clears all rules.

It's a good thing that 'audtictl -d ...' exists so that one can
selectively delete audit rules from the kernel.  If someone wants to
preserve specific audit rules, that is the way to do it; 'auditctl -D'
is a very coarse tool and not something that is likely very useful for
users with strict auditing requirements.

>   Rules for tracing fork()/execve()/exit() system calls must be enabled
>   when the kernel thread which is started by the boot loader starts.
>   How can we embed such system call auditing rules into the kernel and
>   tell whether to enable these rules using the kernel command line option=
s?

I would boot the system with 'audit=3D1' on the kernel command line and
ensure that your desired audit rules are loaded as early in the boot
process as possible, before any long-running processes/daemons/logins
are started.  Honestly, that's simply a good best practice for anyone
who cares about maintaining a proper audit log, independent of the
specific use case here.

>   In order to avoid possibility of loosing fork()/execve()/exit() records=
,
>   auditd must not be stopped even temporarily. Who wants to enforce such
>   requirement in order to be able to obtain process history information?

A silly amount of work has gone into ensuring that the audit subsystem
in the kernel doesn't lose records when properly configured.  If you
haven't already, I would encourage you to read the auditctl(8) man
page and look for the parameters that adjust the audit backlog
configuration.

--=20
paul-moore.com
