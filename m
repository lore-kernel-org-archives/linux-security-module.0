Return-Path: <SRS0=KxFF=5F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F88AC4332E
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Mar 2020 13:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DDC2076E
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Mar 2020 13:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHFPBn9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCTN4y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:56:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52271 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgCTN4x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Mar 2020 09:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584712612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBKKCxuGzKiLvrrqPPRyma9kDDTtMDjNgcj+HYwHhTs=;
        b=cHFPBn9tVVRvJ++LN/wXbZYMB4ssHfETvm/DPuEob9Ttm4As5fqipanwPXVpQMle+cp/B9
        5xFdDBIhKDbOZ+/3Hqr23zs0+uUUuIngwp7DMOn98C/3GF7svltGNkJFqaGWfzOrweerpW
        U9K4puh+l6R2YCMeE4den/EQedrQ2Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-uCxcpSM7P_e66dxWVrksMQ-1; Fri, 20 Mar 2020 09:56:48 -0400
X-MC-Unique: uCxcpSM7P_e66dxWVrksMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD92477;
        Fri, 20 Mar 2020 13:56:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-190.rdu2.redhat.com [10.10.118.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0641C62937;
        Fri, 20 Mar 2020 13:56:42 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] KEYS: Don't write out to userspace while holding
 key semaphore
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
References: <20200318221457.1330-2-longman@redhat.com>
 <20200318221457.1330-1-longman@redhat.com>
 <3251035.1584692419@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <69678e1c-dfbe-7484-85ad-601ebe23c90d@redhat.com>
Date:   Fri, 20 Mar 2020 09:56:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3251035.1584692419@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/20/20 4:20 AM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> +		if ((ret > 0) && (ret <= buflen)) {
> That's a bit excessive on the bracketage, btw, but don't worry about it unless
> you respin the patches.

Got it.

Thanks,
Longman

