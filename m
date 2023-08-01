Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7171C41513
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Aug 2023 11:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjHALLb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Aug 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjHALLL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Aug 2023 07:11:11 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63ACE1BF5
        for <linux-security-module@vger.kernel.org>; Tue,  1 Aug 2023 04:06:08 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 371AsLti023239;
        Tue, 1 Aug 2023 05:54:21 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 371AsLAj023238;
        Tue, 1 Aug 2023 05:54:21 -0500
Date:   Tue, 1 Aug 2023 05:54:21 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: TSEM feedback.
Message-ID: <20230801105421.GA23193@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230731103822.GA4093@wind.enjellic.com> <CAHC9VhT_6yv=hgCLUMYf154=-ARY5+V+FMi_0O+_t2rsb341Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT_6yv=hgCLUMYf154=-ARY5+V+FMi_0O+_t2rsb341Eg@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 01 Aug 2023 05:54:22 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 31, 2023 at 10:57:08AM -0400, Paul Moore wrote:

Good morning, I hope the day is starting well.

> On Mon, Jul 31, 2023 at 6:39???AM Dr. Greg <greg@enjellic.com> wrote:
> >
> > Good morning Paul, I hope this note finds your week starting well.
> >
> > We submitted the patches for the V2 release of TSEM three weeks ago.
> >
> > We received some feedback from Randy Dunlap on some documentations
> > issues that we went on to address.
> >
> > Haven't heard any reflections from you.  Was just wondering if you
> > were swamped or had possibly missed the submission?  We didn't include
> > you as a copy on the notion that you didn't need two sets of patches
> > landing in your inbox.

> If your mail hits the mail archive on lore.kernel.org, it is almost
> a full guarantee that it has hit my inbox and/or the patchwork
> instance I use to ensure nothing is missed.

So noted.

> As one would expect, it takes a good deal of time to review a patch
> submission as large as TSEM, and the rather ornate language used in
> the documentation only slows the process.

For whatever it is worth, as a group, we invested a considerable
amount of time, over a period of now 8+ years, in refining the
terminology and nomenclature embodied in that document.

I guess the only defense at hand is a variant on the alleged response
by Austrian Emperor Joseph II to Mozart's "Die Entfuhrung aus dem
Serail":

"It contains as many words, with appropriate ornateness, as was deemed
necessary."

I believe the case can be made that Quixote/TSEM approaches the
challenge of security from a significantly different conceptual basis
than a significant body of current art in the field.

Legend has it that Dyson and Feynman spent two years talking before
they were able to conclude that they were understanding one another,
despite the fact they were working toward a common goal.

> Rest assured it is firmly on my todo list, but please understand it
> will take some time to properly review.  In the meantime I would
> encourage others to review/play/etc. with TSEM; nothing builds
> maintainer comfort quite like seeing reviews from other trusted
> members of the community.

We respect any time you can afford to this.

With respect to the notion of getting others to play with a new
technology concept.

Security, from an innovation perspective, is an interesting challenge,
probably a candidate for a book with my long time trusted consigliere.
Who, at the risk of excessive ornateness, would delve deeply into the
notion of how structural inherencies act to preclude innovation.

> paul-moore.com

Thanks for the update, best wishes for a productive remainder of the
week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
