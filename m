Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCEC04EB8
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 17:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1A20878
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 17:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YC2TM+46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B1A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeLFRvs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:51:48 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42597 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLFRvs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 12:51:48 -0500
Received: by mail-yb1-f193.google.com with SMTP id s8so1089854ybe.9
        for <linux-security-module@vger.kernel.org>; Thu, 06 Dec 2018 09:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQfJZZDCk/+NTl1j5M63/e98hlmthlA6hhXEYE4B4uo=;
        b=YC2TM+46HutoJLLjf+0eXH8bWfz050XBi+JPfRy4/LecXgExls6tNBcCsfrnVnnZ70
         QXIpQRUj9AEcl2fg1dQ419S/+BxPkM4FxLl19SacA6LLSq/obSwJ5EYJIoeIT08rvnuK
         GG3fkG/J4xxvgfk5HRPJGqKOz+jbHFxnKx/BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQfJZZDCk/+NTl1j5M63/e98hlmthlA6hhXEYE4B4uo=;
        b=jXcpgB538Cm6HE7Umzhzwf4k2V+SrEqY59EoPJRbMWAQFAYSiFXsf7caFbywTIqQtZ
         3V9ktWats1dAHwSFXj2K7bWW/nwDwKKFfaWNAZ4Hkx9/q6VqbV3UN0HoBjVdqr7axSl4
         +MLEutbgI6cs68XTC/2tNRAX7uvVqh1IbI1YeKFnmjb3jV76z0uB2aXSdldu5d6j+tiG
         dSGs2MBc9mqM55Hsgaf0SNi3Ur6tEl+eP1UK/zJLZpIRvUS6RcmSGwmiTh10LN/I2/S+
         8ViHZ67jhgcvmxxcztrRdVMK2/kz0edgL3F2fCUqPawo+pFpKU40JhJNk4sxeC9OXFEI
         IFWg==
X-Gm-Message-State: AA+aEWZ8UmtXjn9H2lKjU5uOj24I24xClFzOi47nWxrrDbnxXvS049TU
        GGPAAnZ2NUvZCuxGaslU32/srK4zE0q30Qe/3KG2BmHKXOQ=
X-Google-Smtp-Source: AFSGD/Wtc2OKazHM09jyXNtEtTYH3DvDBdZR/mFE6iId/J2ZCTBb074ahIonWxvqYxocrSI2FGVSUSw9ORVn0IlDoG8=
X-Received: by 2002:a25:8445:: with SMTP id r5-v6mr29538763ybm.182.1544118707521;
 Thu, 06 Dec 2018 09:51:47 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-EccPiKPR-ZB+V=tTyAB3Gru2n_Pt4PFxEQf_3y_4c8g+TLg@mail.gmail.com>
 <20181121165409.54278-1-mortonm@chromium.org> <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 6 Dec 2018 09:51:36 -0800
Message-ID: <CAJ-EccPf-u7PC2bzAzqFjz4-W5pFiLxSKcbKwkFYv8avfPdu3g@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     Kees Cook <keescook@chromium.org>
Cc:     jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 5, 2018 at 4:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 21, 2018 at 8:54 AM <mortonm@chromium.org> wrote:
> >
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
> > ---
> >
> > Sending a patch developed against the 'next-general' branch of the
> > linux-security tree, since the previous patch versions wouldn't apply
> > cleanly to 'next-general'.
>
> I'm finally getting back around to this. Sorry for the delay!
>
> A few general process notes:
> - Please "version" your patches in the Subject (e.g. "[PATCH v3] LSM:
> add SafeSetID ..."). This helps track discussion.
> - Please include a "changes since last version below the first "---"
> line, to summarize what has changed. This makes review faster for
> people that have read a specific version but need to catch up (like
> me) :)

Ok thanks, will do in the future. The only code change since the
initial upload was to add a do_exit(SIGKILL) line to
setuid_policy_warning() in lsm.c, which will kill any process that
violates the whitelist policy. This way, there can never be a case
where a privileged program fails to drop privilege because of our
whitelist and continues running in an accidentally over-privileged
context.

>
> > +/*
> > + * TODO: Figuring out whether the current syscall number (saved on the kernel
> > + * stack) is one of the set*uid syscalls is an operation that requires checking
> > + * the number against arch-specific constants as seen below. The need for this
> > + * LSM to know about arch-specific syscall stuff is not ideal. Is it better to
> > + * implement an arch-specific function that gets called from this file and
> > + * update arch/Kconfig to mention that the HAVE_SAFESETID symbol should only be
> > + * selected for architectures that implement the function? Any other ideas?
> > + */
>
> What would Stephen's solution for this problem end up looking like? I
> think avoiding the arch-specific-ness would be quite valuable.

I sent a patch here that is an example of how it could be done:
https://www.spinics.net/lists/linux-security-module/msg24504.html.
AFAICT I think this is what Stephen had in mind.

>
> I think adding a capability for this isn't the way to go (there is a
> very painful history on adding capabilities). This feels much more
> like a good mapping to an LSM (it's narrowing a privilege) with a very
> specific policy.
>
> --
> Kees Cook
