Return-Path: <SRS0=JoCX=A2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352AAC433E3
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0642A2068F
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 06:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SI0lmEAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGOGmv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgGOGmv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jul 2020 02:42:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21059C061755;
        Tue, 14 Jul 2020 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iiqlg7cTMEEh/98unAkrIf26PUMXeeNcPlUx1yAhp14=; b=SI0lmEAhe6+jdUykJJbbeGfMrp
        drBSmZEhyCV/54C6ocS8LX4JV4aUnx0mzv66YzEMI4Dnt2JVYFYr7InMRqdNkrm4M1gPToMPhwJzM
        BdVI+QwIgit2XFWYHGyM7+oWVfyH9G6CNJBFQv5OdNvN3UxsCHbuQkLB9nwH32xrZ2C6xTMnvsuiA
        Wu02DiIjtAWMnXJblrZGTKRLHU2CHMfaM/zVRf0gynSmHTMmGjqbyEM1ZZ4dsewDrfLGEmDV+AHdS
        6/BS9UiJmePMczg76GSwOX30yDfmGKjUDGhkVQpWVg5YYjmqIPJntXGXpSDiZhBnqSK3t9FawFunX
        F8ciAzTA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvb7x-0001AT-0R; Wed, 15 Jul 2020 06:42:49 +0000
Date:   Wed, 15 Jul 2020 07:42:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <20200715064248.GH32470@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
 <202007141446.A72A4437C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007141446.A72A4437C@keescook>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 02:49:23PM -0700, Kees Cook wrote:
> On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> > +static int count_strings_kernel(const char *const *argv)
> > +{
> > +	int i;
> > +
> > +	if (!argv)
> > +		return 0;
> > +
> > +	for (i = 0; argv[i]; ++i) {
> > +		if (i >= MAX_ARG_STRINGS)
> > +			return -E2BIG;
> > +		if (fatal_signal_pending(current))
> > +			return -ERESTARTNOHAND;
> > +		cond_resched();
> > +	}
> > +	return i;
> > +}
> 
> I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
> refactor that too? (And maybe rename it to count_strings_user()?)

Liks this?

http://git.infradead.org/users/hch/misc.git/commitdiff/35a3129dab5b712b018c30681d15de42d9509731
