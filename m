Return-Path: <SRS0=X76I=VJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B5C742D2
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Jul 2019 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155582080A
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Jul 2019 17:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGLRPG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:15:06 -0400
Received: from namei.org ([65.99.196.166]:34868 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfGLRPG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jul 2019 13:15:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6CHF5Ym032547;
        Fri, 12 Jul 2019 17:15:05 GMT
Date:   Sat, 13 Jul 2019 03:15:05 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] LSM: Update MAINTAINERS file for SafeSetID LSM.
In-Reply-To: <CAJ-EccPo2T6y=7Gw-naPZ4d25em+8TsZMSXp4C=pGeTutbPqZA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1907130314410.32193@namei.org>
References: <20190522172241.192669-1-mortonm@chromium.org> <alpine.LRH.2.21.1905230341520.18826@namei.org> <CAJ-EccPo2T6y=7Gw-naPZ4d25em+8TsZMSXp4C=pGeTutbPqZA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 12 Jul 2019, Micah Morton wrote:

> Hi James,
> 
> Are we still merging this kind of thing through your tree?
> 
> Or does it make more sense for me to send this through my tree when I
> get one up and running?

Send it via your tree with my acked-by.

-- 
James Morris
<jmorris@namei.org>

