Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B57C46467
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Jan 2023 18:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjAKSVg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Jan 2023 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjAKSVP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Jan 2023 13:21:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040E1EEC2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jan 2023 10:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673461228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T37CrOqOXpI4z+GZ/E4PVC5qfTmSIj95zZprjxSan00=;
        b=Lsfkh4H91uFMTVesgy9Fpz2zcQ/ocdFK/0gMGaAxNxeDWaMRnz7vhNmiiSHB+BoNh8dhq7
        4B4FIHsPggZTNNJFkATMminwMZofFHbfN1cyquIZvXvRF6OJre1HcA2dzxIwY0rcuKrPUl
        04IkZ6mrtJF8WRj6cYr6qK2QmDUy+F4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-ahchqIz4Mb-XMmMJ4KZAuA-1; Wed, 11 Jan 2023 13:20:23 -0500
X-MC-Unique: ahchqIz4Mb-XMmMJ4KZAuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86088857F82;
        Wed, 11 Jan 2023 18:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09245422A9;
        Wed, 11 Jan 2023 18:20:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <185a206e3b0.2e1071428037.6356107010427889199@siddh.me>
References: <185a206e3b0.2e1071428037.6356107010427889199@siddh.me> <20230111161934.336743-1-code@siddh.me> <2433039.1673455048@warthog.procyon.org.uk>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     dhowells@redhat.com, "mauro carvalho chehab" <mchehab@kernel.org>,
        "randy dunlap" <rdunlap@infradead.org>,
        "jonathan corbet" <corbet@lwn.net>,
        "fabio m. de francesco" <fmdefrancesco@gmail.com>,
        "eric dumazet" <edumazet@google.com>,
        "christophe jaillet" <christophe.jaillet@wanadoo.fr>,
        "eric biggers" <ebiggers@kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2438919.1673461220.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 18:20:20 +0000
Message-ID: <2438920.1673461220@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Siddh Raman Pant <code@siddh.me> wrote:

> All tests in tests/ pass except features/builtin_trusted, which
> fails even without the patch. (Failure log: https://pastebin.com/SGgAbzXp)

Don't worry about that one.  That requires some kernel preparation.

David

