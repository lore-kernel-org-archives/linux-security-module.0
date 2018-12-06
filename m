Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD45C04EB9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 00:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0A2082B
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 00:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0dVYOy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C0A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeLFAIc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:08:32 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35790 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeLFAIc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 19:08:32 -0500
Received: by mail-yb1-f196.google.com with SMTP id z2-v6so9723282ybj.2
        for <linux-security-module@vger.kernel.org>; Wed, 05 Dec 2018 16:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7gSrNWEbVBq+sjJVUFXYPRA+Q77K5qNNIh9PPBqtlE=;
        b=P0dVYOy+DOdDqmuFBsG3rUpVYN0K333uOusA+iO9mMbW8cKf2wTjUXNQywngpGzdQ0
         jcF3VmQC00rYYMbS5h9MKA6YBzRY0iNvqskz0F1kEFkGerW0TKvOV+WbNzcHvYHyEwx6
         0T9PPEZGiP41AS93l5feyvzzg8Bs+urWxecsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7gSrNWEbVBq+sjJVUFXYPRA+Q77K5qNNIh9PPBqtlE=;
        b=Zy0khZ7s2w7HPatqJhb2fXo1ZL6MBcGIPbSPYyxKVppAvYb2PAKRwDuV7d/CNqCXuW
         84kAhZ31egvtznuYPjNqPfaNWYjYdPrMigIiD1i6ffNc14r9qkS4VFvmycn+NDmLq8DC
         HKWPFkIzTMza3L0UUOvglLCONn75eBD1bzgahxdk3tmTDblTf/nmGaoPPTkIifJFeh71
         EAQAhDTs3ZKBuAmaqdxCEQSWHZ+DMLXOnx6Q58iT2xrAws/b+m7QLbHZIJkhqPA1Xzvu
         SaMC5H/t2NjAz6b+1/EBEaqCfe3jVTvKRN7GSQ3VKijLcYmNor2F6bOs/PuYz6ODkeXl
         o/pA==
X-Gm-Message-State: AA+aEWYOTZuWYIeO+xUcTV8BJE7DuIhAqlNUMUV41uImhXN1gC5k5uUK
        HdLKGnH5XTrWh/IJxGfzz7gB/9Ey2Ho=
X-Google-Smtp-Source: AFSGD/WFql4dsEEbUQNP/e6VMnew38QHbaL7VejrX9hoLN2jeNDbMTIdq+kZMcX19wXtRMnTUTckvg==
X-Received: by 2002:a25:2b05:: with SMTP id r5-v6mr25812302ybr.81.1544054911345;
        Wed, 05 Dec 2018 16:08:31 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id w1sm6341243ywd.49.2018.12.05.16.08.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 16:08:29 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id j145so4812067ybg.11
        for <linux-security-module@vger.kernel.org>; Wed, 05 Dec 2018 16:08:29 -0800 (PST)
X-Received: by 2002:a5b:2cd:: with SMTP id h13mr7617966ybp.403.1544054909131;
 Wed, 05 Dec 2018 16:08:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-EccPiKPR-ZB+V=tTyAB3Gru2n_Pt4PFxEQf_3y_4c8g+TLg@mail.gmail.com>
 <20181121165409.54278-1-mortonm@chromium.org>
In-Reply-To: <20181121165409.54278-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 16:08:16 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com>
Message-ID: <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 21, 2018 at 8:54 AM <mortonm@chromium.org> wrote:
>
> From: Micah Morton <mortonm@chromium.org>
>
> SafeSetID gates the setid family of syscalls to restrict UID/GID
> transitions from a given UID/GID to only those approved by a
> system-wide whitelist. These restrictions also prohibit the given
> UIDs/GIDs from obtaining auxiliary privileges associated with
> CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> mappings. For now, only gating the set*uid family of syscalls is
> supported, with support for set*gid coming in a future patch set.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
>
> Sending a patch developed against the 'next-general' branch of the
> linux-security tree, since the previous patch versions wouldn't apply
> cleanly to 'next-general'.

I'm finally getting back around to this. Sorry for the delay!

A few general process notes:
- Please "version" your patches in the Subject (e.g. "[PATCH v3] LSM:
add SafeSetID ..."). This helps track discussion.
- Please include a "changes since last version below the first "---"
line, to summarize what has changed. This makes review faster for
people that have read a specific version but need to catch up (like
me) :)

> +/*
> + * TODO: Figuring out whether the current syscall number (saved on the kernel
> + * stack) is one of the set*uid syscalls is an operation that requires checking
> + * the number against arch-specific constants as seen below. The need for this
> + * LSM to know about arch-specific syscall stuff is not ideal. Is it better to
> + * implement an arch-specific function that gets called from this file and
> + * update arch/Kconfig to mention that the HAVE_SAFESETID symbol should only be
> + * selected for architectures that implement the function? Any other ideas?
> + */

What would Stephen's solution for this problem end up looking like? I
think avoiding the arch-specific-ness would be quite valuable.

I think adding a capability for this isn't the way to go (there is a
very painful history on adding capabilities). This feels much more
like a good mapping to an LSM (it's narrowing a privilege) with a very
specific policy.

-- 
Kees Cook
