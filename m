Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91002C169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 19:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2FD218B0
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBFT0Y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:26:24 -0500
Received: from mail.emypeople.net ([216.220.167.73]:45265 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfBFT0Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 14:26:24 -0500
Received: from Shop7 ([166.182.241.52])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201902061426221154;
        Wed, 06 Feb 2019 14:26:22 -0500
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     <mortonm@chromium.org>, <jmorris@namei.org>, <serge@hallyn.com>,
        <keescook@chromium.org>, <casey@schaufler-ca.com>,
        <sds@tycho.nsa.gov>, <linux-security-module@vger.kernel.org>
References: <CAGXu5jJX5V9H5uWArV93eM9jFzaCO4s3rQPBa6rN0LbKtMj82Q@mail.gmail.com> <20190206190309.247032-1-mortonm@chromium.org>
In-Reply-To: <20190206190309.247032-1-mortonm@chromium.org>
Subject: RE: [PATCH] LSM: SafeSetID: add selftest
Date:   Wed, 6 Feb 2019 14:26:16 -0500
Message-ID: <000101d4be51$d4c07c80$7e417580$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQL6gbrXc7yZ0VRT3iEtrCu8hiB47AIiwg1ko3aJqWA=
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> On Wednesday, February 06, 2019 2:03 PM Micah Morton wrote:
> > This patch adds a selftest for the SafeSetID LSM. The test requires
> > mounting securityfs if it isn't mounted, creating test users in
> > /etc/passwd, and configuring policies for the SafeSetID LSM through
> > writes to securityfs.
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > ---
> > This test is reasonably robust for demonstrating the functionality of
> > the LSM, but is no masterpiece by any means. I'm not totally sure how
> > these tests are used. Are they incorporated into testing frameworks for
> > the Linux kernel that are run regularly or just PoC binaries that sit in
> > this directory more or less as documentation? If its the former, this
> > code probably needs some more cleanup and better organization. Beyond
> > coding style, the test doesn't bother to clean up users that were added
> > in /etc/passwd for testing purposes nor flushes policies that were
> > configured for the LSM relating to those users. Should it?
> 
> No good reason to leave the users, so I would suggest cleaning them up.
> All it would take would be several deluser commands
> in safesetid-test.sh.  Very simple.

