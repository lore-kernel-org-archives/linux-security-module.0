Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238A4C282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E782083B
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 20:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfBEUKN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:10:13 -0500
Received: from mail.emypeople.net ([216.220.167.73]:42531 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfBEUKN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 15:10:13 -0500
Received: from Shop7 ([166.182.241.52])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201902051510094375;
        Tue, 05 Feb 2019 15:10:09 -0500
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Casey Schaufler'" <casey@schaufler-ca.com>,
        "'LSM'" <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com> <000001d4bd80$8b9442c0$a2bcc840$@211mainstreet.net> <c15e8f04-df2e-40f4-d227-754d03de3dd0@schaufler-ca.com>
In-Reply-To: <c15e8f04-df2e-40f4-d227-754d03de3dd0@schaufler-ca.com>
Subject: RE: New LSM hooks
Date:   Tue, 5 Feb 2019 15:10:02 -0500
Message-ID: <000001d4bd8e$c7c5c620$57515260$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHf3rRGqiR9Wt3dE8sqasOj5e4qfgHrY5dMAgTKDrmlm9vvEA==
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tuesday, February 05, 2019 12:40 PM Casey Schaufler wrote:
> On 2/5/2019 10:28 AM, Edwin Zimmerman wrote:
> > On Tuesday, February 05, 2019 12:40 PM Casey Schaufler wrote:
> >...
> > Here's my suggestion for starters. According to kernel documentation, new
> > LSMs must be documented before being accepted.  Perhaps we need a
> > similar requirement for LSM hooks.
> 
> That would be handy. The documentation would need to cover
> the purpose for the hook and how a security module would be
> expected to use it.
> 
> > As I see it, LSMs are security additions,
> > not functionality patches for the rest of the kernel or for special hardware or
> > whatever.  Therefore, I also suggest that all new hooks be implemented in
> > at least two LSMs before being accepted.
> 
> I can't say this makes sense. The binder hooks are only
> useful for Android, and requiring Smack or AppArmor hooks
> be implemented isn't reasonable. It would be reasonable for
> the kernfs hook, as the kernfs hook is a workaround for the
> fact that kernfs doesn't use inodes.

You have a good point there.  I withdraw my "two LSMs" suggestions.

