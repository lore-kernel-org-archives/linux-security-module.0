Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C9AC04A68
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Jul 2022 14:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiG0OtW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiG0OtV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Jul 2022 10:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5E693FA16
        for <linux-security-module@vger.kernel.org>; Wed, 27 Jul 2022 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658933360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pr0XffMgM0PbydBzrF3k1K/HGVzJTnmqlVyn8cjx5NE=;
        b=Fz0PgOY+vTH1TKrLdv79X8XtDPEYwGzrIf/q+3hQuAIc6bTjskKzdOcdAXdIigEfUitiQu
        YT2wbWnv7yas5/V9/TtdCPuuDfiK//uio6gMezlnI/K5mTjigIDVCGtO+G3qlCLUFqGYH5
        a+ZAnsyGAHlkRbeqgQtKaqZ6zmT+qwA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-4S3EawaGOK6EetPWgEohYw-1; Wed, 27 Jul 2022 10:49:18 -0400
X-MC-Unique: 4S3EawaGOK6EetPWgEohYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2FA285A581;
        Wed, 27 Jul 2022 14:49:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF9AC33AE6;
        Wed, 27 Jul 2022 14:49:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220724071958.2557-1-hdanton@sina.com>
References: <20220724071958.2557-1-hdanton@sina.com> <20220724052426.2504-1-hdanton@sina.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com, Siddh Raman Pant <code@siddh.me>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH v2] kernel/watch_queue: Make pipe NULL while clearing watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3565219.1658933355.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 27 Jul 2022 15:49:15 +0100
Message-ID: <3565221.1658933355@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hillf Danton <hdanton@sina.com> wrote:

> Yes, you are right. I missed 353f7988dd84 ("watchqueue: make sure to ser=
ialize
> 'wqueue->defunct' properly"). Sorry for my noise.
> =

> Given defunct serialized, still need to clear wqueue->pipe in the clear
> path as proposed?

In fact, with the locking, is wqueue->defunct even still needed, I wonder?

David

