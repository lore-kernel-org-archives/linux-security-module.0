Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672AEC001DF
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Aug 2023 12:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHAMze (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Aug 2023 08:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHAMzd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Aug 2023 08:55:33 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BFDE6
        for <linux-security-module@vger.kernel.org>; Tue,  1 Aug 2023 05:55:31 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 8E83B7EF; Tue,  1 Aug 2023 07:55:29 -0500 (CDT)
Date:   Tue, 1 Aug 2023 07:55:29 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Subject: Re: TSEM feedback.
Message-ID: <20230801125529.GA915814@mail.hallyn.com>
References: <20230731103822.GA4093@wind.enjellic.com>
 <CAHC9VhT_6yv=hgCLUMYf154=-ARY5+V+FMi_0O+_t2rsb341Eg@mail.gmail.com>
 <20230801105421.GA23193@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801105421.GA23193@wind.enjellic.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 01, 2023 at 05:54:21AM -0500, Dr. Greg wrote:
> On Mon, Jul 31, 2023 at 10:57:08AM -0400, Paul Moore wrote:
> 
> Good morning, I hope the day is starting well.
> 
> > On Mon, Jul 31, 2023 at 6:39???AM Dr. Greg <greg@enjellic.com> wrote:
> > >
> > > Good morning Paul, I hope this note finds your week starting well.
> > >
> > > We submitted the patches for the V2 release of TSEM three weeks ago.
> > >
> > > We received some feedback from Randy Dunlap on some documentations
> > > issues that we went on to address.
> > >
> > > Haven't heard any reflections from you.  Was just wondering if you
> > > were swamped or had possibly missed the submission?  We didn't include
> > > you as a copy on the notion that you didn't need two sets of patches
> > > landing in your inbox.
> 
> > If your mail hits the mail archive on lore.kernel.org, it is almost
> > a full guarantee that it has hit my inbox and/or the patchwork
> > instance I use to ensure nothing is missed.
> 
> So noted.
> 
> > As one would expect, it takes a good deal of time to review a patch
> > submission as large as TSEM, and the rather ornate language used in
> > the documentation only slows the process.
> 
> For whatever it is worth, as a group, we invested a considerable
> amount of time, over a period of now 8+ years, in refining the
> terminology and nomenclature embodied in that document.
> 
> I guess the only defense at hand is a variant on the alleged response
> by Austrian Emperor Joseph II to Mozart's "Die Entfuhrung aus dem
> Serail":
> 
> "It contains as many words, with appropriate ornateness, as was deemed
> necessary."

I cannot let such a golden opportunity pass to use
  https://www.youtube.com/watch?v=gA-sEfXOaEQ
