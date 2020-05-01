Return-Path: <SRS0=mFfD=6P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75EDC4724C
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 16:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BDF20836
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 16:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gJ5ZE03+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgEAQhq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 May 2020 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729565AbgEAQhp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 May 2020 12:37:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B197C061A0E
        for <linux-security-module@vger.kernel.org>; Fri,  1 May 2020 09:37:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d16so7667391edq.7
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2020 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIPdW26vFB4MJ8eFWZufOUSxSPuDiQ/oBKR6n6zAuCQ=;
        b=gJ5ZE03+3vD6JV5mikbt/a67qcOnBb9++h/15VTm2/laibqIpyKbjxqROTd+jkTTgV
         C6hE04paAIcX5JOOkNiAFT7kDMURyHoh6utJpnL+BVlIj0wS+ZReXw97sSBEALxJ4qZ/
         TXaieTtvGhyXpI5bBk18/G8++sIVFWgmnN3KAE1Aq+r+1QYUqka4Dqd2wBzZSfdKdXwi
         efCKixcnsHnIVvecKF1hoqEjWMefw78S4CS/bLJgzdJx3U7NN1jJ+hkQRhYQa4On/thg
         VGthP+oJz5MqpLC9+ilZ3a5ONU7C/0aPmBB6cZ6GrspDseYFBppSVEi3e72p4iZZzay/
         rqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIPdW26vFB4MJ8eFWZufOUSxSPuDiQ/oBKR6n6zAuCQ=;
        b=VbcQfge0wg97wT7KjTiJHsBg/kTy7vI3cswOai8n+FXOHFXm8IjU75Kwu5eIB6x5JW
         BZCstjIWbxFt71i3+m6M5DRs3vKVIo1fl+X96e6hZwynPbuSrmmjdYgDjkbqD5U7IW3F
         jv7OdKR8KYVhwiNTSeDHjtOx89xyK0Sm7ASHBEjmPw2MuFNmCGljQk4G2NwsoD+iVVCJ
         awqx1I61/U3y+I7J9amabJzceoXemWfifcfUdhn8HiV5KlYq1GV4ayj2fqZkg6di8/il
         l3OsPDktd1Ly6E35fYeONuJ6L+uP8iNSclOGwu68OXeoZnQ8DNx6JqsjLt9tNbTY1kjp
         1LjQ==
X-Gm-Message-State: AGi0PubUMQKpOAEWVq9N4Q0hcmL5gwhDZcIJpbQAf5eJ3d/nscsTuePD
        r6+5Z+EyUh7A/zIPQEDx4+OOxwA1dC9l8tCz+Alb
X-Google-Smtp-Source: APiQypKoUjiJL7Sch0Qif2RZJb485+cC+mL0/HRjGDH3Aw+VwBM0aH3UfAIqlwQlmljK5A4QePcCctWZWyDW9GnCNmw=
X-Received: by 2002:aa7:c401:: with SMTP id j1mr4214419edq.31.1588351063874;
 Fri, 01 May 2020 09:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <924658.1588078484@warthog.procyon.org.uk> <CAEjxPJ5+DtZfX36OLYiLbU=1tGZcPUWFUi1=mFfx=ntehtvd3Q@mail.gmail.com>
 <1072935.1588089479@warthog.procyon.org.uk> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 12:37:32 -0400
Message-ID: <CAHC9VhTO0Ag-CODexD8hjZdTzUBEd4nJdR191o__=+iOLUHmFw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms [v2]
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 28, 2020 at 12:19 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Apr 28, 2020 at 11:58 AM David Howells <dhowells@redhat.com> wrote:
> > Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > > 1) Are we guaranteed that the caller only ever passes a single
> > > KEY_NEED_* perm at a time (i.e. hook is never called with a bitmask
> > > of multiple permissions)?  Where is that guarantee enforced?
> >
> > Currently it's the case that only one perm is ever used at once.  I'm tempted
> > to enforce this by switching the KEY_NEED_* to an enum rather than a bitmask.
> >
> > I'm not sure how I would actually define the meaning of two perms being OR'd
> > together.  Either okay?  Both required?
>
> Both required is the usual convention in functions like
> inode_permission() or avc_has_perm().
> But if you know that you'll never use combinations, we should just
> prohibit it up front, e.g.
> key_task_permission() or whatever can reject them before they reach
> the hook call.  Then the
> hook code doesn't have to revisit the issue.
>
> >
> > > 2) We had talked about adding a BUILD_BUG_ON() or other build-time
> > > guard
> >
> > That doesn't help you trap unallowed perm combinations, though.
>
> I think we want both.

Yep, we want both. #moarsafety

-- 
paul moore
www.paul-moore.com
