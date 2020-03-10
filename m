Return-Path: <SRS0=JkyI=43=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A13C10F27
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Mar 2020 15:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB37215A4
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Mar 2020 15:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo5l1LrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJPqF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:46:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgCJPqF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Mar 2020 11:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583855164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3mW9AxcALFNXf1WMocdIsUCW8HVchDSafJ1KCcJWWs=;
        b=Eo5l1LrKq+ZDCCQ7VrGP77QXF4ipckXizp1VJKR88YRmchXJVvsaSVxx5ecm1MFcqxyYRZ
        MQcFGG5BFyys3AYYYjRFsnz3y9obegZ9uJrSyiZ0Pza8iUjbeJIwAia7tyTcrMrXJwMtoa
        gBpVPab5JtRyr2MD3eJOAU2qVGayUNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-aaumopnYPQqZELTYIPw55g-1; Tue, 10 Mar 2020 11:46:01 -0400
X-MC-Unique: aaumopnYPQqZELTYIPw55g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA7DD107ACC4;
        Tue, 10 Mar 2020 15:45:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA165C28D;
        Tue, 10 Mar 2020 15:45:56 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key
 read
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
References: <20200308170410.14166-3-longman@redhat.com>
 <20200308170410.14166-1-longman@redhat.com>
 <416690.1583771540@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
Date:   Tue, 10 Mar 2020 11:45:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <416690.1583771540@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/9/20 12:32 PM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> +			tmpbuf = kmalloc(tbuflen, GFP_KERNEL);
> This would probably be better off using kvmalloc() - otherwise big objects
> have to be constructed from runs of contiguous pages.  But since all we're
> doing is buffering for userspace, we don't care about that.
>
> If you agree, we can address it with an additional patch.
>
> David

That is certainly fine with me. I don't care if the pages are contiguous
or not. Will add a patch 3 for that as suggested.

Thanks,
Longman

