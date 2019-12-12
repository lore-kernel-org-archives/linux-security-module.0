Return-Path: <SRS0=NGWT=2C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33A3C2D0C9
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Dec 2019 11:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EB3214D8
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Dec 2019 11:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1SoODv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfLLLt3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:49:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728857AbfLLLt3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Dec 2019 06:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576151368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kb7i1aL0zIm8YIDIXIQfYOsNMpPaCRRHj3zGFxSv61U=;
        b=S1SoODv4m1l4IPevVA6zkN34GjnUYbgRQqASrrdXlSOyUnodqaA42ne04WC//NpMIMYc7P
        GCOnXJL+MvWdB9Kt0LzGd29ztT1VX6s1QixBzQjiIrzA2s6r4auJm70/I+Sjl3gyxRkHWV
        4yaLBXivVb7Yg9PsnpUnuJMed2vxQ8o=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-pShSx-hIPO2DmjKKBt93eA-1; Thu, 12 Dec 2019 06:49:27 -0500
Received: by mail-yb1-f197.google.com with SMTP id f186so672849ybf.22
        for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2019 03:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K21sOXzObIZUxD6x2rCJckAm7F80pnK0o4cxGEU+PhA=;
        b=W+SQXwJ2mE8BFR3MyuutKb0dngyWuQVmRIuthv5/H3ULrTEpqBhYuhlv8uyOKUc3/Z
         m2r0jVnZlNS2Ez+mBuhimRto2yz18QtMbOKWAMw34JdoZbRaE+OLgzE1laoHr/37mrk8
         jj72r0NKxYtECrAF+i2BPQcdQbt2SI2UIbDFR+FPpIVzHyk7UCYVZwPBMzeKeUAfWfT+
         nldTUOHrfVeFYZaekdrOsNqWc4GxydDh+Wi3TcI85C1SymnT23/V4+M7hYQ3hgpixJxM
         Ax00abpmQoKYI8F+gbpvWit1uau/wHEOHEaddviouWTNXuYrNmH8giO8a/xgXHYxALgU
         hmtA==
X-Gm-Message-State: APjAAAW60y8LAwLDL/6ieqgIomO2SMOvspy+Fc3jHDaEspt6sgquTPvK
        GkwwF8tDGKJBCy39XlKsnApIHJvr4H4j7PFTCgzr1gcAMuFNyhVVsiCuvmwr33boOFhTOFBOS5l
        f7AqEXgQDpgvBkzwZaUr3I/BXJ3caKW2vMOpPh/7beACcWcygiYCx
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr7226606oth.43.1576151366074;
        Thu, 12 Dec 2019 03:49:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFcdZMnyUloKeRUcjVCVgKi4HDOGdsndLJPySjJPNIOYtmTSt2JqeUHyqYtA+LqPw3h/QPRKep1dY4gXTOKBY=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr7226581oth.43.1576151365791;
 Thu, 12 Dec 2019 03:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov>
In-Reply-To: <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Dec 2019 12:49:14 +0100
Message-ID: <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-MC-Unique: pShSx-hIPO2DmjKKBt93eA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> > On 12/11/2019 8:42 AM, Kees Cook wrote:
> >> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> >>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> >>>> Instead of deleting the hooks from each list one-by-one (which creat=
es
> >>>> some bad race conditions), allow an LSM to provide a reference to it=
s
> >>>> "enabled" variable and check this variable before calling the hook.
> >>>>
> >>>> As a nice side effect, this allows marking the hooks (and other stuf=
f)
> >>>> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no lo=
nger
> >>>> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE dire=
ctly
> >>>> for turning on the runtime disable functionality, to emphasize that =
this
> >>>> is only used by SELinux and is meant to be removed in the future.
> >>> Is this fundamentally different/better than adding if (!selinux_enabl=
ed)
> >>> return 0; to the beginning of every SELinux hook function?  And as I =
noted
> >>> to Casey in the earlier thread, that provides an additional easy targ=
et to
> >>> kernel exploit writers for neutering SELinux with a single kernel wri=
te
> >>> vulnerability. OTOH, they already have selinux_state.enforcing and fr=
iends,
> >>> and this new one would only be if SECURITY_SELINUX_DISABLE=3Dy.
> >> Yeah, I agree here -- we specifically do not want there to be a trivia=
l
> >> way to disable LSMs at runtime. CONFIG_SECURITY_SELINUX_DISABLE should
> >> be considered deprecated IMO, and we don't want to widen its features.
> >
> > In /etc/selinux/config SELINUX=3Ddisabled is documented as "No SELinux
> > policy is loaded". How about if instead of blocking policy load and
> > removing the hooks it just blocked policy load? It may be appropriate
> > to tweak the code a bit to perform better in the no-policy loaded
> > case, but my understanding is that the system should work. That would
> > address backward compatibility concerns and allow removal of
> > security_delete_hooks(). I don't think this would have the same
> > exposure of resetting selinux_enabled.
>
> I think that comment stems from before runtime disable was first
> implemented in the kernel, when the only option was to leave SELinux
> enabled with no policy loaded.  Fedora didn't consider that (or
> selinux=3D0) to be acceptable alternatives, which is why we have runtime
> disable today.

Do you happen to remember the reasons why it wasn't acceptable? We are
ready to start pushing for disabling SECURITY_SELINUX_DISABLE in
Fedora, but we're not sure why it is so crucial. Knowing what we need
to address before disabling/removing it would help a lot.

> selinux_state.initialized reflects whether a policy has
> been loaded.  With a few exceptions in certain hook functions, it is
> only checked by the security server service functions
> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> there is a lot of SELinux processing that would still occur in that
> situation unless we added if (!selinux_state.initialized) return 0;
> checks to all the hook functions, which would create the same exposure
> and would further break the SELinux-enabled case (we need to perform
> some SELinux processing pre-policy-load to allocate blobs and track what
> tasks and objects require delayed security initialization when policy
> load finally occurs).

I think what Casey was suggesting is to add another flag that would
switch from "no policy loaded, but we expect it to be loaded
eventually" to "no policy loaded and we don't expect/allow it to be
loaded any more", which is essentially equivalent to checking
selinux_enabled in each hook, which you had already brought up.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

