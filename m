Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D42C433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 00:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBBC64FF7
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 00:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCJAXu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Mar 2021 19:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCJAXe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 19:23:34 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D7C06174A
        for <linux-security-module@vger.kernel.org>; Tue,  9 Mar 2021 16:23:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lr13so33395841ejb.8
        for <linux-security-module@vger.kernel.org>; Tue, 09 Mar 2021 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGJKH5Nan57Lb0mYe8qLU+a35AfEmCmHaoAdvSVrNjs=;
        b=lrLi1E0+RNryuYxTa0WH5+lVNkr+E1o7dG9oLEXBhHjnUOdzCZ/ebBWiSsnNk3E/cS
         sz9tNopTLdknwV6DnuHhoDx1hYhTmDiGF3po1G5zP1Em8nwa7HOub1hipaON5H4GWsHf
         6qfisZlkjZqEo59L7w6QAVUqgQHIDSPASetMfHhs7V2Ib47vCDgcnvMw+TLF4wi/dxmR
         OGLHTWS0R7I4D5UUVps+g8BXZj9tLt9jxgm1LKNaMAdWzZvU6KQlWWk7cKKBsHhFNM21
         fx84u/dnbQTrdOCezEGQoqJ9Nd64FI4esnNKsu0PWzEg2MXXc1CHwqqTtqzS8RDFsPFP
         F5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGJKH5Nan57Lb0mYe8qLU+a35AfEmCmHaoAdvSVrNjs=;
        b=TzpSO+rmbkTencLQd16dP20I7MUdy5uGOT2EM1aawZq9qTFu+9CSnwA+EOPdcomAVX
         jG4disQWj/Q7769RLx/7c1L7fh+axVbFGt3ZmTq6vAoRA50EYbaaoqSe7OR4+4b+5GMO
         uAhy57lazOGfApFtZTew4+ehs1UagxE1XDCh7W6atYRhj52ZtehhR8qzDWuT8/ns02/3
         sVGXRWIPT+rEnjhoYNPtG5ISFn28MYLv05m4tpvqKcFwI3G/gIMlvZd3v01Lq9m7jllz
         a62ueHdzAE7kmNPSBBMKzqE7eVGQ3aldGO8O/jXyYSIyp5+wEm3OIAURFcndSpNYXBJS
         uG2A==
X-Gm-Message-State: AOAM530xnrsVInBOye14NH/OW0prMs3+34ppvxsDdUScbKtkhmVJFm9R
        xJa1Q0mwTrfmNBAztEWtaw7QMw5LMGffpIr+51gtExs3h9i4
X-Google-Smtp-Source: ABdhPJwewkchC/561Qkcxt5+GUOEDDdtdYmovXavaPjjsS4wklRjuMtlYLZeVhTPRiH1C9bajE5N7jzr553wewMP674=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr717555eja.178.1615335812584;
 Tue, 09 Mar 2021 16:23:32 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <20210308192529.GY2015948@madcap2.tricolour.ca>
In-Reply-To: <20210308192529.GY2015948@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 9 Mar 2021 19:23:21 -0500
Message-ID: <CAHC9VhQYhH+jJzSx-A8Lm8wnRwZGpUedY8ByEdOh63nGnmJkJw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 8, 2021 at 2:25 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-02-19 18:29, Paul Moore wrote:
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
> Audit: Acked-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

Thanks Richard, I added your review tag to the LSM, SELinux, and Smack patches.

-- 
paul moore
www.paul-moore.com
