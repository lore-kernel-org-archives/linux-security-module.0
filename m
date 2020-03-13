Return-Path: <SRS0=meF1=46=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBF3C4CECE
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E86206E7
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOWeSrCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgCMQ5z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:57:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52944 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgCMQ5z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Mar 2020 12:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584118674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9j8OnyBfNlILX87ciN7BUxM/us5ynsXzxTQG5ddWEmM=;
        b=eOWeSrCD7Uq7hUGuQbefMek4Q4vjgwhE3OQSSTh2l18haNxK86ffwAyJ/cTNYWYWRkTj0/
        KUTl8jhiKcI5RKT0EDc/Gsiy1maFS3SO0Ragf0CAaZ/4AgbEfdTYTVJsD+wHC+OhSAc2aa
        3RIQJMGdZIu4v3jr5P5T0DixNqKz0TU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-RJuFnENPPai3qqAECQMLXA-1; Fri, 13 Mar 2020 12:57:50 -0400
X-MC-Unique: RJuFnENPPai3qqAECQMLXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53604107ACC4;
        Fri, 13 Mar 2020 16:57:47 +0000 (UTC)
Received: from llong.remote.csb (ovpn-125-21.rdu2.redhat.com [10.10.125.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7D905D9CA;
        Fri, 13 Mar 2020 16:57:44 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] KEYS: Don't write out to userspace while holding
 key semaphore
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Howells <dhowells@redhat.com>,
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
References: <20200308170410.14166-1-longman@redhat.com>
 <20200308170410.14166-2-longman@redhat.com>
 <20200313010425.GA11360@linux.intel.com>
 <e2dc038b-0283-0bf6-45f6-ad2dd0775e81@redhat.com>
 <20200313152837.GB142269@linux.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f4526e6f-0038-11f1-7950-e91ce90e49c1@redhat.com>
Date:   Fri, 13 Mar 2020 12:57:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200313152837.GB142269@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/13/20 11:28 AM, Jarkko Sakkinen wrote:
> On Fri, Mar 13, 2020 at 09:29:47AM -0400, Waiman Long wrote:
>> One way to do that is to extract the down_read/up_read block into a
>> helper function and then have 2 separate paths - one for length
>> retrieval and another one for reading the key. I think that will make
>> the code a bit easier easier to read.
>>
>> Thanks,
>> Longman
> If it is not too much trouble for you, I think this would be a legit
> cleanup to do.

Done. Please review the v3 patch.

Thanks,
Longman

