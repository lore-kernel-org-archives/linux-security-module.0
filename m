Return-Path: <SRS0=7AUc=BI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7396C433E1
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jul 2020 02:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21272076E
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jul 2020 02:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itmWCuWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgG2CHa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:07:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21115 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728401AbgG2CH3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jul 2020 22:07:29 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 22:07:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595988448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DeolwL/8SdMeyvaIjqFbfDjnFfnpKQhKODlzhWE0ad4=;
        b=itmWCuWSQuV2UJTy+TsvTtMOAvzH/PTDdHquf7yQO01BrrOAtb6L9QyDRs9O139JWIkHdT
        oc1JCNKu1/MS2GcC4tGJo4ItQbC5SbrJkxdKDRqRqRuVZKFPubtxPHBdohNQL/CL2aut51
        hXTDG/QQN35Ra3+D7zn6h0IAUlm0Hz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-5cxjp49uMeyN4-6Az-5SbA-1; Tue, 28 Jul 2020 22:01:17 -0400
X-MC-Unique: 5cxjp49uMeyN4-6Az-5SbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78F8D1DE2;
        Wed, 29 Jul 2020 02:01:16 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 986A38A169;
        Wed, 29 Jul 2020 02:01:09 +0000 (UTC)
Date:   Tue, 28 Jul 2020 22:01:06 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@parisplace.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3fix ghak120] audit: initialize context values in case
 of mandatory events
Message-ID: <20200729020106.x5tfijvnxdmujtbj@madcap2.tricolour.ca>
References: <e3e9c9da9115fd233c5a7895dbb4a698a365b1b0.1595884394.git.rgb@redhat.com>
 <CAHC9VhSx23JiN6GprskxdEcs9uftJOp03Svh7YJbQLOV91AMiQ@mail.gmail.com>
 <20200728162722.djvy3qyclj57wsfn@madcap2.tricolour.ca>
 <CAHC9VhSDoi8QS3c6Wmx6agmmphja60cS3+aTKVx76xvdkxJ0DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSDoi8QS3c6Wmx6agmmphja60cS3+aTKVx76xvdkxJ0DQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-07-28 14:47, Paul Moore wrote:
> On Tue, Jul 28, 2020 at 12:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > I know you like only really minimal fixes this late, but this seemed
> > pretty minimal to me...
> 
> Minimal is a one (two?) line NULL check in audit_log_name(), this
> patch is not that.

I didn't try and test that since I'm not sure that would have worked
because there appeared to be a low non-NULL value in it.  brauer1's trace had
0x60 and mine had 0xd0.  Or am I missing something obvious?

The patch provided the information rather than ignoring the problem
(which maybe should have been caught by WARN_ONCE?).

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

