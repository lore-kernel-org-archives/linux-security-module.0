Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5397C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Mar 2021 01:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8772764DDA
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Mar 2021 01:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCKBzw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCKBze (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 20:55:34 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4AC061574
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 17:55:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p8so42889857ejb.10
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ypaibdj5e3KXs0JU5bHysEKmmO+AWX8qecTeOE2LAd0=;
        b=omi3UiVNbKwW6vpg8mJyXFbZh5TL1G+aAt+PHFqRvp5GOWs6ZOhOSwB6sK9jDJG+qd
         Pd8LVRKmTh76Z0TcBXh+bh5bPnsposxwNIgJhuy7GFY6P6lFS6tJv7HJyWrTL4DrGkdc
         A14EhG48Ua00TWp6SSHMxYxWix9LB+/rPIbpNC9LFjvBzEoddFHjTGJwyVFmensZVrMV
         +cYz2POxRAaK89T6TmV5U7oYKl/JheqskJrVF6E6wuoLPs/bLebYcjzxc/AHUggNP1SK
         Ltu5mtxIoNi0BAzNAFmwDCQJRaBYrTxgdzsoKiNcR22QUPgs3VW0GUggxx6EN1+GA1wy
         XF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ypaibdj5e3KXs0JU5bHysEKmmO+AWX8qecTeOE2LAd0=;
        b=ow0LCYm8sQAZCc+eAxGBmLudFUhFBPRU/ZDdGcFW0c2T2Nt6/tesZdNzKwhR4gJi1i
         u5r+qCEjEcr6MSUJMpYu5d1249/iWRfnJbjZ9+5ZG2NAyUvPEBS27F4KOy8Gp7ayIa/T
         UQV0Lg9Qw+6WN8uEY5RB+cbBYziwUs5fEF6Dx0EVNw1+E9mgSe604RgWd4DJhC+l0pje
         aZyexDLpd5432nvXoOd3XB9uB7H/LewLkpgIFbX6FW2j2hmDRp2bZfJQf1Gt+pci+QGX
         MOZjWhR4AyOlL0zrWV7fFr69VNo6xztlnJH0YKipJRpaVynKTOQO3psWrXo74ua43R9j
         tMPA==
X-Gm-Message-State: AOAM5317l2KC6NlITWwBn2snEC/R0l2Cvt+TL9toEN7fpL8Sf9aeWJRF
        qL/CB1An8Y3Kpj7A8CRaDubZLiZmewP2G4xl4agt
X-Google-Smtp-Source: ABdhPJwhgpk+Bqtj76Jv2/UFtXcPG6p4xzvX2zWBO561yrSUVSlX73taqpcNagxjLeBsuDUe0Xy8Jefb88aN5kND5Rc=
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr726523ejf.488.1615427732811;
 Wed, 10 Mar 2021 17:55:32 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <df8827b4-7844-7ab3-9e09-0c116bcfd6e3@canonical.com>
In-Reply-To: <df8827b4-7844-7ab3-9e09-0c116bcfd6e3@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Mar 2021 20:55:21 -0500
Message-ID: <CAHC9VhRmsc9K9EAbzsw0_oXETFu9VWN7+KrYxVUt4FLOPpSHRw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 9, 2021 at 8:03 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/19/21 3:29 PM, Paul Moore wrote:
> > Of the three LSMs that implement the security_task_getsecid() LSM
> > hook, all three LSMs provide the task's objective security
> > credentials.  This turns out to be unfortunate as most of the hook's
> > callers seem to expect the task's subjective credentials, although
> > a small handful of callers do correctly expect the objective
> > credentials.
> >
> > This patch is the first step towards fixing the problem: it splits
> > the existing security_task_getsecid() hook into two variants, one
> > for the subjective creds, one for the objective creds.
> >
> >   void security_task_getsecid_subj(struct task_struct *p,
> >                                  u32 *secid);
> >   void security_task_getsecid_obj(struct task_struct *p,
> >                                 u32 *secid);
> >
> > While this patch does fix all of the callers to use the correct
> > variant, in order to keep this patch focused on the callers and to
> > ease review, the LSMs continue to use the same implementation for
> > both hooks.  The net effect is that this patch should not change
> > the behavior of the kernel in any way, it will be up to the latter
> > LSM specific patches in this series to change the hook
> > implementations and return the correct credentials.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: John Johansen <john.johansen@canonical.com>

Thanks John, I know you're swamped these days.

-- 
paul moore
www.paul-moore.com
