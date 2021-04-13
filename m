Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F98C433B4
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Apr 2021 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C431613CA
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Apr 2021 19:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbhDMTCM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:02:12 -0400
Received: from mail.hallyn.com ([178.63.66.53]:44728 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhDMTCM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Apr 2021 15:02:12 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id BF6B25F6; Tue, 13 Apr 2021 14:01:50 -0500 (CDT)
Date:   Tue, 13 Apr 2021 14:01:50 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, casey@schaufler-ca.com
Subject: Re: [RFC PATCH 0/3] LSM Documentation - Render lsm_hooks.h for
 kernel_docs
Message-ID: <20210413190150.GB26626@mail.hallyn.com>
References: <20210309143953.142341-1-richard_c_haines@btinternet.com>
 <CAHC9VhSHm-GrmjdZKPFf8Rr5JNzo7ieR+mSy7F3n-KjfD1OEaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSHm-GrmjdZKPFf8Rr5JNzo7ieR+mSy7F3n-KjfD1OEaA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 07, 2021 at 09:42:01PM -0400, Paul Moore wrote:
> On Tue, Mar 9, 2021 at 9:40 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > This patch series updates the LSM hook text defined in the comments
> > section of inlcude/linux/lsm_hooks.h. This enables the hook functions to
> > be rendered in kernel_docs html or pdf format.
> >
> > Note that no text has been changed in lsm_hooks.h, only formatting
> > to render the text.
> >
> > To get the correct rendering some lines have exceeded checkpatch limits and
> > therefore has a moan. The function statements seem to need being a
> > continuous line. The others can be split, but decided not to.
> > Any better ideas ??
> >
> > The hook functions render in HTML ok, however in PDF format the only issue
> > is that the long function definitions do not wrap and therefore truncated.
> > Check the 'int sb_mount(const char *dev_name' entry in:
> > Documentation/output/pdf/security.pdf
> >
> > For reference two hooks have been marked as deprecated: sb_copy_data() and
> > sb_parse_opts_str()
> >
> > Tested using 'make pdfdocs' and 'make htmldocs'
> >
> > Richard Haines (3):
> >   Documentation/security: Update LSM security hook text
> >   include/linux: Update LSM hook text part1
> >   include/linux: Update LSM hook text part2
> >
> >  Documentation/security/lsm-development.rst |    5 +-
> >  include/linux/lsm_hooks.h                  | 2365 +++++++++++---------
> >  2 files changed, 1364 insertions(+), 1006 deletions(-)
> 
> I haven't yet pulled this patchset to generate the HTML/PDF docs, but
> just looking at the comments themselves it looks reasonable to me ...
> and I say this as being perhaps one of the stricter folks under
> security/ when it comes to 80 character line lengths :)  In my
> opinion, the benefit of being able to render the docs nicely outweigh
> the pain of scrolling horizontally in my editor.  Thanks for doing
> this Richard.
> 
> Does anyone else have any thoughts on these changes?

No objection from me.
