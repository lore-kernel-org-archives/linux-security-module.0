Return-Path: <SRS0=zxlL=XL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A84FC49ED7
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Sep 2019 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60B4206C2
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Sep 2019 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568666321;
	bh=EY6tme3ahlxbvqIuWhhP/CP4BgEmcGv1d6xzN7Rmy2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SH4k33PHoyCfzHLCw9RoTrG/rpZVQkIrv9K3cDVGlga72l29ChdX9uikhMqWeV4Va
	 kk4IK2Xa77rEIaA6KH05LjvxAhKWT4b9EMqSsX1kz9B427exxU5fVfsA1WOhuIETjh
	 UL0QibTOQvAFTK2eGXiQaDh/VKF3+xW214V6gEeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfIPUik (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:38:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39115 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbfIPUik (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Sep 2019 16:38:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id s19so1240055lji.6
        for <linux-security-module@vger.kernel.org>; Mon, 16 Sep 2019 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me/tNrvpc38oLBmNgQpuGD2wwLksgIc0n84g04Pq6UM=;
        b=hFnsr4SQxJjjqereCuTP+xGrGqVFwwB7+2ShWDl5Qp8pLxb4+MV1NinHIOPm4UaO/I
         66LHrIpJRtRLDqw3UxiqboGbOYFJm3hraDsxkxsG2zVzCjIxcW00JkhtL3B0fbXwayOw
         0lnLYFaWHXA2YaW+8dkcHiVuHzVd/UG+TSCPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me/tNrvpc38oLBmNgQpuGD2wwLksgIc0n84g04Pq6UM=;
        b=ulgDUI48SaUKLAo8H8vI2/zUJ2aHMaIrOyBnsewMKcTi5vn5NtA6orx5tPRj6SIIR6
         lWGyq7UPIiKCaBkRn4YQH5qeH+0LE5EuWd2Rk4T2rQprQLF9xRbTzDouh4WvR/XAhcti
         1oo9oXOTvSm2kMqVqzl7eGQf4ZSlRYaaKuamQWkB3zHZIdKDYhGqrIXjby74ceck4CNV
         fbxa8TafVAtNEtIQ7QBymvJmLKkx7kbPcQjIhHcUiFcAK4oxcTy3PLmlM3BFbbU3LYEC
         YJMi8j1/rUchJIYBiQSF2n1VOFUHqj3SlKoIIgVs9pr9Qxh8fAIrhWfLCZ3MmElVHVg7
         kwjg==
X-Gm-Message-State: APjAAAU0W8FZ9onqK/wSFfjUfYKKHIrL+/w7qT+mX2FhAVNYpUrk1BB5
        p2j7gBRKmZrjKpatHZmNkLyyMVcQc1c=
X-Google-Smtp-Source: APXvYqzI+hbtRgdoSD5W0MwPElnxiWiA0Z38DgDqItSlbXB1YbTePJtxbOUPNjJwyKvSp7M7Mg+uyQ==
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr808056lji.51.1568666317523;
        Mon, 16 Sep 2019 13:38:37 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m17sm2244lje.0.2019.09.16.13.38.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id f5so1230136ljg.8
        for <linux-security-module@vger.kernel.org>; Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr801701lje.90.1568666316121;
 Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <1568237365.5783.39.camel@linux.ibm.com>
In-Reply-To: <1568237365.5783.39.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 13:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
Message-ID: <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.4
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 11, 2019 at 2:29 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> The major feature in this pull request is IMA support for measuring
> and appraising appended file signatures.  In addition are a couple of
> bug fixes and code cleanup to use struct_size().

How is the file signature any different from (and/or better than) the
fs-verity support?

The fs-verity support got fairly extensively discussed, and is
apparently going to actually be widely used by Android, and it an
independent feature of any security model.

What does the IMA version bring to the table?

             Linus
