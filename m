Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECC5C433EF
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Oct 2021 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267B961A8E
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Oct 2021 23:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhJAXqs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Oct 2021 19:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhJAXqr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Oct 2021 19:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65EAF61A8D;
        Fri,  1 Oct 2021 23:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633131902;
        bh=AKHrIZMYuBVUUCrpaF2xXGBGsiDT4PbE1eXqYrs9BVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZgUlNjw1uaqj48ezhzTaBCoA7KtZWxJNsfUTm9tCuoBb4cC85ZQzzOpTbGf35LWR
         lCXwD+kEgBNXSSrLXNHYhau+PCdYRRPS3qW5ka9JIwzp2aGYFYYW1KMnUbNY7Zv8+L
         NxAWB4/G6XYSDu4Csf2Jk/v+nyLCy3IkKOOsQ0j1emGzMqhCI4VvJRh94d3ZJz1Eit
         Brg06P3AYcDM71nBp6CV0X74momfYABuD8RzcuCHU5lTgm74qyieSs4Cjd5zQjLuCm
         Vgh/xB+HV37AeMDkGStnRdNZPk9Sosw65HZPHCVuS3AYex4QmVHCgGnNsmIR8Bda6D
         UE3JlpjjYRPxw==
Date:   Fri, 1 Oct 2021 18:49:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] apparmor: Use struct_size() helper in kzalloc()
Message-ID: <20211001234912.GA1055815@embeddedor>
References: <20210929220526.GA355783@embeddedor>
 <4c851990-45d7-a0ff-e398-92ecb2454242@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c851990-45d7-a0ff-e398-92ecb2454242@canonical.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 01, 2021 at 04:37:08PM -0700, John Johansen wrote:
> On 9/29/21 3:05 PM, Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version,
> > in order to avoid any potential type mistakes or integer overflows that,
> > in the worse scenario, could lead to heap overflows.
> >> Link: https://github.com/KSPP/linux/issues/160
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> nice
> 
> I will pull this into my tree
> Acked-by: John Johansen <john.johansen@canonical.com>

Thanks, John.

--
Gustavo
