Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D01CA0ECE
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Sep 2023 22:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357863AbjIKWGj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbjIKNDy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Sep 2023 09:03:54 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A8ACF0
        for <linux-security-module@vger.kernel.org>; Mon, 11 Sep 2023 06:03:49 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id DE5644D1; Mon, 11 Sep 2023 08:03:47 -0500 (CDT)
Date:   Mon, 11 Sep 2023 08:03:47 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Subject: Re: ANN: new LSM guidelines
Message-ID: <20230911130347.GA1613433@mail.hallyn.com>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Sep 09, 2023 at 09:46:02AM +0900, Tetsuo Handa wrote:
> On 2023/08/03 7:00, Paul Moore wrote:
> > * The new LSM must be sufficiently unique to justify the additional work
> > involved in reviewing, maintaining, and supporting the LSM.  It is reasonable
> > for there to be a level of overlap between LSMs, but either the security model
> > or the admin/user experience must be significantly unique.
> 
> s/work/burden/ ?
> 
> > * Any userspace tools or patches created in support of the LSM must be publicly
> > available, with a public git repository preferable over a tarball snapshot.
> 
> What is the definition of "publicly" here? Everyone can download related resources
> including the source code etc. anonymously (e.g. without asking for creating user
> account and/or buying subscriptions ) ?

Hm, that's a good point actually.  I would say that one must be able to fully
administer it with free (in both senses) tools, which must be used (let's aim
for the moon) in an included testsuite.  However, that doesn't need to be true
of "any" support tools.  If the author wants to sell some improved tools,  I
think that's good.  But again, the free tools must always be able to configure
every aspect of the LSM.

-serge
