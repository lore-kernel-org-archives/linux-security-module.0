Return-Path: <SRS0=c21G=UL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D50DC31E48
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09AD208C2
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfFLU5A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:57:00 -0400
Received: from namei.org ([65.99.196.166]:38722 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390632AbfFLU5A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Jun 2019 16:57:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5CKtd4g002257;
        Wed, 12 Jun 2019 20:55:39 GMT
Date:   Thu, 13 Jun 2019 06:55:39 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Janne Karhunen <janne.karhunen@gmail.com>
cc:     sds@tycho.nsa.gov, paul@paul-moore.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] LSM: switch to blocking policy update notifiers
In-Reply-To: <20190612074456.2504-1-janne.karhunen@gmail.com>
Message-ID: <alpine.LRH.2.21.1906130655140.1778@namei.org>
References: <20190612074456.2504-1-janne.karhunen@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 12 Jun 2019, Janne Karhunen wrote:

> Atomic policy updaters are not very useful as they cannot
> usually perform the policy updates on their own. Since it
> seems that there is no strict need for the atomicity,
> switch to the blocking variant. While doing so, rename
> the functions accordingly.
> 
> Changelog v2
> - Rebase to 'next-queued-testing'
> 
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> Acked-by: Paul Moore <paul@paul-moore.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>

