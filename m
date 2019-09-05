Return-Path: <SRS0=QiH2=XA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C9C43331
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Sep 2019 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCCB2082E
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Sep 2019 18:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390387AbfIESvx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389895AbfIESvx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Sep 2019 14:51:53 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9AC18830A
        for <linux-security-module@vger.kernel.org>; Thu,  5 Sep 2019 18:51:52 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j10so1391523wrb.16
        for <linux-security-module@vger.kernel.org>; Thu, 05 Sep 2019 11:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+X/R0y41DuJD8stDaaFF/mk4jlVxfRDTjRBOtakznc=;
        b=MEzUaoMwkydQ6DOexAQIb64K5O+UxCyh9WmLmvR06ExjAab13v2lJp0SPFbcgSvk3j
         nxHvc06DfqH9v7/Yj2dy0d//7SM1vwLNZttcQ73NFykUSynxrdDm5WQ7nR4xJa5aynxv
         s+wqygl8w6pIoNorjG+5dba0D10ppxECB43CS3DSx7KgaAwO2iLK03dWdYsj+Ze2a8AG
         dyV2r5X91hWm4ejS3LE9YT8TvvhQ9dLFQXe1AbNQDGMbYTbAqazv0We1Mq7/DGgxb4k7
         J4Og9wxcxJi1Y1r9pZfl7ZKe2AGy3DkI/cWjfypXqqjRYSmVXrycFS2irS5Qvs7bR+yW
         tsww==
X-Gm-Message-State: APjAAAUkM4DJf6UvzZvuZdn8yr8edbSV1SFLDZnjZsVgVMZYIQlP2Pjc
        pSkYGlHn0pjbwWG4bSBzdtZAS8kkpaDOEXR+1Ha8UH7ct4tZahyJJBw6fP1Px/sobNx++DpA8JA
        FDjMvxCoIC/4c7YJHIPIbt7FlxL9q5ku43XGbWsf5JE/zWzTGewa8
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr3763559wmj.123.1567709511263;
        Thu, 05 Sep 2019 11:51:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxppOJbXRzr0HT1qBIm7hjC+zxuRCss37FvJwDjsHuKSxoe+byuVe16izziNYRTPD8dFxdzcLlPcTR/VI7zzA=
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr3763540wmj.123.1567709510985;
 Thu, 05 Sep 2019 11:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
In-Reply-To: <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
From:   Ray Strode <rstrode@redhat.com>
Date:   Thu, 5 Sep 2019 14:51:14 -0400
Message-ID: <CAKCoTu7ms4ckwDA_-onuJg+famnMzGZE9gGUcqqMz0kCAAECRg@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Lehman <dlehman@redhat.com>, Ian Kent <ikent@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On Thu, Sep 5, 2019 at 2:37 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
> The original reason for the mount notification mechanism was so that we
> are able to provide information to GUIs and similar filesystem and
> storage management tools, matching the state of the filesystem with the
> state of the underlying devices. This is part of a larger project
> entitled "Project Springfield" to try and provide better management
> tools for storage and filesystems. I've copied David Lehman in, since he
> can provide a wider view on this topic.
So one problem that I've heard discussed before is what happens in a thinp
setup when the disk space is overallocated and gets used up. IIRC, the
volumes just sort of eat themselves?

Getting proper notification of looming catastrophic failure to the
workstation user
before it's too late would be useful, indeed.

I don't know if this new mechanism dhowells has development can help with that,
and/or if solving that problem is part of the Project Springfield
initiative or not. Do you
know off hand?

--Ray
