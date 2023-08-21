Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00616EE49AA
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Aug 2023 16:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjHUQEw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHUQEv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Aug 2023 12:04:51 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C74E4;
        Mon, 21 Aug 2023 09:04:49 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 4E1F0A29; Mon, 21 Aug 2023 11:04:46 -0500 (CDT)
Date:   Mon, 21 Aug 2023 11:04:46 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        audit@vger.kernel.org, Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] audit: add task history record
Message-ID: <20230821160446.GA1317178@mail.hallyn.com>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Aug 19, 2023 at 04:09:46PM +0900, Tetsuo Handa wrote:
> Anyway, enabling TOMOYO in Fedora/RHEL kernels won't solve the problem
> this patch is trying to solve, for TOMOYO cannot utilize TOMOYO's process
> history information because LSM hook for sending signals does not allow
> TOMOYO to sleep...

Hang on a tick - I think perhaps you should have led with this.  The
main argument against this has been (iiuc) that it is a subset of
tomoyo functionality.  In that case, I'm on the fence about whether it
should be included.

But here you say that tomoyo cannot do this.  If that's the case, and
this is simply completely new functionality, that changes things.

-serge
