Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D2C76195
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57672173E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563286893;
	bh=vmX9VdzgEVkzXjoBCGARBvaP7HcICYjEr9mY6BaKpo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pQQSyJG4g3TyRwAG9/ZQa/WQPl8XNx+jZ+xrFrmmJ/STps7Muk8n8VY8yQ+WZN+jY
	 YBO7m4GzDfnP10+PmMm5PSAvjVl6XbpxNlJ3RO0DFdibet3SkcvQ95nTw+Q4aYRLi3
	 yMcuARs71X+SKEWH3/9x0dTsCSlq0Gj+9Stgkkds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGPOVc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfGPOVc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 10:21:32 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A442182B
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563286891;
        bh=vmX9VdzgEVkzXjoBCGARBvaP7HcICYjEr9mY6BaKpo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UWilFIL2c9HZ6FRhpSX3vBYHuxwhRhBRN3wlUIA4j2vI2XMSMPc2pgx0hvuwbWvfw
         0c76eEEnj+E23/lLnZ2REVNW7kSlaF1jv3/1SKl3OxmymkfKDb8b7fXG2VvFZE7o2H
         0pIQTC7zZKejWGicW1CSkpbfQ/Q4kQQL9tmelzOw=
Received: by mail-wm1-f43.google.com with SMTP id g67so14798986wme.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 07:21:30 -0700 (PDT)
X-Gm-Message-State: APjAAAWaKhwuzsy5JculHi97jH5x2a2e7XUpHwEhzRnhCX/wItD1/IfA
        qRSDxwEEblgAa+UKr7en8hKOtsxYjJN+cRUO5B/f+g==
X-Google-Smtp-Source: APXvYqyQrDZcmNQVzJqUctOX4RaB+roUpvOW/nTTvlPxsyR6XFMwi2SPZsUp5sj6kIcm8J4yAASqvHJdUN1dY1jhJ1g=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr31134122wmk.79.1563286889189;
 Tue, 16 Jul 2019 07:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov> <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov> <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
 <20190716140349.GA4991@mail.hallyn.com>
In-Reply-To: <20190716140349.GA4991@mail.hallyn.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Jul 2019 07:21:11 -0700
X-Gmail-Original-Message-ID: <CALCETrXR3RoRF0kZk_G-gAg=D6LNAcBJYiiHFHSe3S=bRZcwNA@mail.gmail.com>
Message-ID: <CALCETrXR3RoRF0kZk_G-gAg=D6LNAcBJYiiHFHSe3S=bRZcwNA@mail.gmail.com>
Subject: Re: [RFC PATCH] security, capability: pass object information to security_capable
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        mortonm@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 16, 2019 at 7:03 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Fri, Jul 12, 2019 at 12:54:02PM -0700, Casey Schaufler wrote:
> > On 7/12/2019 11:25 AM, Stephen Smalley wrote:
> > > On 7/12/19 1:58 PM, Casey Schaufler wrote:
> > >> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
> > >>> At present security_capable does not pass any object information
> > >>> and therefore can neither audit the particular object nor take it
> > >>> into account. Augment the security_capable interface to support
> > >>> passing supplementary data. Use this facility initially to convey
> > >>> the inode for capability checks relevant to inodes. This only
> > >>> addresses capable_wrt_inode_uidgid calls; other capability checks
> > >>> relevant to inodes will be addressed in subsequent changes. In the
> > >>> future, this will be further extended to pass object information for
> > >>> other capability checks such as the target task for CAP_KILL.
> > >>
> > >> This seems wrong to me. The capability system has nothing to do
> > >> with objects. Passing object information through security_capable()
> > >> may be convenient, but isn't relevant to the purpose of the interface.
> > >> It appears that there are very few places where the object information
> > >> is actually useful.
> > >
> > > A fair number of capabilities are checked upon some attempted object access (often right after comparing UIDs or other per-object state), and the particular object can be very helpful in both audit and in access control.  More below.
> >
> > I'm not disagreeing with that. What I'm saying is that the capability
> > check interface is not the right place to pass that information. The
> > capability check has no use for the object information. I would much
>
> I've had to argue this before while doing the namespaced file
> capabilities implementation.  Perhaps this would be worth writing something
> more formal about.  My main argument is, even if we want to claim that the
> capabilities model is and should be object agnostic, the implementation
> of user namespaces (currently) is such that the whole view of the user's
> privilege must include information which is stored with the object.
>
> There are various user namespaces.
>
> The Linux capabilities ( :-) ) model is user namespaced.  It must be, in
> order to be useful.  If we're going to use file capabilities in distros,
> and distros are going to run in containers, then the capabilities must
> be namespaced.  Otherwise, capabilities will not be used, and heck, should
> just be dropped.
>
> The only way to find out which user namespace has privilege over an inode
> is to look at the inode.
>
> Therefore, object information is needed.

Agreed.  The concept in the kernel is "capability over a namespace."

That being said, sticking a flexible object type into ns_capable()
seems prematurely general to me.  How about adding
security_capable_wrt_inode_uidgid() and allowing LSMs to hook that?
The current implementation would go into commoncap.  The obvious
extensions I can think of are security_dac_read_search(..., inode,
...) and security_dac_override(..., inode, ...).  (Or dentry or
whatever is appropriate.)

If this patch were restructured like that, the semantics would be
obvious, and it would arguably be a genuine cleanup instead of a whole
new mechanism of unknown scope.
