Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A5DC5479D
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Jan 2023 16:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjAKQjx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjAKQj3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Jan 2023 11:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F53C0D5
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jan 2023 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673455055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHPyRkuvGfwyKEOErHELa1P/OPjmiNQyTexePaNaATA=;
        b=ePJQ0w2YmpuRKEwmmHwb7Sv8XoIMBqk/VDrx/fbhXf3Uj1jPYQ3gaHwHYISHuLsDF7ckah
        ZyeRdP7wOSnaNlJtSJj4ZBv89iw9Ph0yvu2AMSksorIONZu5mT1LVoPCtPPEJZAtd3SfdW
        RccvB+dldgyvLV0n5EDoNnlRgtftctc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-yQBa-YYDNyO7fADi4QaRtA-1; Wed, 11 Jan 2023 11:37:31 -0500
X-MC-Unique: yQBa-YYDNyO7fADi4QaRtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00AC8100F910;
        Wed, 11 Jan 2023 16:37:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CDFB2026D68;
        Wed, 11 Jan 2023 16:37:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230111161934.336743-1-code@siddh.me>
References: <20230111161934.336743-1-code@siddh.me>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     dhowells@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Biggers <ebiggers@kernel.org>,
        keyrings <keyrings@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2433038.1673455048.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 16:37:28 +0000
Message-ID: <2433039.1673455048@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Seems reasonable.  Have you run it with the keyutils testsuite?

David

