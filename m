Return-Path: <SRS0=1b+D=5V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B7C2BA19
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Apr 2020 09:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072E220675
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Apr 2020 09:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEw9MR1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDEJEA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Apr 2020 05:04:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726308AbgDEJEA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Apr 2020 05:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586077439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRL0Uyd6AdEG1TYouQC+LIcNPbvfldHHxdImooUbNU8=;
        b=hEw9MR1mCJnkGILKQbCp6jsi0yLoFg92c1qHCfUeh2Ht6Ue+hgqtpcLhvh4/VIaQKWa7Cw
        8rVoeu1Ty6lTq5PRkss0VRSXu6gxyPdbOcFwgBnA2+IeK02c9cHz/Z5ZFw+qIo49dPndTE
        AC3a2GcuAevVaTIRmk7LPwu6w2tQ5rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-mpbKV-gPP1i9TVJFj_N8oA-1; Sun, 05 Apr 2020 05:03:57 -0400
X-MC-Unique: mpbKV-gPP1i9TVJFj_N8oA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BEE2477;
        Sun,  5 Apr 2020 09:03:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD19B118F39;
        Sun,  5 Apr 2020 09:03:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com>
References: <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com> <1437197.1585570598@warthog.procyon.org.uk> <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
To:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3567368.1586077430.1@warthog.procyon.org.uk>
Date:   Sun, 05 Apr 2020 10:03:50 +0100
Message-ID: <3567369.1586077430@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Waiman Long <longman@redhat.com> wrote:

> > And yes, kzfree() isn't a good name either, and had that same
> > memset(), but at least it doesn't do the dual-underscore mistake.
> >
> > Including some kzfree()/crypto people explicitly - I hope we can get
> > away from this incorrect and actively wrong pattern of thinking that
> > "sensitive data should be memset(), and then we should add a random
> > 'z' in the name somewhere to 'document' that".
> >
> >                Linus
> >
> Thanks for the suggestion, I will post a patch to rename the function to
> kvzfree_explicit() and use memzero_explicit() for clearing memory.

Should this be moved into core code, rather than being squirrelled away in
security/keys/?

David

