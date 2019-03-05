Return-Path: <SRS0=jfU4=RI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F838C43381
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 03:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745D720684
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 03:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfCEDa5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:30:57 -0500
Received: from namei.org ([65.99.196.166]:55446 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfCEDa5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Mar 2019 22:30:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x253UnBS000575;
        Tue, 5 Mar 2019 03:30:49 GMT
Date:   Tue, 5 Mar 2019 14:30:49 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] LSM: SafeSetID: gate setgid transitions
In-Reply-To: <CAJ-EccMu97tZCWXTakcTwqFwzXdzVDedgc3jWaRvaJu-duH6tQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1903051429300.20560@namei.org>
References: <5552a810-8072-e0fe-4a4c-76f937f0c3f4@schaufler-ca.com> <20190228235534.248869-1-mortonm@chromium.org> <CAJ-EccMu97tZCWXTakcTwqFwzXdzVDedgc3jWaRvaJu-duH6tQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 4 Mar 2019, Micah Morton wrote:

> > +       case LSM_SETGID_RE:
> > +                break;
> > +       case LSM_SETGID_ID:
> > +                break;
> > +       case LSM_SETGID_RES:
> > +                break;
> > +       case LSM_SETGID_FS:
> > +                break;
> > +

These should be collapsed into multiple case statements with one break.

Also, please start a new thread when you post a new version of the 
patchset, and include all of the series in each version.


-- 
James Morris
<jmorris@namei.org>

