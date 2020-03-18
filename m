Return-Path: <SRS0=DElp=5D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2876DC5ACD6
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Mar 2020 08:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184B2076D
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Mar 2020 08:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0r8NXkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCRIXT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:23:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58208 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgCRIXT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Mar 2020 04:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584519798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5ZmniDWtOGgirD0ysXPKxoDj8zWagjtTzwo7m2KYVo=;
        b=Y0r8NXkMi7FThx6FhibC1nb1o//S89dYspxFVuLGQ/kDNl0XOuEd+ZGG+RKYYGow/l1Qc3
        ZfDW7RDIgYgPO983Wae7fXqmToLJu125iW1AHOwaAzJJ3izkUNvF9hmkqU/ZZu+0sJyh+g
        tpd+M5pYXoNPcsf+iOEOhcs8kNiIQiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-UnVQ4uV7PpGJbTpejA56sQ-1; Wed, 18 Mar 2020 04:23:15 -0400
X-MC-Unique: UnVQ4uV7PpGJbTpejA56sQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240158010C8;
        Wed, 18 Mar 2020 08:23:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A427B60BEC;
        Wed, 18 Mar 2020 08:23:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200317194140.6031-3-longman@redhat.com>
References: <20200317194140.6031-3-longman@redhat.com> <20200317194140.6031-1-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
Subject: Re: [PATCH v4 2/4] KEYS: Remove __user annotation from rxrpc_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2831785.1584519784.1@warthog.procyon.org.uk>
Date:   Wed, 18 Mar 2020 08:23:04 +0000
Message-ID: <2831786.1584519784@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Patch 2 and 3 need to be rolled into patch 1 otherwise sparse will give
warnings about mismatches in address spaces on patch 1.

Thanks,
David

