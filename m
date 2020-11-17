Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D096C63697
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 16:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9E9221FC
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Nov 2020 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgKQQqM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:46:12 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:43042 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgKQQqM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Nov 2020 11:46:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 165D82049A;
        Tue, 17 Nov 2020 17:46:10 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BGDgXLeYVnPe; Tue, 17 Nov 2020 17:46:09 +0100 (CET)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 9C05D20185;
        Tue, 17 Nov 2020 17:46:09 +0100 (CET)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 17 Nov 2020 17:46:09 +0100
Received: from moon.secunet.de (172.18.26.121) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 17 Nov
 2020 17:46:08 +0100
Date:   Tue, 17 Nov 2020 17:46:07 +0100
From:   Antony Antony <antony.antony@secunet.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
CC:     Antony Antony <antony.antony@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Antony Antony <antony@phenome.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH] xfrm: redact SA secret with lockdown confidentiality
Message-ID: <20201117164607.GB19892@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20200728154342.GA31835@moon.secunet.de>
 <20201016133352.GA2338@moon.secunet.de>
 <20201031104911.GO27824@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201031104911.GO27824@gauss3.secunet.de>
Organization: secunet
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Oct 31, 2020 at 11:49:11 +0100, Steffen Klassert wrote:
> On Fri, Oct 16, 2020 at 03:36:12PM +0200, Antony Antony wrote:
> > redact XFRM SA secret in the netlink response to xfrm_get_sa()
> > or dumpall sa.
> > Enable this at build time and set kernel lockdown to confidentiality.
> 
> Wouldn't it be better to enable is at boot or runtime? This defaults
> to 'No' at build time, so distibutions will not compile it in. That
> means that noone who uses a kernel that comes with a Linux distribution
> can use that.

It is a good idea. I will send new version soon.

thanks,
-antony
