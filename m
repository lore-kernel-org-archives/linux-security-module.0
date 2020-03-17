Return-Path: <SRS0=p1dC=5C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70392C1975A
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Mar 2020 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462F82073E
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Mar 2020 18:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPmbsPFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgCQSKB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:10:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35143 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgCQSKB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Mar 2020 14:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584468600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g8ghW4p3mVYyvRQJA9R6SCfOZIEGrtXnAJnyhri2nak=;
        b=CPmbsPFEqFP/q5FL8bbgst2VbClKZkMrF5NsUmq7fqBp+p1bZTIDII4wHHoqsaYobhEXWY
        4fnZoVp9lMa/u2wVMTjwe1eit0Tkic24IDpzR+tSFGXTOPPpyzE7WYBsS/rRLb0cC3OCCC
        zrntVqm1CeJjlU7usf5SoRWUyuhioBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-6dx5OgrdMoywh3MbvXA60g-1; Tue, 17 Mar 2020 14:09:59 -0400
X-MC-Unique: 6dx5OgrdMoywh3MbvXA60g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 758B2107ACC4;
        Tue, 17 Mar 2020 18:09:56 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-15.rdu2.redhat.com [10.10.115.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8D7760BE0;
        Tue, 17 Mar 2020 18:09:53 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding
 key semaphore
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
References: <20200313152102.1707-2-longman@redhat.com>
 <20200313152102.1707-1-longman@redhat.com>
 <1797278.1584359451@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bfc84e1c-1a40-618a-fd7e-833c5a20063c@redhat.com>
Date:   Tue, 17 Mar 2020 14:09:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1797278.1584359451@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/16/20 7:50 AM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>>  include/linux/key-type.h                  |  2 +-
>>  security/keys/big_key.c                   | 11 ++---
>>  security/keys/encrypted-keys/encrypted.c  |  7 ++-
>>  security/keys/keyctl.c                    | 57 +++++++++++++++++++----
>>  security/keys/keyring.c                   |  6 +--
>>  security/keys/request_key_auth.c          |  7 ++-
>>  security/keys/trusted-keys/trusted_tpm1.c | 14 +-----
>>  security/keys/user_defined.c              |  5 +-
>> ...
>> -	long (*read)(const struct key *key, char __user *buffer, size_t buflen);
>> +	long (*read)(const struct key *key, char *buffer, size_t buflen);
> Note that there are read functions outside of security/keys/ that also need
> fixing - dns_resolver_read() and rxrpc_read().
>
> David

Yes, I am going to fix that. Sorry for the delay as I am juggling a few
different tasks.

Cheers,
Longman

