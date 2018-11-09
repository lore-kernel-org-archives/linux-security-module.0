Return-Path: <SRS0=fuo0=NU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF650C0044C
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E3820825
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 15:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E3820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeKJArS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:47:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbeKJArS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Nov 2018 19:47:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE18C3082A30;
        Fri,  9 Nov 2018 15:06:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7220A5D738;
        Fri,  9 Nov 2018 15:06:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1541772875.3990.29.camel@linux.ibm.com>
References: <1541772875.3990.29.camel@linux.ibm.com> <1541743166-5036-1-git-send-email-zohar@linux.ibm.com> <27927.1541769383@warthog.procyon.org.uk>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] KEYS: revert requiring signature "encoding"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20421.1541775978.1@warthog.procyon.org.uk>
Date:   Fri, 09 Nov 2018 15:06:18 +0000
Message-ID: <20422.1541775978@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 09 Nov 2018 15:06:21 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

And can you cc: Denis Kenzior <denkenz@gmail.com> too?

David
