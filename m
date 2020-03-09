Return-Path: <SRS0=zxnP=42=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CED2C18E5A
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Mar 2020 16:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F2B2253D
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Mar 2020 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3UQGNx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCIQcd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:32:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34744 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727032AbgCIQcc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Mar 2020 12:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583771551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DicN/KVmQyAyPa1SQbJC+P87YoIa/d9bIovLTJ1t7DI=;
        b=g3UQGNx1LqG38mB+K+cZW9qGpY++L8EtjcLxR+aOCkw4DSBT1v3zdOZBEFzW5w6B/+3Ro7
        vW2TWlm85Ox0HjYuznM81DJdtMAhZt7gTBMa9qfY5Ws1Y61gYpt1BYGx5GWvgBXR1qDM4I
        k2O5LXD5e2kgOPqRSU1gEgbSTxlgvXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-BiyeUVPKNm-Kw84GfhRoxQ-1; Mon, 09 Mar 2020 12:32:29 -0400
X-MC-Unique: BiyeUVPKNm-Kw84GfhRoxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97A051088384;
        Mon,  9 Mar 2020 16:32:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5A539051C;
        Mon,  9 Mar 2020 16:32:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200308170410.14166-3-longman@redhat.com>
References: <20200308170410.14166-3-longman@redhat.com> <20200308170410.14166-1-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <416689.1583771540.1@warthog.procyon.org.uk>
Date:   Mon, 09 Mar 2020 16:32:20 +0000
Message-ID: <416690.1583771540@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Waiman Long <longman@redhat.com> wrote:

> +			tmpbuf = kmalloc(tbuflen, GFP_KERNEL);

This would probably be better off using kvmalloc() - otherwise big objects
have to be constructed from runs of contiguous pages.  But since all we're
doing is buffering for userspace, we don't care about that.

If you agree, we can address it with an additional patch.

David

