Return-Path: <SRS0=OFt8=5B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319CCC2BB1D
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F9220736
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 11:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5MHYWGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgCPLvE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:51:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59632 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730882AbgCPLvD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Mar 2020 07:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584359463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tryDzo9SohMjPK6GcmpV+7d9g8Sngd5hQyCi5ctTNMA=;
        b=a5MHYWGuyMaD2C5GKLQP9ijHgdGoq9uOV4wqMVOfx55TRkijN0WI6EWi9rookr5GA5ioaj
        nt77shBdLbN9kjyDPzWmARXJjLNx0qeuhBRvAzc3WuVlrRUSqSbXuWxzCf8Cx2Z3QweMw6
        MHPMWzyScxaGiI2dxvq1XBF7xb870dM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-iG6UQSl3NH2zipfAM4M8Sg-1; Mon, 16 Mar 2020 07:50:59 -0400
X-MC-Unique: iG6UQSl3NH2zipfAM4M8Sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A4218B5FAC;
        Mon, 16 Mar 2020 11:50:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B84DE92F83;
        Mon, 16 Mar 2020 11:50:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200313152102.1707-2-longman@redhat.com>
References: <20200313152102.1707-2-longman@redhat.com> <20200313152102.1707-1-longman@redhat.com>
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
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding key semaphore
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1797277.1584359451.1@warthog.procyon.org.uk>
Date:   Mon, 16 Mar 2020 11:50:51 +0000
Message-ID: <1797278.1584359451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Waiman Long <longman@redhat.com> wrote:

>  include/linux/key-type.h                  |  2 +-
>  security/keys/big_key.c                   | 11 ++---
>  security/keys/encrypted-keys/encrypted.c  |  7 ++-
>  security/keys/keyctl.c                    | 57 +++++++++++++++++++----
>  security/keys/keyring.c                   |  6 +--
>  security/keys/request_key_auth.c          |  7 ++-
>  security/keys/trusted-keys/trusted_tpm1.c | 14 +-----
>  security/keys/user_defined.c              |  5 +-
> ...
> -	long (*read)(const struct key *key, char __user *buffer, size_t buflen);
> +	long (*read)(const struct key *key, char *buffer, size_t buflen);

Note that there are read functions outside of security/keys/ that also need
fixing - dns_resolver_read() and rxrpc_read().

David

