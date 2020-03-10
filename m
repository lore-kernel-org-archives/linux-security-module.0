Return-Path: <SRS0=JkyI=43=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99626C10F27
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Mar 2020 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716D42146E
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Mar 2020 17:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6GVVaiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCJRMj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:12:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726486AbgCJRMi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Mar 2020 13:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583860358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OC/jw5IZXVx7wZDomW5T/X+1F9FrFuN9wQhaz4Xoo1Y=;
        b=g6GVVaiYE2gDWdeHjamQ/ya0Ok9Z2GXLXbrhgCJVnWi2jMElHHqNR3fCwW1UjR9LP8wJRJ
        bFLBaGjAlOxL6Ms5XTj20npq2FU3rAhU1/RziOcg2+okvXK6Po0BtglOI+cEJgHApXaslm
        zU1xULQnCnz/lIuxUM5QsZcXSqTREpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-7QaVQKJVOA29IpYAOK_8NQ-1; Tue, 10 Mar 2020 13:12:34 -0400
X-MC-Unique: 7QaVQKJVOA29IpYAOK_8NQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25C0B800D48;
        Tue, 10 Mar 2020 17:12:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E11260BF3;
        Tue, 10 Mar 2020 17:12:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <da226448-4b76-0456-4c29-742a1a24fe79@redhat.com>
References: <da226448-4b76-0456-4c29-742a1a24fe79@redhat.com> <20200308170410.14166-3-longman@redhat.com> <20200308170410.14166-1-longman@redhat.com> <416690.1583771540@warthog.procyon.org.uk> <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
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
Content-ID: <675399.1583860343.1@warthog.procyon.org.uk>
Date:   Tue, 10 Mar 2020 17:12:23 +0000
Message-ID: <675400.1583860343@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Waiman Long <longman@redhat.com> wrote:

> That is not as simple as I thought. First of that, there is not an
> equivalent kzvfree() helper to clear the buffer first before clearing.
> Of course, I can do that manually.

Yeah, the actual substance of vfree() may get deferred.  It may be worth
adding a kvzfree() that switches between kzfree() and memset(),vfree().

> With patch 2, the allocated buffer length will be max(1024, keylen). The
> security code uses kmalloc() for allocation. If we use kvalloc() here,
> perhaps we should also use that for allocation that can be potentially
> large like that in big_key. What do you think?

Not for big_key: if it's larger than BIG_KEY_FILE_THRESHOLD (~1KiB) it gets
written encrypted into shmem so that it can be swapped out to disk when not in
use.

However, other cases, sure - just be aware that on a 32-bit system,
vmalloc/vmap space is a strictly limited resource.

David

