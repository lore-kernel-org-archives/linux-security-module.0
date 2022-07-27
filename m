Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1399DC04A68
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Jul 2022 14:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiG0OPy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiG0OPx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Jul 2022 10:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32054C41
        for <linux-security-module@vger.kernel.org>; Wed, 27 Jul 2022 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658931352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QYsymPVFJo3O+ziC8Rns52VMfmhJdvrDvuyq6hpEFA=;
        b=X2Vi9cu2iCqO7gFwmEZazFFHoRtT0Ewus84h913f4Zy+k4nTkTrFt0H3cAjymQ4Mgjfd+R
        wFhS1U//3PxwrZbKmjThoOcSJG0lTezQSA70De2FFGGoo0JpQ2wWND59ulH22p5ld9Z1fl
        8IqIw2afCrQrmLJFkft/Ga2IbkMlx94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-6yZ7Bd0hPCq85Qt39pAabQ-1; Wed, 27 Jul 2022 10:15:46 -0400
X-MC-Unique: 6yZ7Bd0hPCq85Qt39pAabQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A86C9185A7A4;
        Wed, 27 Jul 2022 14:15:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94E6B1121314;
        Wed, 27 Jul 2022 14:15:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220723135447.199557-1-code@siddh.me>
References: <20220723135447.199557-1-code@siddh.me>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     dhowells@redhat.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3473428.1658931342.1@warthog.procyon.org.uk>
Date:   Wed, 27 Jul 2022 15:15:42 +0100
Message-ID: <3473429.1658931342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Siddh Raman Pant <code@siddh.me> wrote:

> +++ b/kernel/watch_queue.c
> ...
>+#ifdef CONFIG_WATCH_QUEUE

But it says:

obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o

in the Makefile.

David

