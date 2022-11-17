Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878ECC433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Nov 2022 22:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiKQWK5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbiKQWKn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Nov 2022 17:10:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E665686B3
        for <linux-security-module@vger.kernel.org>; Thu, 17 Nov 2022 14:10:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jn7so1049237plb.13
        for <linux-security-module@vger.kernel.org>; Thu, 17 Nov 2022 14:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/4ID+KGqIpF7f9TNHDnM6KtMWXO/tfa6FGXAfCVxIwI=;
        b=LvMwcx1KQczxaWg9/bbbSWwIqx/kxafm8W9ecNm3Ux4i3SrQ8+hFXoZtzYqMBYUNV6
         iYElfm1vnVPlEBY8K33r4+S0vUpf+l10yOqLrgA40UYXLUFwi4QcSETHzi/jUL8wEC4T
         OnJUYpO//NEiMuAuO1EHANwiTTT3Xn2JkIbTf6OiU9vLhBltP190dGl6lLnYfS49odBy
         NSZ18yyyDumt7kUP9zFrPo5Rqt3dtvpf0ZtNmyfEpf+fUR8tFQtDQHhqPwo7i7C78Ey2
         TehU6XMMxfS9p3VFlHugdyOAe5uQZDXpuUnsOvlewv4TEB2LBA7IzWUmJipQKzo6abG9
         VN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4ID+KGqIpF7f9TNHDnM6KtMWXO/tfa6FGXAfCVxIwI=;
        b=QjzQ460vuE+Uq0h2M2dCdy7AXFmJG2+G8mAStljsteRHPNa+6HKTKP0fiOHok0iTOv
         FhrXr17n/vad+vrLmdecniGOt3BMFjOTzy+cU7TV3x8ynZOTU5JUMCRywyL2Z+qm9jhQ
         oBBnHkszp3O4A5P0Jpk5mhAcheELNQfHKGB8aHQSdfkgFBWjWmQO9xqWA4RI/Mklf3YL
         NCB+HIEmCT6bMvLwGb1xUlQDG40OUphYh85fYZhxTQMCCr37r9fcPc1Xvknwpvr+saTt
         LJx/gw2ZW5iAKmO54cKFSDKluERc4qGIxj5pnf2s9p90YMSHbeH4kSnUPTFq6RI4EUES
         4yZg==
X-Gm-Message-State: ANoB5plok+aWas3DpgL6bXFbdpjX26oW5VRP7qOhnWJnroPPhQo0EcLp
        DRY+DRxUClKVH2SunRzjNme5Ds4JhGQrJaJNJ6Mr
X-Google-Smtp-Source: AA0mqf6n+LAt2AwQRla1Lj5qZPoGeOE7479aiIYy8ezwA6Z6pfLIMdYFmsUC0gygdu7M4FQz543/y1sB3TRrpkf+hKs=
X-Received: by 2002:a17:902:edcd:b0:186:c3b2:56d1 with SMTP id
 q13-20020a170902edcd00b00186c3b256d1mr4681556plk.15.1668723019096; Thu, 17
 Nov 2022 14:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20221116125051.3338926-1-j.granados@samsung.com>
 <CGME20221116125431eucas1p1dfd03b80863fce674a7c662660c94092@eucas1p1.samsung.com>
 <20221116125051.3338926-2-j.granados@samsung.com> <20221116173821.GC5094@test-zns>
 <CAHC9VhSVzujW9LOj5Km80AjU0EfAuukoLrxO6BEfnXeK_s6bAg@mail.gmail.com> <20221117094004.b5l64ipicitphkun@localhost>
In-Reply-To: <20221117094004.b5l64ipicitphkun@localhost>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Nov 2022 17:10:07 -0500
Message-ID: <CAHC9VhSa3Yrjf9z5L0oS8Cx=20gUrgfA8evizoVjBNs4AB_cXg@mail.gmail.com>
Subject: Re: [RFC 1/1] Use ioctl selinux callback io_uring commands that
 implement the ioctl op convention
To:     Joel Granados <j.granados@samsung.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, ddiss@suse.de,
        mcgrof@kernel.org, linux-security-module@vger.kernel.org,
        io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 17, 2022 at 4:40 AM Joel Granados <j.granados@samsung.com> wrote:
> On Wed, Nov 16, 2022 at 02:21:14PM -0500, Paul Moore wrote:

...

> > * As we discussed previously, the real problem is the fact that we are
> > missing the necessary context in the LSM hook to separate the
> > different types of command targets.  With traditional ioctls we can
> > look at the ioctl number and determine both the type of
> > device/subsystem/etc. as well as the operation being requested; there
> > is no such information available with the io_uring command
> > passthrough.  In this sense, the io_uring command passthrough is
> > actually worse than traditional ioctls from an access control
> > perspective.  Until we have an easy(ish)[1] way to determine the
> > io_uring command target type, changes like the one suggested here are
> > going to be doomed as each target type is free to define their own
> > io_uring commands.
>
> The only thing that comes immediately to mind is that we can have
> io_uring users define a function that is then passed to the LSM
> infrastructure. This function will have all the logic to give relative
> context to LSM. It would be general enough to fit all the possible commands
> and the logic would be implemented in the "drivers" side so there is no
> need for LSM folks to know all io_uring users.

Passing a function pointer to the LSM to fetch, what will likely be
just a constant value, seems kinda ugly, but I guess we only have ugly
options at this point.  I imagine we could cache the result in the
inode's security blob, assuming the device type remained constant (I
can't think of why it would change); still ugly but at least it
doesn't require multiple indirect calls.

It's probably worth throwing together a quick patch so we can discuss
this further.

--
paul-moore.com
