Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DFC77B61
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Apr 2023 14:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjDGOLG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Apr 2023 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjDGOLF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Apr 2023 10:11:05 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDE3335A6
        for <linux-security-module@vger.kernel.org>; Fri,  7 Apr 2023 07:11:03 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 337EAPKQ017348;
        Fri, 7 Apr 2023 09:10:25 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 337EAOOb017347;
        Fri, 7 Apr 2023 09:10:24 -0500
Date:   Fri, 7 Apr 2023 09:10:24 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
Message-ID: <20230407141024.GA17078@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-3-greg@enjellic.com> <CAHC9VhQnZhczVRifSnM-zv46Cb9OFuh=6ha+1zKJaOUK15=K5A@mail.gmail.com> <20230214115822.GA28408@wind.enjellic.com> <CAHC9VhQoj-aWrN5SxfkT2zaNmaKCG7VyYVvGsaHAbp5iA8OBZw@mail.gmail.com> <20230313225227.GA23057@wind.enjellic.com> <CAHC9VhSfQOw-q6b-DHL=zXFr7_Dw=44VxkDTpPp_=4XAZk2k7g@mail.gmail.com> <20230330033442.GA1014@wind.enjellic.com> <CAHC9VhTQCLHQjEnBbGBZ7ya5s01hMr6WLLf_N54AmfYp_6TwsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTQCLHQjEnBbGBZ7ya5s01hMr6WLLf_N54AmfYp_6TwsQ@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 07 Apr 2023 09:10:25 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 05, 2023 at 04:45:26PM -0400, Paul Moore wrote:

Good morning, I hope the week has gone well for everyone.

> On Wed, Mar 29, 2023 at 11:35???PM Dr. Greg <greg@enjellic.com> wrote:
> > On Wed, Mar 22, 2023 at 07:45:26PM -0400, Paul Moore wrote:
> > > On Mon, Mar 13, 2023 at 6:52???PM Dr. Greg <greg@enjellic.com> wrote:
> > > > On Thu, Mar 02, 2023 at 11:15:56PM -0500, Paul Moore wrote:
> > > >
> > > > Hi Paul, thanks for sending along further comments.
> > > >
> > > > You note below that you haven't had time to look at the code since you
> > > > wanted to confirm the TSEM security model before moving forward.
> > > >
> > > > From a development perspective we are now three weeks into what will
> > > > become version 2 of the patch series.  So at this point I wouldn't
> > > > advocate spending a lot of time on the current patchset.
> > > >
> > > > That being said, if you some have time, we would appreciate a quick
> > > > look at the code on your part, with respect to style changes and the
> > > > like we can enforce in the second series, ie. ordering of local
> > > > variable declarations by length and the like.
> >
> > > To be perfectly honest I'm still very concerned about some of the
> > > issues that I've seen in the docs, until that is sorted out I'm not
> > > sure there is much point in looking at the code.
> >
> > I think those concerns can be resolved, see below for more
> > information, the second patch series that we are closing in on should
> > help address the concerns that are currently on the table.

> In that case, I think it might be best to wrap up this thread and we
> can resume the discussion on the next patchset.

Very good, we will look forward to the review of V2, which has now
been enhanced on a number of fronts.

> > That being said, since TSEM is a new codebase, we were hoping that you
> > could give us some guidance on function local variable ordering.
> > Reverse Christmas tree seems popular writ large in the kernel, I
> > believe that you commented in a posting a month or two ago that you
> > prefer standard Christmas tree, SMACK and SeLinux don't seem to
> > religiously embrace a style.
> >
> > Our codebase uses ordering based on least complex to most complex
> > variables and has worked for us, both in the kernel and elsewhere, but
> > we are ambivalent, as our primary objective is to avoid wasting
> > everyone's time on issues such as this.
> 
> The canonical guidance on coding style within the kernel is in the kernel docs:
> 
> https://www.kernel.org/doc/html/latest/process/coding-style.html
> 
> When in doubt, I would recommend following that as closely as possible.
> 
> As far as local variable ordering is concerned, I don't believe I've
> ever rejected patches due to that.  My own personal preference usually
> follows what you've described above: the least complex (simple
> scalars) at the top, with the more complex variables (composites) at
> the bottom.  In practice this tends to result in a "Christmas Tree"
> ordering, but it can be a bit lumpy (?) in some cases; that is fine.
> 
> There are two style nitpicks which annoy me enough to make it worth mentioning:
> 
> * Stick to 80 characters as much as possible, yes we all have
> terminals that can go wider, but I like to have several terminals on
> my screen and if they all need to be 100 chars wide I can't fit as
> many.  There are going to be some exceptions, e.g. error message
> string literals, but that should only happen a few times in a given
> file.  If you are finding that every function you write has a line
> that goes past 80 characters you are doing *something* wrong.
> 
> * If/when you split a single line across multiple lines due to the
> above, make sure the
> lines are indented properly such that they line up properly with the
> code above.  It's tricky to give all of the different examples so I'm
> not going to even try.  I realize that is garbage guidance, but the
> kernel coding style is a help here.
> 
> If you are really lost, I use the following 'astyle' command in other
> projects, and it should produce fairly kernel-style friendly code:
> 
> % astyle --options=none --lineend=linux --mode=c \
>     --style=linux \
>     --indent=force-tab=8 \
>     --indent-preprocessor \
>     --indent-col1-comments \
>     --min-conditional-indent=0 \
>     --max-instatement-indent=80 \
>     --pad-oper \
>     --align-pointer=name \
>     --align-reference=name \
>     --max-code-length=80 \
>     --break-after-logical

All of the above is consistent with what we have used for years,
particularly 80 columns, given that the principles of TSEM extend from
programming with a Model 29 keypunch and a drum card to applying
machine learning to security.

> paul-moore.com

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
