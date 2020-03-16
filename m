Return-Path: <SRS0=OFt8=5B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C1C18E5B
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 15:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B691520674
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWLvjEnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbgCPP1r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:27:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42971 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731859AbgCPP1r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Mar 2020 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584372465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tIckOGwAi8kcv9l4a2aU1rTC/7Ce6IHxh06VU/Fv30=;
        b=KWLvjEnjTHt4qBu77RI5DqKfhLG3h3XeH6uRPIWV0cQw12zGCmiIkBflGA5qs93grJTUpq
        C9dZmOyDTyqL+2W6XCMYPwlBvKnJupjmDaTNQ0T+m7bEDVMXgbUfk6pjqnx2YUBX+CIZNk
        tQ5r9Q4/R4DGBN9XUOk5qUNBud2KNK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-HalrFa8EOcWuYz9zbJlVlQ-1; Mon, 16 Mar 2020 11:21:34 -0400
X-MC-Unique: HalrFa8EOcWuYz9zbJlVlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F5C4193283B;
        Mon, 16 Mar 2020 15:21:32 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-249.phx2.redhat.com [10.3.118.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6542E19757;
        Mon, 16 Mar 2020 15:21:29 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer
 allocation
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
References: <20200313152102.1707-4-longman@redhat.com>
 <20200313152102.1707-1-longman@redhat.com>
 <1809107.1584368672@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b7188708-67fa-b41d-2d03-f9a3862f32d7@redhat.com>
Date:   Mon, 16 Mar 2020 11:21:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1809107.1584368672@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/16/20 10:24 AM, David Howells wrote:
> I wonder if it's worth merging this into patch 2.  I'm not sure it's really
> worth its own patch.  If you want to generalise kvzfree(), then that could go
> as its own patch first.
>
> David

Sure, I can merge it into patch 2.

Thanks,
Longman

