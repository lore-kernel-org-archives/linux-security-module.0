Return-Path: <SRS0=jfU4=RI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D95C43381
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 03:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB73020684
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 03:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfCED2a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:28:30 -0500
Received: from namei.org ([65.99.196.166]:55432 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfCED2a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Mar 2019 22:28:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x253S7qQ000471;
        Tue, 5 Mar 2019 03:28:08 GMT
Date:   Tue, 5 Mar 2019 14:28:07 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        dhowells@redhat.com, serge@hallyn.com,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] keys: fix missing __user in KEYCTL_PKEY_QUERY
In-Reply-To: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
Message-ID: <alpine.LRH.2.21.1903051427590.20560@namei.org>
References: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 1 Mar 2019, Ben Dooks wrote:

> The arg5 of KEYCTL_PKEY_QUERY should have a __user pointer tag on
> it as it is a user pointer. This clears the following sparse warning
> for this:
> 
> security/keys/keyctl.c:1755:43: warning: incorrect type in argument 3 (different address spaces)
> security/keys/keyctl.c:1755:43:    expected struct keyctl_pkey_query [noderef] <asn:1>*<noident>
> security/keys/keyctl.c:1755:43:    got struct keyctl_pkey_query *<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

