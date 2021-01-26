Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB3C10F26
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89A0206A1
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404680AbhA0AyG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Jan 2021 19:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392384AbhAZUG1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Jan 2021 15:06:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE46C061786
        for <linux-security-module@vger.kernel.org>; Tue, 26 Jan 2021 12:05:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so21283373edd.5
        for <linux-security-module@vger.kernel.org>; Tue, 26 Jan 2021 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzjmGy0oL0rvnaJhjHzvUitQdjvDnUa+214czaKdGnA=;
        b=oF2cQsl0GAPwXBG2Ww0q9O85pkErIVGR2iQFzCl3fyldSMMolS50vS13rcLJUZGn0q
         pWPzzZN7kJVj6PNIIDihPQ57NR1AUnLEZ7OFW0/nYImJ4O+ZSVaRAzeXPqr1Ou4HQ7Ib
         u3Bj3rVKwapzmtfGoc1+yAu86eqwhaKzCU8dozKHNLfKgBn5LPOGm3HhuJnY1wVdxqlJ
         z2Gf7ICdQXPK2WcXlP+fFEcodWWsIEEXXcZYZe9hz1V2UqLzm6WIVW3Ou4BmNQ3zca0o
         QbwqAxnBI1Kf397ABOuX+Ob4ps7I34H2A15bCd8uRPvhV1pydBKEhcb8/fTV6Pl/1aFl
         z82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzjmGy0oL0rvnaJhjHzvUitQdjvDnUa+214czaKdGnA=;
        b=fXWj8/We7g/fBg/A8cnuM+8ttz3BrMRJ1DxCSs9tgwz9+e8+6P+AxZj1xTwQ9XRfXG
         JLRmju8ni3mnWdSg9eKcP0i2v5b9ogZ+Aw5eWWUnfUpbbYl05T2B+MEE4KpcrkrzEHyJ
         Y//8xOBzdUyaX4Pm9Dtu/VMhiHVTn0GBL4KZHsZ6CYl4ifJEtEl2oWfhGFA8aHDbe3c+
         8JrFTJAfdNn/1GT5DcKkTzqmYpWE2jLP3suAYjBTftszTHP9ff6N6xhcLsrvOYag7xZ2
         aS8w0RfnaykI60y5h/9oOCEeAJMSNqMYViJb2/cZPwcoeUX8wh/dHI/wqyvTv0BvCSsq
         rdCw==
X-Gm-Message-State: AOAM533DUovB1wB3k54L5pkyENskVNtwXoEkuHRtI38FY0uaHAysXl2Z
        TyJP8SbVVxRNhA26O4l1qBHsyRObsgCHV6o+wYym
X-Google-Smtp-Source: ABdhPJyMOLOliiATOkZ4ERhtuxbTd3QWUMvRFlx9Yy9aqe0YyblGN5PjNZyYAGPRFmjGlQK0P3fD+x5QxodPBG51rsw=
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr5868684edx.12.1611691543921;
 Tue, 26 Jan 2021 12:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20210126164108.1958-1-casey@schaufler-ca.com> <20210126164108.1958-22-casey@schaufler-ca.com>
 <20210126184246.GM1762914@madcap2.tricolour.ca> <e9140e2a-a6ca-9d51-9db4-a0ec0dfd56cc@schaufler-ca.com>
In-Reply-To: <e9140e2a-a6ca-9d51-9db4-a0ec0dfd56cc@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Jan 2021 15:05:32 -0500
Message-ID: <CAHC9VhRFQDoNwhdLf4FEJKZzrVq3a5nnAkWS373JSbabdj3Pow@mail.gmail.com>
Subject: Re: [PATCH v24 21/25] audit: add support for non-syscall auxiliary records
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, casey.schaufler@intel.com,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 26, 2021 at 1:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/26/2021 10:42 AM, Richard Guy Briggs wrote:
> > On 2021-01-26 08:41, Casey Schaufler wrote:
> >> Standalone audit records have the timestamp and serial number generated
> >> on the fly and as such are unique, making them standalone.  This new
> >> function audit_alloc_local() generates a local audit context that will
> >> be used only for a standalone record and its auxiliary record(s).  The
> >> context is discarded immediately after the local associated records are
> >> produced.
> >>
> >> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: linux-audit@redhat.com
> >> To: Richard Guy Briggs <rgb@redhat.com>
> > This has been minorly bothering me for several revisions...  Is there a
> > way for the development/authorship to be accurately reflected
> > if/when this patch is merged before the contid patch set?
>
> I don't know the right way to do that because I had to pull
> some of what was in the original patch out. Any way you would
> like it done is fine with me.

I'm not sure if there is one perfect way.  I typically see either a
"From: " line if the author is different from the submitter, or in
more complex cases such as this it seems like a simple note giving
credit in the description might be the best option.

-- 
paul moore
www.paul-moore.com
