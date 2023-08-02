Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745BFC001E0
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Aug 2023 18:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjHBSiU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Aug 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHBSiT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Aug 2023 14:38:19 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690219A4
        for <linux-security-module@vger.kernel.org>; Wed,  2 Aug 2023 11:38:15 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RGLMT35tzzMqLQW;
        Wed,  2 Aug 2023 18:38:13 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RGLMS5jV7zMpnPs;
        Wed,  2 Aug 2023 20:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1691001493;
        bh=7h66j7qSs0ZWmThLYGpifx/WCHcMwwS74hKGCwBdwLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBHCJvSKJSBU3nc7LyYQTVvS+w0Ak8t3rx+wnFM512HXiTwkkaKZMhyECFuFZoNI0
         58hch7zLplqiHimVr+KA97Tx0C55hxE0mci6iUeCeIExR5Jg0LzLGZsipWC+IXctKU
         /8UM72PSLSHoqEstNmg3XdRPhbZZ2MPzz5LDV9Lc=
Date:   Wed, 2 Aug 2023 20:38:21 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Subject: Re: ANN: new LSM guidelines
Message-ID: <20230802.doki9xoTh0ai@digikod.net>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I like this guideline. I guess this is your goal and I think it should
be part of Documentation/security/lsm.rst (and move the introduction
part of lsm-development.rst into lsm.rst) and get a few SoB.

On Tue, Aug 01, 2023 at 06:47:12PM -0400, Paul Moore wrote:
> On Fri, Jul 7, 2023 at 6:02 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Jul 6, 2023 at 8:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 7/6/2023 1:42 PM, Paul Moore wrote:
> > > > Hello all,
> > > >
> > > > With some renewed interest in submitting new LSMs including in the
> > > > upstream Linux Kernel I thought it might be a good idea to document
> > > > some of our longstanding guidelines around submitting new LSMs.  I'm
> > > > posting this mostly as a FYI for those who are working on new LSM
> > > > submissions, but also to solicit feedback from everyone on the list
> > > > regarding what we should ask of new LSMs.  If you think I'm missing
> > > > something important, or believe I've added an unfair requirement,
> > > > please let me know.
> > > >
> > > > I've added the guidelines to the README.md at the top of the LSM tree,
> > > > but to make life easier for those reviewing the guidelines I'm
> > > > copy-n-pasting them below ...
> 
> I've updated the README.md doc based on the feedback, and copied the
> two new sections below for easier review.  If anyone has any
> additional feedback or concerns, please let me know.
> 
> ## New LSM Hook Guidelines
> 
> While LSM hooks are generally considered outside of the Linux Kernel's stable

Why "generally"?

> API promise, due to the nature of the LSM hooks we try to minimize changes to
> the hooks.  With that in mind, we have the following requirements for new LSM
> hooks:
> 
> * Hooks should be designed to be LSM agnostic.  While it is possible that only
> one LSM might implement the hook at the time of submission, the hook's behavior
> should be generic enough that other LSMs could provide a meaningful
> implementation.

We should also avoid falling in the other extreme which is to add
different argument just-in-case. For instance, there is no need to add a
"flags" argument to a kernel API if there is no flag for now, especially
if there are only a few users of this hook.

I would say that we want generic-as-possible hooks (e.g. well
positioned) but not with useless arguments.

> 
> * The hook must be documented with a function header block that conforms to
> the kernel documentation style.  At a minimum the documentation should explain
> the parameters, return values, a brief overall description, any special
> considerations for the callers, and any special considerations for the LSM
> implementations.
> 
> * There must be at least one LSM implementation of the hook included in the
> submission to act as a reference for additional LSM implementations.  The
> reference implementation must be for one of the upstream, in-kernel LSMs; while
> the BPF LSM is an upstream LSM, it's nature precludes it from being eligible as
> one of the in-kernel LSMs.

To avoid misunderstanding, I think it would be better and more generic
to focus on the out-of-tree nature of hook implementations.  We might
also want to give some pointers for the reason(s) why out-of-tree LSMs
use cases are not supported.

> 
> ## New LSM Guidelines
> 
> Historically we have had few requirements around new LSM additions, with
> Arjan van de Ven being the first to describe a basic protocol for accepting new
> LSMs into the Linux Kernel.  In an attempt to document Arjan's basic ideas and
> update them for modern Linux Kernel development, here are a list of
> requirements for new LSM submissions:

If we go for a kernel documentation patch, it might be better to put
most of this historic paragraph into the patch description.

> 
> * The new LSM's author(s) must commit to maintain and support the new LSM for
> an extended period of time.  While the authors may be currently employed to
> develop and support the LSM, there is an expectation upstream that support will
> continue beyond the author's employment with the original company, or the
> company's backing of the LSM.
> 
> * New LSMs must include documentation providing a clear explanation of the
> LSM's requirements, goals, and expected uses.  The documentation does not need
> to rise to the level of a formal security model, but it must be considered
> "reasonable" by the LSM community as a whole.

I guess defining the threat model would be a good first step (and we
should probably add this kind of description for current LSMs as well).

> 
> * Any user visible interfaces provided by the LSM must be well documented.  It
> is important to remember the user visible APIs are considered to be "forever
> APIs" by the Linux Kernel community; do not add an API that cannot be supported
> for the next 20+ years.

I would also add tests! For new kernel developments, especially those
focused on security, the interfaces should be well tested, part of
kselftests, and run at least for each kernel release (if possible with
the KernelCI infrastructure).  A good test coverage should be a minimal
requirement, even if this is not enough.  Additionally, syzkaller should
be able to efficiently fuzz these interfaces, which may require some
tuning.

Extending the kernel documentation should not stop developers to write
man pages as well. ;)

It might also be useful to add some standalone tools in samples/

> 
> * The LSM implementation must follow general Linux Kernel coding practices,
> faithfully implement the security model and APIs described in the
> documentation, and be free of any known defects at the time of submission.
> 
> * Any userspace tools or patches created in support of the LSM must be publicly
> available, with a public git repository preferable over a tarball snapshot.

> 
> -- 
> paul-moore.com
