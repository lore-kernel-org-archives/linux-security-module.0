Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C8C001DF
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jul 2023 16:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjGUQMn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGUQM3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 12:12:29 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EF4211
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 09:12:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bff89873d34so1872617276.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689955906; x=1690560706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxyXwUMYyMvFKFhBcqHjy6FPhm+754pa75RGLMebRPg=;
        b=Wj+FUhDvmTTeRSt9GaR6tT+3MpYlB4CoZ9KWDMJGexsGe20N+xrnxTgIMSctx8ApfR
         EWLBqTE2J3z2aNzKu9T21hFYuf4gqvmY+BWZZLAVsvQssNtzRZsRYJHCUn7lM9Zx5VZv
         Y9LJbGNtTTxgUpi+Ooi51JzwchZVJAriStKfAFU79+X2s879ekFC4GPubWJ8G5H9iq4c
         OGryoD/XHUmN09lH4+tPMlk+Sa2ictQRXSDhJBq6bOdA7PlcKCwTPrsO8oo3JEfgvaCL
         WlSSokMxu+nyn8RY+R5zjvItZEjv4nxU0j99yqgGEAr1am/w5TPQTmTwDTWQWVVYXeY/
         dA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955906; x=1690560706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxyXwUMYyMvFKFhBcqHjy6FPhm+754pa75RGLMebRPg=;
        b=F6xA5Z1uC9Zt9BConp1qGISQ9qJgq7ZG8zZI8f3zZg/6s19vXLiiDJoWj579rqm9t1
         KSZfELxYoHemvr6yXlnPS9jwYLNWDtlws0OIpgvEQXaH7NJHEfW4veyzrHrdOm6mVdG2
         BcIJ1yKTFf0uW01zfAQxYnGq/9GB+lJAivfT3bETlZAVO0LxAfm2OfkHo0o9ZewyBCLu
         Aj4hldL9jJ4jkvSIeaSg5VLfaLipKTDc/s3QGl3ZgCQ7Or4b6K9RgixXgBSLU1ncWB/m
         ef2h84NDJF1TJcnRopTYXWqjOdAbg/QZO/i5O+1VgP4EfCs/XnT1FEzWV8kMwaRA9Mtu
         AOYw==
X-Gm-Message-State: ABy/qLbZVrbVOAO+7zpUkVTgsxDGYy5s2HGrCpaX4wwJpZqCgCjDz/rs
        fQa390VCwZTwJ6uIpvfdflpbYrn2mAitstnszakN
X-Google-Smtp-Source: APBJJlGoHBcPT9hiWIWL6i3mvF4rekhA0utDaCn/hE81JlepiVuxAGpbe69fcrxsAy+mQbEZo7YWwncQp01TNjEWgQQ=
X-Received: by 2002:a25:9c82:0:b0:c01:308a:44f2 with SMTP id
 y2-20020a259c82000000b00c01308a44f2mr2067818ybo.57.1689955906621; Fri, 21 Jul
 2023 09:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
 <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
In-Reply-To: <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jul 2023 12:11:35 -0400
Message-ID: <CAHC9VhTRkWL_R0xdnrYChwmbp3FvXKMjQYpdBn9OvCH23mW=bA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 21, 2023 at 11:35=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Hi all,
>
> On Mon, 2023-07-17 at 16:27 +0200, Paolo Abeni wrote:
> > The only
> > remaining perf-related pain-point I see is the indirect call at the
> > security_ level, and tackling it looks much more difficult... :(
>
> I spent a little more time on this latest topic. AFAICS recently such
> overhead has increased due to the bpf lsm introduction. My
> understanding is that a major LSM and BPF LSM simultaneously enabled is
> a common usage scenario. That means 2 indirect calls + 2 untrain trails
> and 3 additional cache-lines used per hook.
>
> Under the assumption than having multiple major lsms enabled
> concurrently is less common, I hacked some (not exactly spectacularly
> beautiful) code to avoid the above. Basically, after initialization,
> for a limited number of hooks, it checks if only the default major lsm
> and eventually the bpf lsm are registered and if so, converts such
> hooks to static call[s], using static branches.
>
> The idea would be to keep the above infra usage restricted to the most
> performance-relevant hooks (e.g. one-off initialization or
> configuration  are not relevant from that perspective). For obvious
> reasons I started from a few of network related hooks ;)
>
> As said the code could be more nice: there is some quite heavy macro
> usage and some duplication I was not able to avoid). On the flip side
> it shows quite measurable benefit when enabled, 0 impact when disabled,
> and it's available to all major LSM, except tomoyo (but even the latter
> could be accommodated with some effort).
>
> If there is some shared interest for the above I can share the current
> status and try to cleanup the code.
>
> Any feedback more then appreciated!

KP, the BPF LSM maintainer, has posted patches to move the LSM hooks
over to static calls, but to the best of my current understanding the
patchset intermingles a bug fix with the performance improvements,
which I want to avoid.

There have been updated patchsets posted, but the original link
(below) contains my comments:
https://lore.kernel.org/linux-security-module/20230119231033.1307221-1-kpsi=
ngh@kernel.org/

--=20
paul-moore.com
