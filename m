Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31300C43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B9E20656
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BHD0ef7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfAOTxQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:53:16 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36197 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbfAOTxQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 14:53:16 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so2432145vsc.3
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 11:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owdvvF72YCKJl9fy1n4MyIvVXtc4orQsDW63SKN0R5g=;
        b=BHD0ef7DhtO0Y/li0Q99uv1qG+CIkT0b1ojBYb0zlzypWA6E04aZdL2tzZ2qeAp+jT
         wIZqp3z239YndDGgURUgj2KePERYWhQ4YTuwaESYtyINdivRFIZJ7Z7WRu/DreyhZtf5
         XYF4JfSL0Tc2BDIes2HkwqH4CYxOHkVyslJs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owdvvF72YCKJl9fy1n4MyIvVXtc4orQsDW63SKN0R5g=;
        b=CdgNYJFEQOxxQmbuGe+TvniPehJpJkkIDtrzN2KUldHSSuNn54ZWp1VD54D5maOHnX
         50JCHwEUW1y8gbsd9BmbPfz+9VVTladBlS18QWidclzXbndvhW3xLzOXfYFNKgtxMcSr
         yJ3rY3BWR52M/1uAN5p4nW0kWGhvH7uCZy//4DY/MbvH06OQFd+t0dOYWGS6G7SN1Jmx
         HwzYlENvS9sg6CqnxnYOINxQWD8rBYwD3lC6Zm7UYEV9naxEAxz2q1ayLWAN8yWE28oB
         B8d/Dluxuw0w4sSK0fzK17AKFizNrTohreEXwkaUm/tUDq7uPYro0o5CglixhY2inhe3
         Vh0w==
X-Gm-Message-State: AJcUukd2mkfVo61Nza6iFad7kws+VJp1nYPcXR3D75hIVBJ1KVZUjoJK
        EP+1SKwhHea6aNqzGizcd/T01FwNIE0=
X-Google-Smtp-Source: ALg8bN46rgOoOpzbmncnCYb/Rlwu6TT1hNRC+cOcxivBbur1br+6BJOZD6Opy0euhQPpeByC1Uz2+g==
X-Received: by 2002:a67:2d0b:: with SMTP id t11mr2223988vst.211.1547581994403;
        Tue, 15 Jan 2019 11:53:14 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id e34sm1170739uah.7.2019.01.15.11.53.12
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 11:53:13 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id h78so2411247vsi.6
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 11:53:12 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr2362016vsl.66.1547581992467;
 Tue, 15 Jan 2019 11:53:12 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com>
 <20190111171302.26152-1-mortonm@chromium.org> <CAGXu5jKiFDD25TUnt7s_zFv7sjrt8avjeZgBKUBVzQ-er+xdkg@mail.gmail.com>
 <CAJ-EccOoR4+WsjHC=ZGE8NgLiwGC0jO89ETx_wtB4QW9dE-tRQ@mail.gmail.com>
In-Reply-To: <CAJ-EccOoR4+WsjHC=ZGE8NgLiwGC0jO89ETx_wtB4QW9dE-tRQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 15 Jan 2019 11:53:00 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKzp0jKKJ7aa7hcEUZHhP5s5Eev0prBP3EDuHKahV15hA@mail.gmail.com>
Message-ID: <CAGXu5jKzp0jKKJ7aa7hcEUZHhP5s5Eev0prBP3EDuHKahV15hA@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: add SafeSetID module that gates setid calls
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

On Tue, Jan 15, 2019 at 11:49 AM Micah Morton <mortonm@chromium.org> wrote:
> On Mon, Jan 14, 2019 at 4:38 PM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Jan 11, 2019 at 9:13 AM <mortonm@chromium.org> wrote:
> > > From: Micah Morton <mortonm@chromium.org>
> > > +static void setuid_policy_violation(kuid_t parent, kuid_t child)
> > > +{
> > > +       pr_warn("UID transition (%d -> %d) blocked",
> > > +               __kuid_val(parent),
> > > +               __kuid_val(child));
> > > +        /*
> > > +         * Kill this process to avoid potential security vulnerabilities
> > > +         * that could arise from a missing whitelist entry preventing a
> > > +         * privileged process from dropping to a lesser-privileged one.
> > > +         */
> > > +        do_exit(SIGKILL);
> >
> > I think I asked earlier if this should be an unblockable signal raise
> > instead of a do_exit(). I don't remember if that got answered?
>
> Could you elaborate on this a bit, or share a pointer to some code/doc
> that explains the difference? I don't recall this point being raised
> before (might have missed it), and I'm no expert on the different
> approaches to killing a process in this way.

Sure! So, do_exit() is a big hammer, and skips a lot of clean-up-like
things (for example, this will skip core dumping, if it was desired by
the process, etc). It certainly has its place (and this may be it),
but I think it would be more sensible to use:

force_sig(SIGKILL, current);

and then the regular processing continues after this, and the kernel
will check for pending signals before returning to userspace. Though
please check this with strace to make sure the bad setuid() call never
returns... if it does, then I've got this wrong and do_exit() really
is appropriate here.

-- 
Kees Cook
