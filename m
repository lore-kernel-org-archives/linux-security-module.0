Return-Path: <SRS0=bSrl=3U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB842C2D0DB
	for <linux-security-module@archiver.kernel.org>; Fri, 31 Jan 2020 17:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CE2206D5
	for <linux-security-module@archiver.kernel.org>; Fri, 31 Jan 2020 17:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD2Ua07i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgAaRTz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:19:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgAaRTz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 Jan 2020 12:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580491194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJ6ZXnCZlySRaLqFHO5kcXQrkfWEiHgSHgDYrdwchj8=;
        b=dD2Ua07iXw0BAUmWXsddrqv2OQ70slHTynLg/6W12nVBhkT/iH2R4mo7KvBKlw8rHE40Ah
        SuQ5rMp+oWU6wokcLq1tXY/F5jnaeET69mgZR4dMcfmkuPXrQshPCcN/cynfDy6L5Y0rWB
        ZX2Q+h6FqzKZCHa3bOksJCHSOc5LFhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-2qhknmQBO7i3fxsuzot7rg-1; Fri, 31 Jan 2020 12:19:44 -0500
X-MC-Unique: 2qhknmQBO7i3fxsuzot7rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F52F100550E;
        Fri, 31 Jan 2020 17:19:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF305DD64;
        Fri, 31 Jan 2020 17:19:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <22307ecd-3254-6077-8bc7-02693338b586@virtuozzo.com>
References: <22307ecd-3254-6077-8bc7-02693338b586@virtuozzo.com> <eaacb0b2-fd0d-480e-1868-0a1284c20185@virtuozzo.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2] keys: proc_keys_next should increase position index
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <265150.1580491178.1@warthog.procyon.org.uk>
Date:   Fri, 31 Jan 2020 17:19:38 +0000
Message-ID: <265151.1580491178@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Vasily Averin <vvs@virtuozzo.com> wrote:

> If seq_file .next fuction does not change position index,

"function"

>    <<<< and whole last lien again

"line"

I can fix these up for you.

> https://bugzilla.kernel.org/show_bug.cgi?id=206283

I wonder if this should have a tag - it looks kind of out of place without
one, but I can't find one suggested.

David

