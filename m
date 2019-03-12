Return-Path: <SRS0=08hy=RP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6460AC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 21:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE262077B
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 21:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCLV4N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:56:13 -0400
Received: from mail.emypeople.net ([216.220.167.73]:35859 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfCLV4N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Mar 2019 17:56:13 -0400
Received: from Shop7 ([166.182.241.52])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201903121756114562;
        Tue, 12 Mar 2019 17:56:11 -0400
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Tetsuo Handa'" <penguin-kernel@i-love.sakura.ne.jp>,
        "'James Morris'" <jmorris@namei.org>
Cc:     "'Stephen Smalley'" <sds@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>
References: <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp> <05b05166-d24a-3c50-6556-472f50a239b9@tycho.nsa.gov> <201903042359.x24NxJwx065719@www262.sakura.ne.jp> <alpine.LRH.2.21.1903051431540.20560@namei.org> <72b3b8e1-fc34-f312-de12-cf42992bceb8@i-love.sakura.ne.jp> <alpine.LRH.2.21.1903130418580.24386@namei.org> <770d8413-bd57-c379-21a0-acbbdf82241e@i-love.sakura.ne.jp>
In-Reply-To: <770d8413-bd57-c379-21a0-acbbdf82241e@i-love.sakura.ne.jp>
Subject: RE: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
Date:   Tue, 12 Mar 2019 17:56:11 -0400
Message-ID: <000001d4d91e$68837940$398a6bc0$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIPt+/UqAbtGNbIBgaXMEltXftg9ADxzK23AfRcjK8B5beAvgK2haGGArxoFxEB09qhqqUyN2vw
Content-Language: en-us
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On March 12, 2019 5:15, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote
> On 2019/03/13 2:19, James Morris wrote:
> > On Mon, 11 Mar 2019, Tetsuo Handa wrote:
> >
> >> On 2019/03/05 12:32, James Morris wrote:
> >>> On Tue, 5 Mar 2019, Tetsuo Handa wrote:
> >>>
> >>>> I guess that majority of TOMOYO users are now using the upstream version. But
> >>>> pre-LSM version and/or AKARI will remain there until LKM-based LSMs becomes
> >>>> officially supported
> >>>
> >>> You mean dynamically loadable LSMs?
> >>
> >> Yes. As long as upstream can't accept all LSM modules, and some people cannot afford
> >> utilizing upstream LSM modules, LKM-based LSMs will be needed by such people.
> >
> > What do you mean cannot afford ?
> >
> 
> Some people have to set SELINUX=disabled in /etc/selinux/config or pass security=none from
> the kernel command line.

If you specifically don't want in-kernel LSMs, and you specifically do want an out-of-tree LSM,
there are other options. For example, you could just livepatch the security_* hooks you need, 
since you already would using an LKM-based LSM.  That would give you your
out-of-tree module and would also disable selinux on the hooks that got livepatched.

