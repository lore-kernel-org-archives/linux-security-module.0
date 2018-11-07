Return-Path: <SRS0=u7jB=NS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B869EC0044C
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Nov 2018 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8846A20862
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Nov 2018 16:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8846A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbeKHCQd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:16:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeKHCQd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Nov 2018 21:16:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90809C0587D2;
        Wed,  7 Nov 2018 16:45:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5405D604A1;
        Wed,  7 Nov 2018 16:45:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1541603281.3928.2.camel@linux.ibm.com>
References: <1541603281.3928.2.camel@linux.ibm.com> <13898.1541601730@warthog.procyon.org.uk>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dhowells@redhat.com, Denis Kenzior <denkenz@gmail.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        mtk.manpages@gmail.com
Subject: Re: [KEYUTILS PATCH] Add manpages for asymmetric key type and ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23207.1541609120.1@warthog.procyon.org.uk>
Date:   Wed, 07 Nov 2018 16:45:20 +0000
Message-ID: <23208.1541609120@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 07 Nov 2018 16:45:24 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Mimi Zohar <zohar@linux.ibm.com> wrote:

> After cloning the man pages*, I'm having troubles applying this patch.
>  Any suggestions?

"[KEYUTILS PATCH]" might be a blatant clue ;-)

David
