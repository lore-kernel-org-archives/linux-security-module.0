Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC79C04A94
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Aug 2023 21:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHBV46 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Aug 2023 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHBV45 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Aug 2023 17:56:57 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9971FEF
        for <linux-security-module@vger.kernel.org>; Wed,  2 Aug 2023 14:56:53 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-577ddda6ab1so5176927b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Aug 2023 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691013413; x=1691618213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ3cFlYzfPzpxitdt4L3MAqh/x5FFR/f0DZqj5hM4es=;
        b=ODLkKv/GswP2NFsV5MnCLs7k2LYM9lkfDPL0Gz7TcaY5o7+4Wap3e2cO8TBzjkdrnk
         BL+tCe0hS6/YbtWQXv8CJKCIi2qD0XFUNP//NgT4V02+n8cejxJaDRX/mvECLES5+drx
         XoxGbdPNc196xpxxbn1i7nb/+7Zgkyaw4AzomQxrgYi50DDYlvIzTOYy5sSAsjJri2+S
         9ASDRFdXDjCormPujqkiYuw0cGYp1Oqls9TnlNWYBesbQvVaoIBNPHlMx2Z7DswiEa2e
         KDRohIOt6iYDr2pxbVpKjS0gqbCs/s6BAq4rA8N3jmPHgFLZcR6qU8O+PJzlwQAZZfWY
         9FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691013413; x=1691618213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ3cFlYzfPzpxitdt4L3MAqh/x5FFR/f0DZqj5hM4es=;
        b=lZlhLiIffGYSgE+AK3vFyA2XoQgZCRTGHJ+iHaEp/tn7dhjJuTZbrVcqyHgDbOXS3L
         y48YEl0pMr5BUN6iF1OSjqw3naOaysqnYYTZjEqKHROE98e0u0xM2iz5WinDbrdhoQHJ
         wdu31q+KKvbZfE3K9HqD8rhg4ckpaLbRPQAgzOMKDq0acBzlaay5ogAbPlNjHNCTmGrv
         OCCjm1iJ2v5E5EwCsbLFcfqKKHb7+1gP3BkwnVCLedBN4Yb20SpQus/v0FBMdLEuMpNz
         5zRKgoF5H9cXTBgvArRe2BQoOSC01raFLkuUPOgNNEIGkH2UzinaCsgYvUUtf3D5SB+s
         UloQ==
X-Gm-Message-State: ABy/qLZJNat7jfNHym1UVbcEZRA2vWCCY0OYR+dk+KlWnN5FZqzSIFVg
        B6LkOvRdplFlv6q4iIP887clQZ+JLbIY2A3oa5GH
X-Google-Smtp-Source: APBJJlGjnIPVEtgnUppVrCSOTp2uyr8LFXE0TFH2PbGM6TnvZnlS+p+cgZEePPwSp6Fy/78eULawbLo2wVq6b2L1MnQ=
X-Received: by 2002:a0d:e205:0:b0:586:5e77:a3c with SMTP id
 l5-20020a0de205000000b005865e770a3cmr6788213ywe.15.1691013413005; Wed, 02 Aug
 2023 14:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com> <20230802.doki9xoTh0ai@digikod.net>
In-Reply-To: <20230802.doki9xoTh0ai@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Aug 2023 17:56:42 -0400
Message-ID: <CAHC9VhSb+=JF7GJ-98DX_3NO2eSLeurXO+w4xcgHuXFh6HqWVw@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 2, 2023 at 2:38=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> I like this guideline. I guess this is your goal and I think it should
> be part of Documentation/security/lsm.rst (and move the introduction
> part of lsm-development.rst into lsm.rst) and get a few SoB.

Thanks for the review and comments.  Responses below, but I'll post an
updated guidance doc in just a bit incorporating your feedback as well
as those of a few others who sent me comments off-list.

As far as moving this guidance into Documentation/security, yes, that
is the ultimate goal.  In fact I have a todo item to go through all of
Documentation/security and give it a good cleaning/review/edit,
although please don't expect that anytime soon :/

> On Tue, Aug 01, 2023 at 06:47:12PM -0400, Paul Moore wrote:
> > On Fri, Jul 7, 2023 at 6:02=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Thu, Jul 6, 2023 at 8:32=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> > > > On 7/6/2023 1:42 PM, Paul Moore wrote:
> > > > > Hello all,
> > > > >
> > > > > With some renewed interest in submitting new LSMs including in th=
e
> > > > > upstream Linux Kernel I thought it might be a good idea to docume=
nt
> > > > > some of our longstanding guidelines around submitting new LSMs.  =
I'm
> > > > > posting this mostly as a FYI for those who are working on new LSM
> > > > > submissions, but also to solicit feedback from everyone on the li=
st
> > > > > regarding what we should ask of new LSMs.  If you think I'm missi=
ng
> > > > > something important, or believe I've added an unfair requirement,
> > > > > please let me know.
> > > > >
> > > > > I've added the guidelines to the README.md at the top of the LSM =
tree,
> > > > > but to make life easier for those reviewing the guidelines I'm
> > > > > copy-n-pasting them below ...
> >
> > I've updated the README.md doc based on the feedback, and copied the
> > two new sections below for easier review.  If anyone has any
> > additional feedback or concerns, please let me know.
> >
> > ## New LSM Hook Guidelines
> >
> > While LSM hooks are generally considered outside of the Linux Kernel's =
stable
>
> Why "generally"?

Good point, I'll remove that.

> > API promise, due to the nature of the LSM hooks we try to minimize chan=
ges to
> > the hooks.  With that in mind, we have the following requirements for n=
ew LSM
> > hooks:
> >
> > * Hooks should be designed to be LSM agnostic.  While it is possible th=
at only
> > one LSM might implement the hook at the time of submission, the hook's =
behavior
> > should be generic enough that other LSMs could provide a meaningful
> > implementation.
>
> We should also avoid falling in the other extreme which is to add
> different argument just-in-case. For instance, there is no need to add a
> "flags" argument to a kernel API if there is no flag for now, especially
> if there are only a few users of this hook.
>
> I would say that we want generic-as-possible hooks (e.g. well
> positioned) but not with useless arguments.

Agreed, although I think that's hard to properly describe that in a
sentence or two.  It's going to be impossible to capture every
requirement in this doc (I added a new paragraph explaining this in
the latest revision), so I think we can just leave this as-is for now.

If it does become a problem we can work a bit harder on describing
what makes a "good" LSM hook.

> > * There must be at least one LSM implementation of the hook included in=
 the
> > submission to act as a reference for additional LSM implementations.  T=
he
> > reference implementation must be for one of the upstream, in-kernel LSM=
s; while
> > the BPF LSM is an upstream LSM, it's nature precludes it from being eli=
gible as
> > one of the in-kernel LSMs.
>
> To avoid misunderstanding, I think it would be better and more generic
> to focus on the out-of-tree nature of hook implementations.  We might
> also want to give some pointers for the reason(s) why out-of-tree LSMs
> use cases are not supported.

I'm open to new language here if you have some particular wording in mind?

> > ## New LSM Guidelines
> >
> > Historically we have had few requirements around new LSM additions, wit=
h
> > Arjan van de Ven being the first to describe a basic protocol for accep=
ting new
> > LSMs into the Linux Kernel.  In an attempt to document Arjan's basic id=
eas and
> > update them for modern Linux Kernel development, here are a list of
> > requirements for new LSM submissions:
>
> If we go for a kernel documentation patch, it might be better to put
> most of this historic paragraph into the patch description.

Agree.

I was looking for the original comments from Arjan but couldn't find
them in an archive anywhere, if anyone has a pointer it would be great
to share that.

> > * The new LSM's author(s) must commit to maintain and support the new L=
SM for
> > an extended period of time.  While the authors may be currently employe=
d to
> > develop and support the LSM, there is an expectation upstream that supp=
ort will
> > continue beyond the author's employment with the original company, or t=
he
> > company's backing of the LSM.
> >
> > * New LSMs must include documentation providing a clear explanation of =
the
> > LSM's requirements, goals, and expected uses.  The documentation does n=
ot need
> > to rise to the level of a formal security model, but it must be conside=
red
> > "reasonable" by the LSM community as a whole.
>
> I guess defining the threat model would be a good first step (and we
> should probably add this kind of description for current LSMs as well).

I believe that should be captured in the "requirements, goals, and
expected uses" portion of the requirement above, but if you believe it
should be more explicit let me know.

> > * Any user visible interfaces provided by the LSM must be well document=
ed.  It
> > is important to remember the user visible APIs are considered to be "fo=
rever
> > APIs" by the Linux Kernel community; do not add an API that cannot be s=
upported
> > for the next 20+ years.
>
> I would also add tests! For new kernel developments, especially those
> focused on security, the interfaces should be well tested, part of
> kselftests, and run at least for each kernel release (if possible with
> the KernelCI infrastructure).  A good test coverage should be a minimal
> requirement, even if this is not enough.  Additionally, syzkaller should
> be able to efficiently fuzz these interfaces, which may require some
> tuning.

I added a test suite requirement to the latest revision.  I didn't
explicitly require kselftests, as not all current LSMs with tests make
use of kselftest, but I do think requiring some type of test suite is
important.

> Extending the kernel documentation should not stop developers to write
> man pages as well. ;)

Of course not!  While I'm a big believer in manpages, I don't believe
that we need to make that an explicit requirement.  However, I would
expect that the documentation we do require would make it easier to
produce useful manpages.

> It might also be useful to add some standalone tools in samples/

Or in a separate standalone public repo if the tools are significantly
large (see the requirement below).

> > * The LSM implementation must follow general Linux Kernel coding practi=
ces,
> > faithfully implement the security model and APIs described in the
> > documentation, and be free of any known defects at the time of submissi=
on.
> >
> > * Any userspace tools or patches created in support of the LSM must be =
publicly
> > available, with a public git repository preferable over a tarball snaps=
hot.

--=20
paul-moore.com
