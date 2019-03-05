Return-Path: <SRS0=jfU4=RI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8781BC43381
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594A220663
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Mar 2019 07:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfCEHl5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:41:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfCEHl5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Mar 2019 02:41:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07BB6307D933;
        Tue,  5 Mar 2019 07:41:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70CC0608C8;
        Tue,  5 Mar 2019 07:41:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
References: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] keys: fix missing __user in KEYCTL_PKEY_QUERY
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29869.1551771714.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 05 Mar 2019 07:41:54 +0000
Message-ID: <29870.1551771714@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 05 Mar 2019 07:41:57 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The arg5 of KEYCTL_PKEY_QUERY should have a __user pointer tag on
> it as it is a user pointer. This clears the following sparse warning
> for this:
> 
> security/keys/keyctl.c:1755:43: warning: incorrect type in argument 3 (different address spaces)
> security/keys/keyctl.c:1755:43:    expected struct keyctl_pkey_query [noderef] <asn:1>*<noident>
> security/keys/keyctl.c:1755:43:    got struct keyctl_pkey_query *<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: David Howells <dhowells@redhat.com>
