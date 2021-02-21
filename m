Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C66C433DB
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96C264EBE
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 22:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBUWKy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhBUWKm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Feb 2021 17:10:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562B2C061574
        for <linux-security-module@vger.kernel.org>; Sun, 21 Feb 2021 14:10:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j9so19600727edp.1
        for <linux-security-module@vger.kernel.org>; Sun, 21 Feb 2021 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN1sK8RFllvg7dBWAUIfT/4UQI2B6q3N2wJPnPice2I=;
        b=bEAmjj4CNm7qVYSlzvKdcWfKM3Cm21yRjERfOjdQ5T6QhmGf+wihCzQl12nngVVKYY
         QE61CVSvKt2ly76eNWQTS/Gl+IrcqT1jcP3mTpuoK1CEo6+S326R1Y8FfaDqAvSsflGC
         7tfCsVbD7Ff0DDxCd8tk96/4kJct6ZNl+qIci33Rl2jeXd+PUD32BodBRrXOsUXOuC9R
         SiwVZJt6OMwq1BbH3iAnXCGbCOO6cplrCpSakhjtN1HL7Co7mx3jdr1MDwu/X8g+Ob3s
         P4EGlTP/GF3AADTvkLECWBV4LhEnm12qbKSWQmu5s/KnzUOcMpgPaM/1uY5+7RhBp9LD
         Axqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN1sK8RFllvg7dBWAUIfT/4UQI2B6q3N2wJPnPice2I=;
        b=lFyWiTgdZgKs8KxgX9TaTXRk0owGw+zkWblvQSW9NPgsbOEtP8AD6Ig/7CLFxmOwB7
         Vqw4qZqd9EINnxElxxXP+kNvmZp8Vug84Mp3fYUde+UiCe8oUqFQBB5+b9Km5hrSGR+K
         sFe6UvkAeMA8kz9V+osrhNGSkmOs1hD3km+w3c/5VjPrGYLBXuS7qe9J3YGWmF7j51F0
         tuvybMyJ1Pp4uCGQpJlHTgydf+S3LWVJKCKlv6bTiW3F8WRhKZauy662KWuGOYY+VsRB
         MYEVXglfjSJ+7ND4k0E+lLN07pmCJWaqQ4jc1WZqR+nEcAsiqzgfbLcmbAfvdy2iukz3
         dvzw==
X-Gm-Message-State: AOAM531eBGg/pP4gMpBh7pPZlKbtWH9X5sUc58xTZSFMbewDlJt6eYPQ
        bhFHkzV+k8pdHyTpP5hkIcsKGlcMOs45kvFg736S
X-Google-Smtp-Source: ABdhPJwE2/G4txzfFpoJa9YYX4zVKE0K5UxfNLw6f6HPda8Lb0pXnEPPV+LE/MsLJtsaszxlMwyr7TomsR8D65/GIPU=
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr19363674edc.135.1613945400830;
 Sun, 21 Feb 2021 14:10:00 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <b2f85cf5-a110-68ae-47b6-276dd8062be7@canonical.com>
In-Reply-To: <b2f85cf5-a110-68ae-47b6-276dd8062be7@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 21 Feb 2021 17:09:48 -0500
Message-ID: <CAHC9VhSYW+pRT64ayO2es1_8jt-g8O48h1eUm9-Hm=eiwmeEJg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Feb 21, 2021 at 7:51 AM John Johansen
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
> So far this looks good. I want to take another stab at it and give
> it some testing

Thanks John, I appreciate the extra set of eyes.  Let me know if you
run across anything wonky.

-- 
paul moore
www.paul-moore.com
