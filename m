Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE68C433EF
	for <linux-security-module@archiver.kernel.org>; Sat, 20 Nov 2021 15:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhKTPJ6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhKTPJ5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 Nov 2021 10:09:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898BC061574
        for <linux-security-module@vger.kernel.org>; Sat, 20 Nov 2021 07:06:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so55650593edu.4
        for <linux-security-module@vger.kernel.org>; Sat, 20 Nov 2021 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=229GptHGTuugtPeXarOWaGw8aaoT6JC7W/mP33NcG8M=;
        b=fwK7L/vLhxYZlrksx1+Ak+HfDA49veNHLebqZZNqbMQfYSHPM5oT9SD2XB4NzaEMUw
         kF0AEjlEmy+tjU65RqJiFh2/+jNhpEPdSF5adLlQZK6ApvLsIijLfJUnNdz6qEVX7eBd
         NxYH9+UHPFYqZoLV6ziWRllhxd+YoiwKEI/cdEdD+IG+aM3SN/9yfA+FxpK1EjdAib/g
         G3mibns6fkh2XOLDam6NMZmodSkTT7qSK9ojDnPKN26KAqplo4+jX6sbVZ4rlc9N/n5b
         oko4ENvvJObgYSIjGXeFgU+uLgheP8LnWJz38LY/WwutoCR7mfVRrJ9qtMAKFYB7rH6J
         RRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=229GptHGTuugtPeXarOWaGw8aaoT6JC7W/mP33NcG8M=;
        b=SSgU0n2y497KhZWttiQC4schJnS7xGK6AniVWEfwfN/5Z14UEVhEEdsEwOLA1bOlG+
         g2fazbxKUPmaY6HYYPRd1B9QGx7IcKPiBWsv4C3W4LIcsCS0iygYcDvciGtESXfpZCMC
         syPdCoIc/zOS+Y9ihLxI9qbACrfe2SrTqiN0NM2K4L9O7ptfVEWQ/ipttOKsG8u7SvL8
         /UOxHdmpoQDIYM8dZuMOj74a8Pba9pw3k4ZjFW+tdjuosm7mTdxrEBq56z12472fK+0F
         iwWF9ZeVYKvndNdIMYmDeoOj4x83R5y/hN5Ye8v6vFEiClD55hU/osHpkPk4QIxsQpmM
         /fWQ==
X-Gm-Message-State: AOAM530Zcbm8KyUHmfrF0qitWC38EBz6RXaItwf/oWJzbDoxmtYlC6cC
        iAJ+8x1G+qQpP6uFg8qdSAVV5+QZ30ApxH0lL+1NbEf7yg==
X-Google-Smtp-Source: ABdhPJzvRoPzdV3fOPhd8tKiRJ9PDS8uU4hw7694pkvmRePkrALjlKV0vjAi2RR7ktacNNjUQKHKEC5HkZbH8li9nX0=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr20385085ejc.187.1637420812528;
 Sat, 20 Nov 2021 07:06:52 -0800 (PST)
MIME-Version: 1.0
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com> <e5f141ee-43fe-56e9-e47f-f9da518b3e73@schaufler-ca.com>
In-Reply-To: <e5f141ee-43fe-56e9-e47f-f9da518b3e73@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Nov 2021 10:06:41 -0500
Message-ID: <CAHC9VhRx4KSMunuijEF+Bf7GzmBr7zXKwwW2mhOgTg8DfOCsWw@mail.gmail.com>
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() -> security_current_getsecid_subj()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 19, 2021 at 7:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 11/19/2021 2:52 PM, Paul Moore wrote:
> > On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
> >> The security_task_getsecid_subj() LSM hook invites misuse by allowing
> >> callers to specify a task even though the hook is only safe when the
> >> current task is referenced.  Fix this by removing the task_struct
> >> argument to the hook, requiring LSM implementations to use the
> >> current task.  While we are changing the hook declaration we also
> >> rename the function to security_current_getsecid_subj() in an effort
> >> to reinforce that the hook captures the subjective credentials of the
> >> current task and not an arbitrary task on the system.
> >>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>   include/linux/lsm_hook_defs.h         |    3 +--
> >>   include/linux/lsm_hooks.h             |    8 +++-----
> >>   include/linux/security.h              |    4 ++--
> >>   kernel/audit.c                        |    4 ++--
> >>   kernel/auditfilter.c                  |    3 +--
> >>   kernel/auditsc.c                      |   10 +++++++++-
> >>   net/netlabel/netlabel_unlabeled.c     |    2 +-
> >>   net/netlabel/netlabel_user.h          |    2 +-
> >>   security/apparmor/lsm.c               |   13 ++++++++++---
> >>   security/integrity/ima/ima_appraise.c |    2 +-
> >>   security/integrity/ima/ima_main.c     |   14 +++++++-------
> >>   security/security.c                   |    6 +++---
> >>   security/selinux/hooks.c              |   19 +++----------------
> >>   security/smack/smack.h                |   16 ----------------
> >>   security/smack/smack_lsm.c            |    9 ++++-----
> >>   15 files changed, 48 insertions(+), 67 deletions(-)
> > I never saw any comments, positive or negative, on this patch so I'll
> > plan on merging it early next week.  If you've got objections, now is
> > the time to speak up.
>
> It's OK by me.
>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.  Are you okay with the AppArmor tweak mentioned by Serge and John?

-- 
paul moore
www.paul-moore.com
