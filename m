Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C6CCA47B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jun 2022 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbiFMTrG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiFMTqv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jun 2022 15:46:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638575535A
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 11:17:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cx11so6364835pjb.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=THDzxPXwnrXgbH5TVo5+XbAuUhPSiF5R1K9yx5fzgl4=;
        b=I9R3QCS8x2h9rOtgVNPZ+kQdPg0f1EhqgoMkf4TTQQXrzl/+IrBZA+lY4Wj9oyvAsO
         3G7QqjbjT9sZWOuyhBAQ8XiYweHVz3mMo7ntib1AkO0DABvSHHMbP7GIQosE3IXbSLoH
         IMSdXELOOafuDokRP60++MMSuMhPbciV2uTumfENBfPvCLKuWFyO+yabUB0Qz9l0R+Bh
         FtmUid8oGTVMZVzxe3wzlWfcXqrRKp46yFaXq5vlpoDhxCC+AJqft5hi91L5eCGptyqm
         LWRMAsniyXmkW709BmrIwNv08RcRcUzjFn0UtdHGPu49vqEiweDeTnnWReDEmwxOGAqy
         ez2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=THDzxPXwnrXgbH5TVo5+XbAuUhPSiF5R1K9yx5fzgl4=;
        b=2AuaPaWyS51+e92JXsHHNFiPfHZX2igU1kqrrYRpCqee7lgNtjA0g7EV6HOCw3x78G
         R2OAT8BfFXHtVoAAnACmZtkfiiZEunpy1M5smJfpoOJulOkG531GbqUAzNnkjcDJIF/P
         Gvk8gK0rKG0GZU1L1nR4jogJQYtemiAr/BycvoqCQE8uBbqNkHL7FcSyBZY96tXFZej7
         K/FN3dOMkjPvWlu+UR5SzLxDKomcfXfbgptDhcPGrpciT+7aFzoJhdflzm5kUv8L6TF2
         B9uz0aQwsXW4/8NkHnkchEYxdpxIrQfSsN+yP15lpn9G9Dzf+jq2O7EZ7VsE9U94Ytob
         yJaA==
X-Gm-Message-State: AJIora+GsTneA1PUuIMi6x5qw7Kl9aXPbpHxkJDyvybzin2RWfoBbLIP
        ao4OBPZx2IzKtw5Jd9NlEqUqWKnzHuLJ1UNIBeslJqXKfgWP
X-Google-Smtp-Source: ABdhPJxr+HkD+ptO5rppukZz7x6VARn4tsHmirXuW0Vt35nic5PNRbZOk9JJnwL2Pb76zYiZ3aCUbShyIS74UydsHIk=
X-Received: by 2002:a17:902:ef43:b0:168:dbf0:bc47 with SMTP id
 e3-20020a170902ef4300b00168dbf0bc47mr587340plx.6.1655144273994; Mon, 13 Jun
 2022 11:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com>
 <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
 <CAJ2a_DeAUcGTGm_fk8viVbeFXr6FLrJ-oLw-abwFND6Kv0u0gQ@mail.gmail.com>
 <CAHC9VhRRBrLVtvmbJSTZ7fOkD-8AN4iM0WRmeL4ND001d3viJg@mail.gmail.com>
 <CAJ2a_DeT6AG0jp4gTdsEy7nh=s6cLR7QCsYXAz2+3vsdRKxddg@mail.gmail.com> <CAHC9VhQXdNieG8_uWBfCCFSow6AVaxNBhB3GNU8ea1j5rjgZiA@mail.gmail.com>
In-Reply-To: <CAHC9VhQXdNieG8_uWBfCCFSow6AVaxNBhB3GNU8ea1j5rjgZiA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 14:17:43 -0400
Message-ID: <CAHC9VhT+FptRYzr9KGny_2wUUh2=ZZYSx0TP_uYEHW0zZsSxMQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 7, 2022 at 4:10 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, May 2, 2022 at 9:45 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > On Thu, 17 Feb 2022 at 23:32, Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Feb 17, 2022 at 9:24 AM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > > On Thu, 27 Jan 2022 at 00:01, Paul Moore <paul@paul-moore.com> wrot=
e:
> > > > > On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
> > > > > <cgzones@googlemail.com> wrote:
> > > > > >
> > > > > > Create a security context for the inodes created by memfd_secre=
t(2) via
> > > > > > the LSM hook inode_init_security_anon to allow a fine grained c=
ontrol.
> > > > > > As secret memory areas can affect hibernation and have a global=
 shared
> > > > > > limit access control might be desirable.
> > > > > >
> > > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > > > ---
> > > > > > An alternative way of checking memfd_secret(2) is to create a n=
ew LSM
> > > > > > hook and e.g. for SELinux check via a new process class permiss=
ion.
> > > > > > ---
> > > > > >  mm/secretmem.c | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > This seems reasonable to me, and I like the idea of labeling the =
anon
> > > > > inode as opposed to creating a new set of LSM hooks.  If we want =
to
> > > > > apply access control policy to the memfd_secret() fds we are goin=
g to
> > > > > need to attach some sort of LSM state to the inode, we might as w=
ell
> > > > > use the mechanism we already have instead of inventing another on=
e.
> > > >
> > > > Any further comments (on design or implementation)?
> > > >
> > > > Should I resend a non-rfc?
> > >
> > > I personally would really like to see a selinux-testsuite for this so
> > > that we can verify it works not just now but in the future too.  I
> > > think having a test would also help demonstrate the usefulness of the
> > > additional LSM controls.
> > >
> >
> > Any comments (especially from the mm people)?
> >
> > Draft SELinux testsuite patch:
> > https://github.com/SELinuxProject/selinux-testsuite/pull/80
> >
> > > > One naming question:
> > > > Should the anonymous inode class be named "[secretmem]", like
> > > > "[userfaultfd]", or "[secret_mem]" similar to "[io_uring]"?
> > >
> > > The pr_fmt() string in mm/secretmem.c uses "secretmem" so I would
> > > suggest sticking with "[secretmem]", although that is question best
> > > answered by the secretmem maintainer.
>
> I think this patchset has been posted for long enough with no
> comments, and no objections, that I can pull this into the
> selinux/next tree.  However, I'll give it until the end of this week
> just to give folks one last chance to comment.  If I don't hear any
> objections by the end of day on Friday, June 10th I'll go ahead and
> merge this.

I didn't see any comments so I just merged this into selinux/next.
Thanks for your patience Christian.

--=20
paul-moore.com
