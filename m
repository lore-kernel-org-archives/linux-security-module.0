Return-Path: <SRS0=R80q=QB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A46C282C0
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 21:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5B218A6
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 21:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lc/aFiHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfAYVHJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:07:09 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40045 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAYVHJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 Jan 2019 16:07:09 -0500
Received: by mail-yw1-f67.google.com with SMTP id g194so4455925ywe.7
        for <linux-security-module@vger.kernel.org>; Fri, 25 Jan 2019 13:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VU+UpXMzZomlvxxPc5lgQd3Ft+LreTWWRPjLSHYDhDE=;
        b=lc/aFiHf+x17zX/HEvx71/dF6Eq1qE7Vw2p/Y38MTAMFPVrD1zTRhjJ5+iWyYOTVMv
         ylNQERYr+RyXJQQlbHZLJ7vngHz8vn2jKsym1+Aw/nHKmYcGdHfTxxQSUN2JxuVKJUFg
         CC/nSWWrAx5PdgizEKfHMOxAJsgDT1uEQGWg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VU+UpXMzZomlvxxPc5lgQd3Ft+LreTWWRPjLSHYDhDE=;
        b=EYsxFojt7W6DnbKLIOGADFigIzeK616mUOkgKwB13KvEktkBwSToOL48E8qWjKTPj+
         27ai9bp6ntX+vTqRnuSEUiUvzZ0T4Txs3T9zJY/ayS1wByAKgt86uZsRtXVhu5dP3Qi8
         ZZcdJuXbvZ76wEQCrOEnOFlQgdIP77hfN3oP1Sy5+Qjc9R/UobxmhCGuC1pA8pKe+WbP
         AMNvo+dS2NepBrYVLpKwsMbTvUqDIEnT8Bfp7+atBQA4Ks502i/Bhuow+r9eajszsEm4
         XWyUqgl/wfc723OQmHTfOveqBBr8LMmL4YDJmXarWzMl59c6JpKqwYUSPst35dy/NmXl
         fMJA==
X-Gm-Message-State: AJcUukeC8TYyKD6pn6R7T8gQSFn6V3ApOWuD+9bW+CG4Jio9lztowN3x
        W2U1z6V6JdX52sGgrhAB0AwGJ+z1WzK9ScRO6j1R6w==
X-Google-Smtp-Source: ALg8bN4nzbZ9eTEUWAt34+M+KZ4kLrnerAbSLgV0Jmgx2sK9YxnU4eesoEkLMK/K4IEKUrOcvIPF+m6DB0bP/vpmOOA=
X-Received: by 2002:a81:c709:: with SMTP id m9mr11854942ywi.322.1548450428476;
 Fri, 25 Jan 2019 13:07:08 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org>
In-Reply-To: <alpine.LRH.2.21.1901260714380.27585@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 25 Jan 2019 13:06:57 -0800
Message-ID: <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid calls
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks!

On Fri, Jan 25, 2019 at 12:15 PM James Morris <jmorris@namei.org> wrote:
>
> On Wed, 16 Jan 2019, mortonm@chromium.org wrote:
>
> > From: Micah Morton <mortonm@chromium.org>
> >
> > SafeSetID gates the setid family of syscalls to restrict UID/GID
> > transitions from a given UID/GID to only those approved by a
> > system-wide whitelist. These restrictions also prohibit the given
> > UIDs/GIDs from obtaining auxiliary privileges associated with
> > CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> > mappings. For now, only gating the set*uid family of syscalls is
> > supported, with support for set*gid coming in a future patch set.
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > Acked-by: Kees Cook <keescook@chromium.org>
>
> Both applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
>
>
> --
> James Morris
> <jmorris@namei.org>
>
