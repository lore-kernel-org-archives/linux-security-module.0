Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE860C5519F
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 03:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BC322256
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 03:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKTDUG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:20:06 -0500
Received: from namei.org ([65.99.196.166]:54384 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKTDUF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Nov 2020 22:20:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AK3JwlO021317;
        Fri, 20 Nov 2020 03:19:58 GMT
Date:   Fri, 20 Nov 2020 14:19:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Andrew G. Morgan" <morgan@kernel.org>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Herv=E9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
In-Reply-To: <CALQRfL5UzUt0YkKDAguETmdXM7qsPC9sGmsgutQ-P2cymPte-w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2011201419210.20300@namei.org>
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL5UzUt0YkKDAguETmdXM7qsPC9sGmsgutQ-P2cymPte-w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 17 Nov 2020, Andrew G. Morgan wrote:

> Signed-off-by: Andrew G. Morgan <morgan@kernel.org>

This should be Acked-by or Reviewed-by, unless this is your patch, or it 
came via your tree.


-- 
James Morris
<jmorris@namei.org>

