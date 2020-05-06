Return-Path: <SRS0=wiIN=6U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A189C28CBC
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 04:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F81520752
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 04:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgEFEDD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 May 2020 00:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgEFEDD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 00:03:03 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC1C061A0F;
        Tue,  5 May 2020 21:03:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWBGm-001vcO-RN; Wed, 06 May 2020 04:02:53 +0000
Date:   Wed, 6 May 2020 05:02:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <20200506040252.GC23230@ZenIV.linux.org.uk>
References: <202005051626.7648DC65@keescook>
 <20200506011431.GB23230@ZenIV.linux.org.uk>
 <202005052024.2D7626C742@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005052024.2D7626C742@keescook>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 05, 2020 at 08:28:33PM -0700, Kees Cook wrote:
> On Wed, May 06, 2020 at 02:14:31AM +0100, Al Viro wrote:
> > On Tue, May 05, 2020 at 04:40:35PM -0700, Kees Cook wrote:
> > > After using simple_unlink(), a call to d_delete() is needed in addition
> > > to dput().
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > Is this correct? I went looking around and there are a lot of variations
> > > on the simple_unlink() pattern...
> > > 
> > > Many using explicit locking and combinations of d_drop(), __d_drop(), etc.
> > 
> > Quite a few of those should switch to simple_recursive_removal().  As for
> > securityfs...  d_drop() is _probably_ a saner variant, but looking at the
> > callers of that thing... at least IMA ones seem to be garbage.
> 
> Hmm, I dunno. I hadn't looked at these yet. I'm not sure what's needed
> for those cases.
> 
> Is my patch to add d_delete() correct, though? I'm trying to construct
> the right set of calls for pstore's filesystem, and I noticed that most
> will do simple_unlink(), d_delete(), dput(), but securityfs seemed to be
> missing it.

d_drop().  d_delete() is for the situations when you want the sucker
to become a hashed negative, if at all possible.

Re pstore: context, please.
