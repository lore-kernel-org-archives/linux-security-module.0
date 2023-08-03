Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D25C04FDF
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 09:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjHCJos (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 05:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjHCJoY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 05:44:24 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD13A86
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 02:44:15 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RGkSs67zgzMr5cp;
        Thu,  3 Aug 2023 09:44:13 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RGkSs3VTWz13MT;
        Thu,  3 Aug 2023 11:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1691055853;
        bh=wSWF34RNhhW6Jz37vw6XeQbdS/HJ5+tRUgY77bit+KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5qnmzkjXk5Y2+54Zv14/qd1Q0Jse7j9IRZf2J60zlrFvinOFxwi8Z3BA6+GJxgCR
         be+/GmD8HZdAMFD/ZoEY+w8/RFhQhrbmOpzyJ3oMpreEru0tQnNHZQlrQe7E/lPy0X
         21hJdrnW5g9heADFMhGsIFz6wNW5jagYQltmQTkg=
Date:   Thu, 3 Aug 2023 11:44:21 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: ANN: new LSM guidelines
Message-ID: <20230803.alohoMev7thu@digikod.net>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 02, 2023 at 06:00:22PM -0400, Paul Moore wrote:
> On Tue, Aug 1, 2023 at 6:47 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > I've updated the README.md doc based on the feedback, and copied the
> > two new sections below for easier review.  If anyone has any
> > additional feedback or concerns, please let me know.
> 
> Another update based on feedback received (thanks everyone!).  Just as
> before, I welcome any comments or feedback you are able to share.
> 
> ## New LSM Hook Guidelines
> 
> While LSM hooks are considered outside of the Linux Kernel's stable API

s/Kernel/kernel/g

[...]

> * New LSMs must be accompanied by a test suite to verify basic functionality
> and help identify regressions.  Test coverage does not need to reach a specific
> percentage, but core functionality and any user interfaces should be well
> covered by the test suite.  Integration with existing automated Linux Kernel
> testing services is encouraged.

I'd suggest to require tests to be publicly available and easy (or not
too difficult) to run for the sake of sanity of other kernel developers
that might need to quickly fix (critical) bugs even without the help of
the maintainer (who might be unavailable for various reasons).  I guess
you could argue that decent kernel code needs a reasonable bus factor
protection, but making tests available and easy to use is a quality
guarantee.
