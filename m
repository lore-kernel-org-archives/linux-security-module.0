Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B0C282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F45217F9
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfBES2R (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:28:17 -0500
Received: from mail.emypeople.net ([216.220.167.73]:38475 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfBES2R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 13:28:17 -0500
Received: from Shop7 ([166.182.241.52])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201902051328150710;
        Tue, 05 Feb 2019 13:28:15 -0500
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Casey Schaufler'" <casey@schaufler-ca.com>,
        "'LSM'" <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
In-Reply-To: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
Subject: RE: New LSM hooks
Date:   Tue, 5 Feb 2019 13:28:08 -0500
Message-ID: <000001d4bd80$8b9442c0$a2bcc840$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHf3rRGqiR9Wt3dE8sqasOj5e4qfqW7PC5g
Content-Language: en-us
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tuesday, February 05, 2019 12:40 PM Casey Schaufler wrote:
> Full disclosure: This is all about me and my interests.
> 
> Developers propose new LSM hooks for many reasons. Often,
> it's in support of an exotic feature such as Infiniband.
> Sometimes it's because someone got clever when they optimized
> an otherwise mundane feature and bypassed the usual hooks,
> as is being proposed for kernfs. Usually there is a particular
> security module (i.e. SELinux) that is targeted for the hook.
> In almost all cases a hook is provided for that LSM, but not
> for any other. In many cases the developers don't even include
> the LSM email list in the discussions. LSM maintainers find
> out about the new hooks after the fact.
> 
> Prior to 2008, when there was only one LSM, this made perfect
> sense. Since then, it's been a regular practice justified by
> the notion that it's the LSM maintainer's option to use the
> hook or not. That also makes sense in cases where the use is
> strictly optional, as it is in binder. It does not make sense,
> however, when a core system facility like kernfs is involved.
> 
> I get a double whammy on these new LSM hooks. I have to try
> to figure out if Smack cares, and if it does, whether to proposed
> hook will solve the problem for Smack. Because Smack uses
> xattrs and process attributes differently from SELinux there are
> often problems with hooks that are provided with only an SELinux
> implementation. I also have to work out how the new hook will
> work in the stacked security module case. There are some existing
> hooks that are a special challenge there, and when a new hook is
> proposed that does the same kind of things (e.g. use of secid,
> secctx or list of xattrs) without considering the consequences
> for other modules.
> 
> What do I want, I hear you cry? I want some sanity in the way
> LSM hooks are introduced. I want some standards or conventions
> on what is appropriate to pass into and out of LSM hooks. I
> want push back on special purpose hooks that are required to
> fix the deficiencies of a filesystem or bizarre hardware
> implementation. I want to stop spending all my time trying to
> deal with new, crazy LSM hooks. There are enough old ones to
> keep me entertained, thank you very much.

I agree.  We need a roadmap of where we want the LSM infrastructure to go.
Without such a guide, LSM code is going to end up as a rats nest of
confusing, partially implemented, partially supported code.

Here's my suggestion for starters. According to kernel documentation, new 
LSMs must be documented before being accepted.  Perhaps we need a 
similar requirement for LSM hooks.  As I see it, LSMs are security additions,
not functionality patches for the rest of the kernel or for special hardware or
whatever.  Therefore, I also suggest that all new hooks be implemented in 
at least two LSMs before being accepted.

-Edwin Zimmerman

> We're about to get a bunch of new LSMs. I don't think that we
> can afford to continue with the current "feature A needs a hook
> for LSM S" behavior.

