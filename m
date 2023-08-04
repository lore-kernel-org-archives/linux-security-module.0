Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68579C001DE
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Aug 2023 07:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjHDH6b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Aug 2023 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjHDH6Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Aug 2023 03:58:24 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F143422B
        for <linux-security-module@vger.kernel.org>; Fri,  4 Aug 2023 00:58:16 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RHJ463lmszMqFvQ;
        Fri,  4 Aug 2023 07:58:14 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RHJ460wmJz3f;
        Fri,  4 Aug 2023 09:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1691135894;
        bh=USBa8tybNE/7SbGVxWIszCVvi2Fa/FdRugejEw2BVrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNkCT2A5r0zALnUiLBkXyDQKCZHdlBUci4sTHmJrcXR5WqC/ObfYNrrYJM64gte/V
         ZYODAOYfbUOFzBvdLYEa6SC/uLPq4TBMqdE52Q5hUcDxXv2B6hhcC0Yen03WQhvZlT
         RWhZuYYtm5Id/ZnxdiDDVn3O4yS0DugoDHCZgc7k=
Date:   Fri, 4 Aug 2023 09:58:24 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: ANN: new LSM guidelines
Message-ID: <20230804.at4Dei5LoiCa@digikod.net>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 03, 2023 at 05:38:23PM -0400, Paul Moore wrote:
> On Wed, Aug 2, 2023 at 6:00 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Aug 1, 2023 at 6:47 PM Paul Moore <paul@paul-moore.com> wrote:
> > > I've updated the README.md doc based on the feedback, and copied the
> > > two new sections below for easier review.  If anyone has any
> > > additional feedback or concerns, please let me know.
> >
> > Another update based on feedback received (thanks everyone!).  Just as
> > before, I welcome any comments or feedback you are able to share.
> 
> MOAR UPDATES!

With some optional nitpicking, looks good to me!

> 
> ## New LSM Hook Guidelines
> 
> While LSM hooks are considered outside of the Linux kernel's stable API
> promise, in order to limit unnecessary churn within the kernel we do try to
> minimize changes to the set of LSM hooks.  With that in mind, we have the
> following requirements for new LSM hooks:
> 
> * Hooks should be designed to be LSM agnostic.  While it is possible that only
> one LSM might implement the hook at the time of submission, the hook's behavior
> should be generic enough that other LSMs could provide a meaningful
> implementation.
> 
> * The hook must be documented with a function header block that conforms to
> the kernel documentation style.  At a minimum the documentation should explain
> the parameters, return values, a brief overall description, any special
> considerations for the callers, and any special considerations for the LSM
> implementations.
> 
> * New LSM hooks must demonstrate their usefulness by providing a meaningful
> implementation for at least one in-kernel LSM.  The goal is to demonstrate the
> purpose and expected semantics of the hooks.  Out of tree kernel code, and pass
> through implementations, such as the BPF LSM, are not eligible for LSM hook
> reference implementations.
> 
> It is important to note that these requirements are not complete, due to the
> ever changing nature of the Linux kernel and the unique nature of each LSM
> hook.  Ultimately, new LSM hooks are added to the kernel at the discretion of
> the maintainers and reviewers.
> 
> ## New LSM Guidelines
> 
> Historically we have had few requirements around new LSM additions, with
> Arjan van de Ven being the first to describe a basic protocol for accepting new
> LSMs into the Linux kernel[^1].  In an attempt to document Arjan's basic ideas
> and update them for modern Linux kernel development, here are a list of
> requirements for new LSM submissions:
> 
> * The new LSM's author(s) must commit to maintain and support the new LSM for
> an extended period of time.  While the authors may be currently employed to
> develop and support the LSM, there is an expectation upstream that support will
> continue beyond the author's employment with the original company, or the
> company's backing of the LSM.
> 
> * The new LSM must be sufficiently unique to justify the additional work
> involved in reviewing, maintaining, and supporting the LSM.  It is reasonable
> for there to be a level of overlap between LSMs, but either the security model
> or the admin/user experience must be significantly unique.
> 
> * New LSMs must include documentation providing a clear explanation of the
> LSM's requirements, goals, and expected uses.  The documentation does not need
> to rise to the level of a formal security model, but it should include a basic
> threat model with a description of the mitigations provided by the LSM.  Both
> the threat model and the LSM mitigations must be considered "reasonable" by
> the LSM community as a whole.
> 
> * Any user visible interfaces provided by the LSM must be well documented.  It
> is important to remember the user visible APIs are considered to be "forever
> APIs" by the Linux kernel community; do not add an API that cannot be supported
> for the next 20+ years.
> 
> * New LSMs must be accompanied by a publicly available test suite to verify
> basic functionality and help identify regressions.  Test coverage does not need
> to reach a specific percentage, but core functionality and any user interfaces

I'm not sure it is worth specifying the "not need" part, for tests and
documentation paragraphs.

> should be well covered by the test suite.  Maintaining the test suite in a
> public git repository is preferable over tarball snapshots.  Integrating the
> test suite with existing automated Linux kernel testing services is encouraged.
> 
> * The LSM implementation must follow general Linux kernel coding practices,
> faithfully implement the security model and APIs described in the
> documentation, and be free of any known defects at the time of submission.
> 
> * Any userspace tools or patches created in support of the LSM must be publicly
> available, with a public git repository preferable over a tarball snapshot.
> 
> It is important to note that these requirements are not complete, due to the
> ever changing nature of the Linux kernel and the unique nature of each LSM.
> Ultimately, new LSMs are added to the kernel at the discretion of the
> maintainers and reviewers.

This paragraph sounds a lot like the last paragraph of the LSM hook
section, but I don't have a better suggestion.

> 
> [^1]: https://lore.kernel.org/all/20071026141358.38342c0f@laptopd505.fenrus.org
> 
> -- 
> paul-moore.com
