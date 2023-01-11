Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D3EC54EBC
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Jan 2023 15:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbjAKPtz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbjAKPt1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Jan 2023 10:49:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8027C34D5D
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jan 2023 07:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673452091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlR7fmjkyGH/tQKKBvJIkjgsqihiwiQFnkoLokXqB0M=;
        b=PA6cce/1sbRWgC8cG3lH/5BcEl5EdRXMveSv35AuPTanon3B61qLFMbtkPi34WmyNwXeJq
        ClQNFlzQbZhXX0EQ2Bf+FIiubLcoPxMUiF1Gc+QeZguJblT7RxSDllLmbwCsOPOslF9qzo
        1hc1geJBG6EpzoaS5JkmvxWffyqpUK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-dHKN7Bk5MieQeWCzeEE6pQ-1; Wed, 11 Jan 2023 10:48:08 -0500
X-MC-Unique: dHKN7Bk5MieQeWCzeEE6pQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B9A802D1B;
        Wed, 11 Jan 2023 15:48:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408EC140EBF4;
        Wed, 11 Jan 2023 15:48:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1859d17668d.7b9d5469421579.5464668634216421773@siddh.me>
References: <1859d17668d.7b9d5469421579.5464668634216421773@siddh.me> <97ce37e2fdcfbed29d9467057f0f870359d88b89.1673173920.git.code@siddh.me> <cover.1673173920.git.code@siddh.me> <2121105.1673359772@warthog.procyon.org.uk>
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
Subject: Re: [PATCH v3 1/2] include/linux/watch_queue: Improve documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2430912.1673452085.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 15:48:05 +0000
Message-ID: <2430913.1673452085@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Siddh Raman Pant <code@siddh.me> wrote:

> But what about the second patch? Should I send that without these doc
> changes?

Can you repost it without the first patch being present?

David

