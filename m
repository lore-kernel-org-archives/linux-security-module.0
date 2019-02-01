Return-Path: <SRS0=Dufg=QI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8226BC282D8
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 04:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FAF20870
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 04:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0H8pPcQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfBAEPd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:15:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46226 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfBAEPd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 23:15:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so4570437ljh.13
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 20:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuAxQNnz4JfV6RyqsxAaxKZUtlXOtNedJmlXgQat1+s=;
        b=0H8pPcQLiQEhNphiU9nAFqMUVYB+7pe6dVLP5oI2RVYUlegAYkrlu6GqsuJEDNxyue
         kgscdTVH6YL9XZKxU80JHFiergRqiMuY1wCNU5dMZ6ZudPGSli6mWas/diGG35ZbptNz
         ZlbWgilj0y+EXF0FVYedVlZkD757cNg0ZGVGyyY4/U91ZGW8Mo/Vj/QKfOMua1Qm29XK
         bQQPntWgsnQ4W2QNF7hE/oQsoPPHLxrPGdj29Jtc5e3vj9vzdlPXqVlOoZ8ncs0u1dhr
         Ylhb0DD3t+38Dlew69AA8wILb+K65qCfTph8NlPn6t7VvQqIwZxiSsHDp6oTC8fZDPO0
         MF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuAxQNnz4JfV6RyqsxAaxKZUtlXOtNedJmlXgQat1+s=;
        b=XArWY/gVUnJP21j3hDXQV8FpizEnXmy1GTjKy4masTwp+a5keqkucLOysKLkX878Mw
         L2rCnh5xB3YvY2loevPhF70dLjRh068Ij9K3SD/LFafiFFaWFSF6hRp01ObjI/TrXCjG
         lLEWWq/PhR9GxiaDSfbXsij7vmX8S9q60zdkjvh8mvDErENZzIjhjX6kmbZirrlhCzb1
         42dO0p6afgEjotzh9oD4nMLZ4d+UKXDmatcjWO8OTC3BCP2WzV/Nju0spL0L2qc4cUJ1
         hBWJS8Eb3tXzWVjPblw+Ae0Fjxvx4xbT8yuxHVnakOycs0EJavENQ0S+7rkRKemcGM/1
         CFVw==
X-Gm-Message-State: AJcUukdjQSU34a1EMfxACJX52ZzDnUnhN4Pz7PzKgVdwdSv5Nwf8Icv2
        awyRN9NVCKaDCmE2yNtt00xlzsXeDUVIo6g/SUd2
X-Google-Smtp-Source: ALg8bN59OTVaQunAMT0jkn2qWGS6fSDOCeoXYff25pzLthWKqlbrDMVgSs6mKK9ePvVi8cAV+USfpaWB54ouiUUK/AI=
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr28529803lji.196.1548994530917;
 Thu, 31 Jan 2019 20:15:30 -0800 (PST)
MIME-Version: 1.0
References: <c3bc9d90ed20f1b1cce916636a28f1e85af1afdc.1548953334.git.rgb@redhat.com>
In-Reply-To: <c3bc9d90ed20f1b1cce916636a28f1e85af1afdc.1548953334.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Jan 2019 23:15:19 -0500
Message-ID: <CAHC9VhRqeeuVZdARyCSJBumrQtTf7053qMAsfJXJfDrzDOYXrg@mail.gmail.com>
Subject: Re: [PATCH ghak107 V1] audit: remove unused actx param from audit_rule_match
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 31, 2019 at 11:52 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The audit_rule_match() struct audit_context *actx parameter is not used
> by any in-tree consumers (selinux, apparmour, integrity, smack).
>
> The audit context is an internal audit structure that should only be
> accessed by audit accessor functions.
>
> It was part of commit 03d37d25e0f9 ("LSM/Audit: Introduce > generic
> Audit LSM hooks") but appears to have never been used.

Merged into audit/next, but a heads-up that you added a ">" into the
referenced commit title.  I'm not sure if that was a cut-n-paste
problem, or something else, but just a note to be a bit more careful
in the future about those things.

> Remove it.
>
> Please see the github issue
> https://github.com/linux-audit/audit-kernel/issues/107
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
>  include/linux/lsm_hooks.h           |  4 +---
>  include/linux/security.h            |  5 ++---
>  kernel/auditfilter.c                |  2 +-
>  kernel/auditsc.c                    | 21 ++++++++++++---------
>  security/apparmor/audit.c           |  3 +--
>  security/apparmor/include/audit.h   |  3 +--
>  security/integrity/ima/ima.h        |  3 +--
>  security/integrity/ima/ima_policy.c |  6 ++----
>  security/security.c                 |  6 ++----
>  security/selinux/include/audit.h    |  4 +---
>  security/selinux/ss/services.c      |  3 +--
>  security/smack/smack_lsm.c          |  4 +---
>  12 files changed, 26 insertions(+), 38 deletions(-)

-- 
paul moore
www.paul-moore.com
