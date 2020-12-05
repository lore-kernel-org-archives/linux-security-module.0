Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2654C433FE
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Dec 2020 00:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F8922D6E
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Dec 2020 00:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgLEA2y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:28:54 -0500
Received: from namei.org ([65.99.196.166]:58252 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLEA2y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Dec 2020 19:28:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0B50RwPI025632;
        Sat, 5 Dec 2020 00:27:58 GMT
Date:   Sat, 5 Dec 2020 11:27:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Andrew G. Morgan" <morgan@kernel.org>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Herv=E9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
In-Reply-To: <CALQRfL6OQKuBqbUoC7_yH7W4qabYSamRYUqjM-HE1gj2r_CaHQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2012051127160.23731@namei.org>
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL6q8ppuWi3ygY6iqh6SX9pnkVnvJDynTD61K2wUqerahg@mail.gmail.com> <20201129211542.GA5227@mail.hallyn.com> <alpine.LRH.2.21.2012011358200.28022@namei.org>
 <CALQRfL6OQKuBqbUoC7_yH7W4qabYSamRYUqjM-HE1gj2r_CaHQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 4 Dec 2020, Andrew G. Morgan wrote:

> The correct bug reference for this patch is:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=209689
> 
> Reviewed-by: Andrew G. Morgan <morgan@kernel.org>

Thanks.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-5.10
and next-testing


-- 
James Morris
<jmorris@namei.org>

