Return-Path: <SRS0=Slz7=2N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCABC2D0C0
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Dec 2019 19:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3100F206B7
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Dec 2019 19:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLWTOY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:14:24 -0500
Received: from mail.hallyn.com ([178.63.66.53]:46372 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWTOY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Dec 2019 14:14:24 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 8AC9FF07; Mon, 23 Dec 2019 13:14:21 -0600 (CST)
Date:   Mon, 23 Dec 2019 13:14:21 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Andrew G. Morgan" <morgan@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ksrot@redhat.com
Subject: Re: Anomalous output from getpcaps(1) for process with all
 capabilities
Message-ID: <20191223191421.GA32030@mail.hallyn.com>
References: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
 <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
 <CAKgNAkjuFOumKV6Z+GDDEjLrVup7fJB_H86xguJ7asdUdfEBxQ@mail.gmail.com>
 <CALQRfL57VP_VHuHSzM9A65wxR6LjsH9+3wgeQ3qQEU0G9PuWHw@mail.gmail.com>
 <CAKgNAki++fQ3UtvA15g87YDPggbcinpJge-wf5nV76yrEqDgCA@mail.gmail.com>
 <CALQRfL4_kVKX=qJ0nDnEGgVeUHtQG5BDTCX72KfZr0toc-Mpuw@mail.gmail.com>
 <20191221030845.GA3626@mail.hallyn.com>
 <CALQRfL4O2CgkAdOxhsqN87MBDDaVhRaHBRVMu+hecQq-Fu8q-A@mail.gmail.com>
 <20191221043622.GA4580@mail.hallyn.com>
 <CALQRfL50+JUGcWk_NyyKvviCeNUPQdjjP=OGoewvH-mU6Pn2hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQRfL50+JUGcWk_NyyKvviCeNUPQdjjP=OGoewvH-mU6Pn2hQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Dec 22, 2019 at 10:00:06AM -0800, Andrew G. Morgan wrote:
> I can take a look, but I'm not really convinced this isn't going to
> cause me grief at some point in the future when the kernel adds
> support for another capability and all' does not equal all. I've done
> some digging and I thought it was worth writing up.
> 
> Today, the kernel treats 'all' (as it is defined by libcap today)
> differently for file and process capabilities. I suspect this is
> contributing to expectations about what all means, because all as
> defined today is effectively useless, and somewhere in the kernel
> we've worked around it for filecaps when we shouldn't have.
> 
> Explanation of kernel bug (no use of 'all' here):
> 
> 1) placing, say, bit-63 (undef today) and bit-0 (cap_chown) on the
> permitted (fP) vector of a file, yields a file that can execute - it
> gets pP=cap_chown.
> 
> cd libcap/progs ; make ; cp capsh pcapsh ; sudo setcap
> 63,cap_setpcap,cap_chown=p pcapsh
> 
> ./pcapsh --print
> 
> 2) dropping cap_chown from the bounding set causes this same file to
> not run (insufficient privilege) because the file has been setup to
> require cap_chown, but can't have it so (by design) we deny execution
> altogether -- this fails:
> 
> ./pcapsh --drop=cap_chown --print == --print
> 
> To be consistent, (1) should fail because bit-63 is being dropped by
> the bounding set at execution time. That is, a binary that requires
> some future definition for capability #63 to run successfully should
> fail on a kernel that does not support it today.  This but was
> introduced with this kernel commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/security/commoncap.c?id=7d8b6c63751cfbbe5eef81a48c22978b3407a3ad
> 
> Ironically, the commit message declares the fact that (4) now passes
> is the fix. The real fix is to think about what we mean by 'all'.

Yes, I get the feeling you're right.

It'd be nice to simply say "you can only enable the caps you know
about, bit by bit."  The problem is, we have distributions, and we
have containers, and demanding that all filecap-enabled binaries be
fixed up every time you switch to a new kernel with more or fewer
capabilities is unworkable.

One thing we could do is declare that bit nbits-1 (63 in 64 bit caps)
means "all caps that the kernel knows about."  If 63 and any other
caps are enabled, then -EINVAL.  If/when we switch to 128 bit caps,
then bit 63 becomes a valid cap there, and 127 is 'all'.

Of course that's not at all backward compatible, so would have to be
done in a new capability version.

-serge
