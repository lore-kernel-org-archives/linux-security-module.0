Return-Path: <SRS0=elJ9=XU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7CC432C2
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Sep 2019 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C62421D7E
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Sep 2019 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569423297;
	bh=ufDqngKJheA3l0EFHLMClCKQHtuH325dj1as7X9Pcaw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=is94SgWiVc+vupSe6QQCspDTmB1dhNTE/9cnw7wmq8Ly+Do8fpGex+o8gsxsv15um
	 NTMxhsEXJ2E8w2d38hjOxCIWwOZI0aPhMNtNlISCgpJZl7eCSSUuIGM0wrmejFFHsX
	 o9UlF0v61j0dw/2uyd8Bs/2Ha4BYDBqJWoLJ+X9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfIYOy5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbfIYOy4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Sep 2019 10:54:56 -0400
Received: from [10.33.87.18] (twin.jikos.cz [91.219.245.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86DAD21D7C;
        Wed, 25 Sep 2019 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569423296;
        bh=ufDqngKJheA3l0EFHLMClCKQHtuH325dj1as7X9Pcaw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UpTCUFrrg/Ujrshxgdzvr0Te+irMSosPMxL6RL0SRyOWZVB98yD2whLjFxhPsdIQu
         EebKZFr5ghPEa884wa3dZJq5JU8B3JiBgIa3H/pxHWhKM0m+g/lBvC9tNLyiCn2vSV
         kPlDy2nO8j4AsVIznfSXDw9BGAH5FX0XPA+eCZyI=
Date:   Wed, 25 Sep 2019 16:54:41 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     James Morris <jmorris@namei.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
In-Reply-To: <alpine.LRH.2.21.1909101402230.20291@namei.org>
Message-ID: <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
References: <alpine.LRH.2.21.1909101402230.20291@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 10 Sep 2019, James Morris wrote:

> Hi Linus,
> 
> This is the latest iteration of the kernel lockdown patchset, from Matthew 
> Garrett, David Howells and others.

Seems like this didn't happen (yet) ... are there any plans to either drop 
it for good, or merge it?

Thanks,

-- 
Jiri Kosina
SUSE Labs
