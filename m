Return-Path: <SRS0=3gqt=6F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AB0C54FC9
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Apr 2020 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DD12068F
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Apr 2020 15:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUPRv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:17:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:57374 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUPRu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Apr 2020 11:17:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 389B2823;
        Tue, 21 Apr 2020 15:17:50 +0000 (UTC)
Date:   Tue, 21 Apr 2020 09:17:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH RFC] Documentation: LSM: Correct the basic LSM
 description
Message-ID: <20200421091749.20594692@lwn.net>
In-Reply-To: <3d5970b8-f95a-2f15-851a-472cbceb94d4@schaufler-ca.com>
References: <3d5970b8-f95a-2f15-851a-472cbceb94d4.ref@schaufler-ca.com>
        <3d5970b8-f95a-2f15-851a-472cbceb94d4@schaufler-ca.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 20 Apr 2020 17:02:41 -0700
Casey Schaufler <casey@schaufler-ca.com> wrote:

> This is a first pass at updating the basic documentation on
> Linux Security Modules (LSM), which is frighteningly out of date.
> Remove untrue statements about the LSM framework. Replace them
> with true statements where it is convenient to do so. This is
> the beginning of a larger effort to bring the LSM documentation
> up to date.

Seems like a good set of changes overall.  One small nit...

> +The LSM framework provides for a close approximation of
> +general security module stacking. It defines
> +:c:func:`security_add_hooks()` to which each security module passes a
> +:c:type:`struct security_hooks_list <security_hooks_list>`,
> +which are added to the lists.
> +The LSM framework does not provide a mechanism for removing hooks that
> +have been registered. An individual security module chose to implement
> +such a mechanism, but the safety of such a mechanism is in no way
> +guaranteed by the framework.

There is no need for :c:func: anymore; just say security_add_hooks() and
the Right Thing™ will happen.  It would be good to take all of those out
while you're thrashing up the file.

I really need to get back and do the same thing for :c:type: ...

Thanks,

jon
