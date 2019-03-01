Return-Path: <SRS0=EupR=RE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAA1C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D324E2084D
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfCARyE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:54:04 -0500
Received: from namei.org ([65.99.196.166]:55008 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbfCARyE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Mar 2019 12:54:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x21Hs0JM017452;
        Fri, 1 Mar 2019 17:54:00 GMT
Date:   Sat, 2 Mar 2019 04:54:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Petr Vorel <pvorel@suse.cz>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: Update list of SECURITYFS users in Kconfig
In-Reply-To: <20190228235448.14279-1-pvorel@suse.cz>
Message-ID: <alpine.LRH.2.21.1903020453510.17236@namei.org>
References: <20190228235448.14279-1-pvorel@suse.cz>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 1 Mar 2019, Petr Vorel wrote:

> + Remove modules not using it (SELinux and SMACK aren't
> the only ones not using it).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

