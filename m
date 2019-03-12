Return-Path: <SRS0=08hy=RP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5166EC4360F
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 17:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3D3214AE
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 17:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfCLRTq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:19:46 -0400
Received: from namei.org ([65.99.196.166]:56652 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbfCLRTp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Mar 2019 13:19:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2CHJWlo024982;
        Tue, 12 Mar 2019 17:19:32 GMT
Date:   Wed, 13 Mar 2019 04:19:32 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing
 testing.
In-Reply-To: <72b3b8e1-fc34-f312-de12-cf42992bceb8@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1903130418580.24386@namei.org>
References: <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp> <05b05166-d24a-3c50-6556-472f50a239b9@tycho.nsa.gov> <201903042359.x24NxJwx065719@www262.sakura.ne.jp> <alpine.LRH.2.21.1903051431540.20560@namei.org>
 <72b3b8e1-fc34-f312-de12-cf42992bceb8@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 11 Mar 2019, Tetsuo Handa wrote:

> On 2019/03/05 12:32, James Morris wrote:
> > On Tue, 5 Mar 2019, Tetsuo Handa wrote:
> > 
> >> I guess that majority of TOMOYO users are now using the upstream version. But
> >> pre-LSM version and/or AKARI will remain there until LKM-based LSMs becomes
> >> officially supported
> > 
> > You mean dynamically loadable LSMs?
> 
> Yes. As long as upstream can't accept all LSM modules, and some people cannot afford
> utilizing upstream LSM modules, LKM-based LSMs will be needed by such people.

What do you mean cannot afford ?

-- 
James Morris
<jmorris@namei.org>

