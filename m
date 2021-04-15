Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A22C433B4
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Apr 2021 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE689611AD
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Apr 2021 13:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhDOOAI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Apr 2021 10:00:08 -0400
Received: from mailomta25-re.btinternet.com ([213.120.69.118]:28118 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232976AbhDOOAI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Apr 2021 10:00:08 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 10:00:07 EDT
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20210415135406.ZZU30724.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 15 Apr 2021 14:54:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1618494846; 
        bh=PEIQZRl02qSK0bAUVPnjtZ16+29ZysaK0ipawB7wr84=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=AeBSrgVCS7THI3BAL/PtU67KRtpLdnurmt8BTKmBso0vB129SrJ6KPiqq1yEOa+v9dp9BwR/1kRDDNQfpVDdxq1wMdFnQvty2/Z98+zV6pHBSTXfOPgtG8ZoIRfz5O4p3lzYGCBOPmEyTlbCsvToALa2WdOXG1vrWpB9xuxHwwYcVtC4FHRa6uZDQ/c1iaIIPGREaHaeI1tjrTe8xkP4UN1YWnqT8cnkw/OnAhY8wtogE9Wb3VykGBEyuzw2KNaZ60vnhcTexzXQwimcP70Kr2/osmAFotI1jmOE2J8ESVEWSwfkFxyoWofdNlO7ZwCC5J6rgGofXc3S5rMwYiSFFA==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C74D2F0690E7
X-Originating-IP: [109.158.127.17]
X-OWM-Source-IP: 109.158.127.17 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudelfedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeegheduudeggfffkeehheettefgjedugefhhfevuedvveduhedtleejkeduveenucfkphepuddtledrudehkedruddvjedrudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpedutdelrdduheekrdduvdejrddujedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomheqpdhrtghpthhtohepoegtohhrsggvtheslhifnhdrnhgvtheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehl
        ihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghrghgvsehhrghllhihnhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (109.158.127.17) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C74D2F0690E7; Thu, 15 Apr 2021 14:54:06 +0100
Message-ID: <96941e4977f38dea58a56fe19cfeb84179f0e3ef.camel@btinternet.com>
Subject: Re: [RFC PATCH 0/3] LSM Documentation - Render lsm_hooks.h for
 kernel_docs
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, James Morris <jmorris@namei.org>,
        casey@schaufler-ca.com
Date:   Thu, 15 Apr 2021 14:53:55 +0100
In-Reply-To: <20210413190150.GB26626@mail.hallyn.com>
References: <20210309143953.142341-1-richard_c_haines@btinternet.com>
         <CAHC9VhSHm-GrmjdZKPFf8Rr5JNzo7ieR+mSy7F3n-KjfD1OEaA@mail.gmail.com>
         <20210413190150.GB26626@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2021-04-13 at 14:01 -0500, Serge E. Hallyn wrote:
> On Wed, Apr 07, 2021 at 09:42:01PM -0400, Paul Moore wrote:
> > On Tue, Mar 9, 2021 at 9:40 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > 
> > > This patch series updates the LSM hook text defined in the
> > > comments
> > > section of inlcude/linux/lsm_hooks.h. This enables the hook
> > > functions to
> > > be rendered in kernel_docs html or pdf format.
> > > 
> > > Note that no text has been changed in lsm_hooks.h, only
> > > formatting
> > > to render the text.
> > > 
> > > To get the correct rendering some lines have exceeded checkpatch
> > > limits and
> > > therefore has a moan. The function statements seem to need being
> > > a
> > > continuous line. The others can be split, but decided not to.
> > > Any better ideas ??
> > > 
> > > The hook functions render in HTML ok, however in PDF format the
> > > only issue
> > > is that the long function definitions do not wrap and therefore
> > > truncated.
> > > Check the 'int sb_mount(const char *dev_name' entry in:
> > > Documentation/output/pdf/security.pdf
> > > 
> > > For reference two hooks have been marked as deprecated:
> > > sb_copy_data() and
> > > sb_parse_opts_str()
> > > 
> > > Tested using 'make pdfdocs' and 'make htmldocs'
> > > 
> > > Richard Haines (3):
> > >   Documentation/security: Update LSM security hook text
> > >   include/linux: Update LSM hook text part1
> > >   include/linux: Update LSM hook text part2
> > > 
> > >  Documentation/security/lsm-development.rst |    5 +-
> > >  include/linux/lsm_hooks.h                  | 2365 +++++++++++---
> > > ------
> > >  2 files changed, 1364 insertions(+), 1006 deletions(-)
> > 
> > I haven't yet pulled this patchset to generate the HTML/PDF docs,
> > but
> > just looking at the comments themselves it looks reasonable to me
> > ...
> > and I say this as being perhaps one of the stricter folks under
> > security/ when it comes to 80 character line lengths :)  In my
> > opinion, the benefit of being able to render the docs nicely
> > outweigh
> > the pain of scrolling horizontally in my editor.  Thanks for doing
> > this Richard.
> > 
> > Does anyone else have any thoughts on these changes?
> 
> No objection from me.

Thanks for the comments, I'll rebuild on 5.12-rc7 and resubmit as a
patch.


