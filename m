Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A80C433DB
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Jan 2021 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34B323A9C
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Jan 2021 21:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbhAHVcZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbhAHVcX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Jan 2021 16:32:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C5C061574
        for <linux-security-module@vger.kernel.org>; Fri,  8 Jan 2021 13:31:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p22so12536608edu.11
        for <linux-security-module@vger.kernel.org>; Fri, 08 Jan 2021 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usABmZbPBqvxIY7U6EdGtDSIYnBKPUAxoopqfJsbtF4=;
        b=pBGi9wERfXy2hax+45WV3pYPQR65fOvZkuo+5mJBYJm6oCBXdlsNQ8MLB2BBZJghLV
         krg0LeT8dDbheD2uijN7Xt+GmkSuJtHYSwgxWq/ZMwJHgwuur7rw2L4h0Q84fHnxuYNJ
         BqLkmzGllNp9DvPfiijxoam7DIejfT06c3wqhBqPdvllpbzncL7z7xc3zfkeYvEFM0/y
         wLRqioz1SjBMUYCnZJZfs2GaQIr7j9B/ZvO5kT1xaSSlgo1x8DGIuqaPmbr921IxGow9
         VT3idPThY7BJWa/DhX2K/205uPggSR1O8exx7M439p7jP5pUTCEm50o6MJ2bZAPGa1i1
         9JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usABmZbPBqvxIY7U6EdGtDSIYnBKPUAxoopqfJsbtF4=;
        b=nogO5MffBfFzZHNYvFkBZn7f8cP9RX0QAgG5lf5SnaGbD86UBeN8vZG6+FuQ/liEMN
         uzFSZruos8Sv/S0E6wwOAKB0ohnw4FXfP8IRhDtpblm7Tow/riUR2zO7Qc4qT79avxRn
         FQ5s2UNYX7rLbc42NfG7QxSHUhMiQEjvy7x5xCtkplD0YuL5NXDuSG0WafH0WZSYcqG+
         43t0vr5lk6fgreOjC8wPGG6FiL/Ru9aKfGdiar9bG0SCEb9Xf1rKhi6SnfqmvISHnIOD
         uU9Xv06+IP9twoJp9tBdhDBWEzK91LM1IN1gm3aEBa8Ej/LgghOaRZhUKWUjdo5TE899
         JrFA==
X-Gm-Message-State: AOAM533BErX+GZ/m4qgF9hV6oJlLVtlfxa9OP5Bvz0PZSGlLgtMDbqT8
        WHxWpPozlCAZf0B68HajRPE4cPNjLIJp/QwCZXzTMg==
X-Google-Smtp-Source: ABdhPJw2qYeDr60GGb3HJnbXtjHALUnLnnC8WnJbfhBCDpJkWDyszY9IxAR+lhJgwDJyVCmFAUsAet6wSO0g94hykG0=
X-Received: by 2002:aa7:da03:: with SMTP id r3mr6546470eds.155.1610141501281;
 Fri, 08 Jan 2021 13:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
 <CA+EESO45ezOtg1-MHfwSk3YNYRS7cYnH+kMz-T_MdaSpyW=8Yw@mail.gmail.com> <CAEjxPJ7CL0WbEeooyh=d_LggZ7xTtcqsLY3TSunJ6oXWNxBOuw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7CL0WbEeooyh=d_LggZ7xTtcqsLY3TSunJ6oXWNxBOuw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 8 Jan 2021 13:31:30 -0800
Message-ID: <CA+EESO56RQdB3vV4_BKHT6rhGnbyT07HvrfPcR5s5OFMh1XURw@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 8, 2021 at 1:24 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jan 8, 2021 at 3:17 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > On Fri, Jan 8, 2021 at 11:35 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Jan 6, 2021 at 10:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > > From: Daniel Colascione <dancol@google.com>
> > > > >
> > > > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > > > the previous patches to give SELinux the ability to control
> > > > > anonymous-inode files that are created using the new
> > > > > anon_inode_getfd_secure() function.
> > > > >
> > > > > A SELinux policy author detects and controls these anonymous inodes by
> > > > > adding a name-based type_transition rule that assigns a new security
> > > > > type to anonymous-inode files created in some domain. The name used
> > > > > for the name-based transition is the name associated with the
> > > > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > > > "[perf_event]".
> > > > >
> > > > > Example:
> > > > >
> > > > > type uffd_t;
> > > > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > > > allow sysadm_t uffd_t:anon_inode { create };
> > > > >
> > > > > (The next patch in this series is necessary for making userfaultfd
> > > > > support this new interface.  The example above is just
> > > > > for exposition.)
> > > > >
> > > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > ---
> > > > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
> > > > >  security/selinux/include/classmap.h |  2 ++
> > > > >  2 files changed, 58 insertions(+)
> > > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 6b1826fc3658..d092aa512868 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > > > +                                           const struct qstr *name,
> > > > > +                                           const struct inode *context_inode)
> > > > > +{
> > > > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > > > +       struct common_audit_data ad;
> > > > > +       struct inode_security_struct *isec;
> > > > > +       int rc;
> > > > > +
> > > > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > > > +               return 0;
> > > > > +
> > > > > +       isec = selinux_inode(inode);
> > > > > +
> > > > > +       /*
> > > > > +        * We only get here once per ephemeral inode.  The inode has
> > > > > +        * been initialized via inode_alloc_security but is otherwise
> > > > > +        * untouched.
> > > > > +        */
> > > > > +
> > > > > +       if (context_inode) {
> > > > > +               struct inode_security_struct *context_isec =
> > > > > +                       selinux_inode(context_inode);
> > > > > +               if (context_isec->initialized != LABEL_INITIALIZED)
> > > > > +                       return -EACCES;
> > Stephen, as per your explanation below, is this check also
> > problematic? I mean is it possible that /dev/kvm context_inode may not
> > have its label initialized? If so, then v12 of the patch series can be
> > used as is. Otherwise, I will send the next version which rollbacks
> > v14 and v13, except for this check. Kindly confirm.
>
> The context_inode should always be initialized already.  I'm not fond
> though of silently returning -EACCES here.  At the least we should
> have a pr_err() or pr_warn() here.  In reality, this could only occur
> in the case of a kernel bug or memory corruption so it used to be a
> candidate for WARN_ON() or BUG_ON() or similar but I know that
> BUG_ON() at least is frowned upon these days.

Got it. I'll add a pr_err(). Thanks a lot.
