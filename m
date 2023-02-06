Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BDBC636CD
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Feb 2023 00:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBFAKz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Feb 2023 19:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBFAKy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Feb 2023 19:10:54 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 057FC17157
        for <linux-security-module@vger.kernel.org>; Sun,  5 Feb 2023 16:10:52 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 3160AP94016703;
        Sun, 5 Feb 2023 18:10:26 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 3160AP5P016702;
        Sun, 5 Feb 2023 18:10:25 -0600
Date:   Sun, 5 Feb 2023 18:10:25 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 05/14] Add TSEM master header file.
Message-ID: <20230206001025.GA16594@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-6-greg@enjellic.com> <ecb168ef-b82d-fd61-f2f8-54a4ef8c3b48@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb168ef-b82d-fd61-f2f8-54a4ef8c3b48@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 05 Feb 2023 18:10:26 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Feb 04, 2023 at 06:58:08PM -0800, Casey Schaufler wrote:

> On 2/3/2023 9:09 PM, Dr. Greg wrote:
> > TSEM is designed, from a functional perspective, to be contained
> > entirely in its own directory.
> >
> > The tsem.h header file defines the enumeration types, structure
> > definitions and externally visiable functions that are referenced
> > by the TSEM LSM implementation.

Hi Casey, thanks for taking the time to look at all of this and raise
issues, we appreciate the feedback.

> This is really awkward.

With respect to awkward, those who know me well would never accuse me
of terpsichoric elegance, either balletic or in technology.... :-)

> Without the uses of the structures and constants it's very difficult
> to understand how any of this makes sense. It would be easier to
> review if the structures and constants were introduced as they are
> used rather than being presented in one massive dump.

With respect to any of this making sense, we've read and studied the
existing LSM's fairly extensively as we built TSEM, we accept our
prejudices of course, but we think that TSEM is probably one of the
easiest to follow conceptually.

Doesn't mean we can't do better though, particularly as we look at the
issue of that header file retrospectively.

I think where the presentation of the structures and enumeration
types, as a single entity falls down, is not explicitly documenting
the role and function of the structures and constants in that file.
We did that for the external functions in the compilation units and
should have done that for the contents of the include file.

I'm not sure that adding things to the include file incrementally will
be any more understandable without more explicit documentation.  If we
document them now, it should help not only the review process but
anyone who needs to look at the code down the road with a mind on
understanding whqt is going on.

Having the include file introduced as a standalone entity also assists
in reliably rolling a review patch set.  It is already easy enough to
make a mistake and we don't want to waste reviewer time and list
bandwidith with a blown patchset.

We will collect whatever additional comments are forthcoming and fully
document the contents of that file for the second spin of the patch.

Thanks again for your observations.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
