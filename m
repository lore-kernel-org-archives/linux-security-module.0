Return-Path: <SRS0=NGWT=2C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0BC43603
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Dec 2019 11:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885CF214D8
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Dec 2019 11:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhCC4Om+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfLLL6w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:58:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44097 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726492AbfLLL6v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Dec 2019 06:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576151930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKGQUfPi5sSR9IuAbgqQviSQ6E3KYoFvxuVP3NHabHc=;
        b=QhCC4Om+aCBz8ETzJ0ED6nKmGnGOPODaiPstAPWm/2X/rjYALepddBtrnipFUzx8+o6uYZ
        st40Qky3K88LPdiedmbbXIq7dn4K0U6Lk0GTMocrGzLkreGZ4k5nahLrjPrPFxkvjGXmD3
        ckaiCiA1KLRtEyZ8XrJ5t318IKbZbPg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-yCrualPiMVWPP1zvWeOepA-1; Thu, 12 Dec 2019 06:58:47 -0500
Received: by mail-ot1-f72.google.com with SMTP id g16so507153otj.2
        for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2019 03:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7EvzM0ZyW5XOMVqHzxy8DvyApZ+ekVKoPTyD4sIvh0=;
        b=dcujOE0VW5ZhC2H/W/E1us5pkcLFuPzARh37Y9DD4JHoTrGxC4KF1HpxwgZ2aYPd1t
         itTEwzCvN97bpGQ+nvCBdMwekj/5hbeFd1sY3gL9p+2scxR3vMEdSTQx9O3lfOy0B54S
         XY55zQufZhxVQC6ejsiku8Omeh/QGrzwRxOj23Cz/7+dQ3gzmMs9A4aLDkqQbYmTRhU9
         KNGOycisyfbdi9FhORhiAgBw+VyYarW/NxR3qXXv5yGaag8C0X+M0xKjVH4U/Cp6HF4G
         hPy85BwM1oXjaG1Inst1R+CmMpmVGvkUbtTjx5sFBUyyAUPvwz+v83+LdqDvstVlPvKg
         vcaA==
X-Gm-Message-State: APjAAAWOzt7hvxVYjWAyjoN4cQIH+V+HG5pcWp9jmbncld57Uiy51evx
        z+yMEipFUKrKLx3zb13HZl13gDckCCt2kk5Ssma741E6fWmrsswoP6gHVn7rLFxJnX8KWcrjPqi
        dCDEuQKR8O35wyjKsfD8AO92q1tP5a6nbD9gC6H74anAyJEAQrFLR
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr7263677oth.43.1576151926461;
        Thu, 12 Dec 2019 03:58:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyu30wCGWZ0qZ3y8KUkkXZoh07qSw2N5fNN0vr1B1IDlwq4tXST1J2NLGX1AfesTDmYhQyi6SK4+qcizFElLgo=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr7263649oth.43.1576151926192;
 Thu, 12 Dec 2019 03:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <66706222-b6af-5099-e485-b99391ad70b3@i-love.sakura.ne.jp>
In-Reply-To: <66706222-b6af-5099-e485-b99391ad70b3@i-love.sakura.ne.jp>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Dec 2019 12:58:35 +0100
Message-ID: <CAFqZXNv=AnPxHuQCusoJQGEJ8Q+yF7_TPBCRyAcE5OPzoYFc9w@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>
X-MC-Unique: yCrualPiMVWPP1zvWeOepA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 12, 2019 at 11:31 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2019/12/11 23:08, Ondrej Mosnacek wrote:
> > As a nice side effect, this allows marking the hooks (and other stuff)
> > __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longe=
r
> > makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directl=
y
> > for turning on the runtime disable functionality, to emphasize that thi=
s
> > is only used by SELinux and is meant to be removed in the future.
>
> I don't like unconditionally marking __ro_after_init. I'm currently waiti=
ng for
> Casey's stacking work to complete. I haven't given up dynamically loadabl=
e LSM modules.
>
> In order to allow loading LSM modules after boot, I have to add lines
> 1093-1173, 1190-1195, 1208-1211, 1217-1220 in
> https://osdn.net/projects/akari/scm/svn/blobs/head/trunk/akari/lsm-4.12.c=
 .
> I suggest grouping __lsm_ro_after_init variables into a special section a=
nd
> implementing a legal method for temporarily making that section read-writ=
e.
> Then, architectures with that method will be able to use __ro_after_init =
marking.

I'd say the burden of implementing this would lie on the arms of
whoever prepares the patches for dynamic load/unload. However, *if*
this patch is going to go anywhere, I could at least keep
__lsm_ro_after_init (now as just an alias for __ro_after_init) so its
definition can be easily changed later.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

