Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F169C0015E
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 09:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjHCJok (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbjHCJoU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 05:44:20 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4A2102
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 02:44:02 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RGkSb6d6XzMqBjq;
        Thu,  3 Aug 2023 09:43:59 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RGkSb2966zMppKM;
        Thu,  3 Aug 2023 11:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1691055839;
        bh=gAY8JjRykyGAscR4H5oyheHiJQRPMNPm7hKxT1Vk2AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ily5hJwG9mptaj1KW5su2MJCMG0dQRorfppv38ajWR5U9wIRpC12VJoNw9mk+IV+A
         Iiw9MV+c1wMbMLjK7B25Lkj3NCUfIbdaOH5CqnCIhI/qJRgINOvs4GAd8yMfXekSJq
         EhcuPu7r0cUKqHWOy6jgGLSRQ/KA8BsnMjQ+t0vo=
Date:   Thu, 3 Aug 2023 11:44:05 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Subject: Re: ANN: new LSM guidelines
Message-ID: <20230803.Ahk8eith7xei@digikod.net>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <20230802.doki9xoTh0ai@digikod.net>
 <CAHC9VhSb+=JF7GJ-98DX_3NO2eSLeurXO+w4xcgHuXFh6HqWVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSb+=JF7GJ-98DX_3NO2eSLeurXO+w4xcgHuXFh6HqWVw@mail.gmail.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 02, 2023 at 05:56:42PM -0400, Paul Moore wrote:
> On Wed, Aug 2, 2023 at 2:38 PM Mickaël Salaün <mic@digikod.net> wrote:

[...]

> > > * There must be at least one LSM implementation of the hook included in the
> > > submission to act as a reference for additional LSM implementations.  The
> > > reference implementation must be for one of the upstream, in-kernel LSMs; while
> > > the BPF LSM is an upstream LSM, it's nature precludes it from being eligible as
> > > one of the in-kernel LSMs.
> >
> > To avoid misunderstanding, I think it would be better and more generic
> > to focus on the out-of-tree nature of hook implementations.  We might
> > also want to give some pointers for the reason(s) why out-of-tree LSMs
> > use cases are not supported.
> 
> I'm open to new language here if you have some particular wording in mind?

What about this?

* Every hook must demonstrate its usefulness and be actually used by
  in-kernel code.  This is required to understand the purpose of the LSM
  hooks, their expected semantic, and to be able to guarantee security
  properties throughout kernel code changes (e.g., thanks to regression
  testing).  This means that out-of-tree kernel code and pass-through
  implementations (e.g., BPF LSM) are not eligible for such reference
  implementations.

[...]

> > > * The new LSM's author(s) must commit to maintain and support the new LSM for
> > > an extended period of time.  While the authors may be currently employed to
> > > develop and support the LSM, there is an expectation upstream that support will
> > > continue beyond the author's employment with the original company, or the
> > > company's backing of the LSM.
> > >
> > > * New LSMs must include documentation providing a clear explanation of the
> > > LSM's requirements, goals, and expected uses.  The documentation does not need
> > > to rise to the level of a formal security model, but it must be considered
> > > "reasonable" by the LSM community as a whole.
> >
> > I guess defining the threat model would be a good first step (and we
> > should probably add this kind of description for current LSMs as well).
> 
> I believe that should be captured in the "requirements, goals, and
> expected uses" portion of the requirement above, but if you believe it
> should be more explicit let me know.

I think explicitly using "threat model" in this paragraph would be a
good idea.

> 
> > > * Any user visible interfaces provided by the LSM must be well documented.  It
> > > is important to remember the user visible APIs are considered to be "forever
> > > APIs" by the Linux Kernel community; do not add an API that cannot be supported
> > > for the next 20+ years.
> >
> > I would also add tests! For new kernel developments, especially those
> > focused on security, the interfaces should be well tested, part of
> > kselftests, and run at least for each kernel release (if possible with
> > the KernelCI infrastructure).  A good test coverage should be a minimal
> > requirement, even if this is not enough.  Additionally, syzkaller should
> > be able to efficiently fuzz these interfaces, which may require some
> > tuning.
> 
> I added a test suite requirement to the latest revision.  I didn't
> explicitly require kselftests, as not all current LSMs with tests make
> use of kselftest, but I do think requiring some type of test suite is
> important.

Ok, see my comments in the updated doc.
