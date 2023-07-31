Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81682C001DF
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Jul 2023 23:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGaXNO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGaXNN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Jul 2023 19:13:13 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED5212D
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 16:12:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d1fb9107036so5451900276.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690845177; x=1691449977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIWQwaIJWW2AH6m7nJzzmwOP84vQW5rxfB4Hc5L4BUo=;
        b=IjJOcbHGcC4ZOac+W3yi7m60UCrSW/CzySpZnLwGp5cxE4iUUxa0SFEg+mufLIZ0Vh
         wc9+4lUF4qfV33FmDU2w5Wln53Ocg3R65paebn2djGEDOPeOKnCeq+RcCzNYCxcTGg4L
         oHF9U61NDgBeN+/1LQlJRVuJ/th1vSWqF/zEOZmNS9k51w96VLDQHtzIWQ3y6K5aSnb8
         n2CifxmjVDzWj61tnCVBvwOpgihQKHsXe4aCufmwdbJ2I3dFJF4rfENk/qbMzzm2OIz1
         DFJwNompym00u/FLtNjb0tzXvcdWrrmRM6AuUTsy4FPun7VgGc8c4NtxtIMwVEeHj23F
         sBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690845177; x=1691449977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIWQwaIJWW2AH6m7nJzzmwOP84vQW5rxfB4Hc5L4BUo=;
        b=lAtNWQdukQrosOTNwaSnahBj3j0Z1fQ0150brdpwcNpZWyrdRptt2v/LrYSQ3ZRhGo
         ysesnrk3kf/NlaIqV1ZiAnT8XE1jrKO0/d+ysE9FgbMa8FhtOiPNL94Y6vPZo8ZGW9d8
         3eukTTizCPXh8uZxmK5li1OtVBtaj68kQVJ54czIJ7VSB+w8UV7lraldGJT1hON5e13s
         W+bK0VP76FnCm3tg8jAUossqDfudsgDkOeIyIUToFRj87g6Pp6yf5bO8gpsLppvQ7gGD
         GQ/D1T/cjCNMWhYDURiVMwI5wrOTr8IlQGfW/4uetIkzUCpOK9qskqvV4WiIXJeWUhFr
         qe0g==
X-Gm-Message-State: ABy/qLYf4YTz3ON6ktATQPZ5AH4GUpmEo4eapJipEc+zGz5qbF8Ns3mJ
        rc2gaj3951x33TqMQTnLJ5PL1lbHcg0jLWVtno57
X-Google-Smtp-Source: APBJJlFulKerGdHVB3knYAE6fgtR0BvCzLLl6dr1yYLVbIWyOkLfHwCDxaHBRpR9Gq2ObKDOrC/wkVpmt7gz1yn6o0Q=
X-Received: by 2002:a81:608b:0:b0:569:e7cb:cd4e with SMTP id
 u133-20020a81608b000000b00569e7cbcd4emr11274976ywb.48.1690845177332; Mon, 31
 Jul 2023 16:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690786466.git.kamrankhadijadj@gmail.com>
 <7fd5ea487559760818af96f7c1f2c25bec515049.1690786467.git.kamrankhadijadj@gmail.com>
 <ZMfpGXM5LlDdrENi@aschofie-mobl2>
In-Reply-To: <ZMfpGXM5LlDdrENi@aschofie-mobl2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Jul 2023 19:12:46 -0400
Message-ID: <CAHC9VhQiZG4+t7LGS2JKuArAWifNLTK39v1h+sjhpwS04QGVDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lsm: change 'target' parameter to 'const' in
 security_capget LSM hook
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, ztarkhani@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 31, 2023 at 1:02=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
> On Mon, Jul 31, 2023 at 12:07:31PM +0500, Khadija Kamran wrote:
> > Three LSMs register the implementations for the "capget" hook: AppArmor=
,
> > SELinux, and the normal capability code. Looking at the function
> > implementations we may observe that the first parameter "target" is not
> > changing.
> >
> > Mark the first argument "target" of LSM hook security_capget(...) as
> > "const" since it will not be changing in the LSM hook.
>
>
> The commit message may be simplified, from this:
> [PATCH 1/2] lsm: change 'target' parameter to 'const' in security_capget =
LSM hook
>
> to something like this:
> [PATCH 1/2] lsm: Constify the target parameter in security_capget()
>
> "Constify" is the commonly used language in git logs.
> See git log --pretty=3Doneline --abbrev-commit | grep Constify

I'm not overly worried about the subject line; yes, Allison's
suggestion is an improvement, but the original is okay.  However, I
would like to see patches 1/2 and 2/2 squashed together into a single
patch.  If patch 1/2 hadn't already touched the function declaration
line that was too long there may have been an argument for keeping the
patchset as two patches, but since patch 1/2 does modify the function
declaration we might as well wrap that declaration line in that patch
too.

--
paul-moore.com
