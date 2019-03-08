Return-Path: <SRS0=RbId=RL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A496C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFD52064A
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 17:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="div2a8TW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCHRwL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:52:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37721 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfCHRwL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Mar 2019 12:52:11 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so22567729itc.2
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2019 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCgz1Pcq5WHXCqvJ4MedxdGc3TiYDShi2zICvXucyK0=;
        b=div2a8TWLJ8asGEQa1ee0Ui8FMA/QEw9lXU8rICpQdMsv3LjYIj+unAHWUE/vXpaG2
         G5RaeZxkDAN5Wb/D7gFIrWBB8xmNUuQEZQ/7rermCkv8PvM4ArJiLTnzCcBenQCM15GH
         6Zyn1Rv3OZWGFqHN0SXyJN94SSwFIcwAhdjjn/sfDnSX4qfvx3i5bEEvYPZQ3DIaJWB2
         owEVE8FG0B1CHoGifjpkkwL2WtEscND5TbiO//uAQG+e0cMVRYilY18+P/WH3WC7szFx
         wZLLKXMgl7qgPq+CkpvDGS++yUIqlTfv0isbK4u+Xi3eYhGBxkN2HvYqEJzNlLUZZSIY
         gRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCgz1Pcq5WHXCqvJ4MedxdGc3TiYDShi2zICvXucyK0=;
        b=MgptmJoZar0jbwtvwWdIqYhfU8NwSrs1EcQU9fKZvGQrUnpNUJpJsl6uJDJ7Uy7ECq
         bu5Jy0P5JbNEOFwDsra7ukw624gV1v4IxiJRoRuUQN4bim2PArouA42+ogFxzqjV91Bf
         WySkSPnaMpjJJL7bvsGfHWS3CIK2R6Zo0/8oths0/12uLUMWJ0PzV4jQoR7avOBwzcSQ
         8ZlgkQUVWDhQA9A+xxx1Ro9beQaGP3ZjI7MW6QRvX079wu2a86i2Arl1tO0SY9zM8Hmc
         mna/fBApkEEqn7BFcXVUuS+E6MfHQrIUcg3LpoSKHoFp//wqFUzBrCXzytN6OFLH5MhP
         n6qQ==
X-Gm-Message-State: APjAAAUY5lKejeQAGNQEmR2U0XGqRv63ryc3u3MmcEi+RUT7rq7Xh0a/
        0Lxe+QOFVF4TKDw4gGn0LVoOyINbHg23XhzxInrdBg==
X-Google-Smtp-Source: APXvYqyoQGCS0razQ8BHZSojuViKcJ8Xl+bxoK+Ps8DCl6/D+RrFbHiCNu6R1xzQk5Lpa+EOmAwbqxAEqlljlnbqZak=
X-Received: by 2002:a24:7908:: with SMTP id z8mr9720424itc.16.1552067529523;
 Fri, 08 Mar 2019 09:52:09 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com> <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com> <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
 <1552052377.4134.23.camel@linux.ibm.com>
In-Reply-To: <1552052377.4134.23.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 8 Mar 2019 09:51:57 -0800
Message-ID: <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Justin Forbes <jforbes@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 8, 2019 at 5:40 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-03-07 at 14:50 -0800, Matthew Garrett wrote:
> > Is the issue that it gives incorrect results on the first read, or is
> > the issue that it gives incorrect results before ExitBootServices() is
> > called? If the former then we should read twice in the boot stub, if
> > the latter then we should figure out a way to do this immediately
> > after ExitBootServices() instead.
>
> Detecting the secure boot mode isn't the problem.  On boot, I am
> seeing "EFI stub: UEFI Secure Boot is enabled", but setup_arch() emits
> "Secure boot could not be determined".
>
> In efi_main() the secure_boot mode is initially unset, so
> efi_get_secureboot() is called.  efi_get_secureboot() returns the
> secure_boot mode correctly as enabled.  The problem seems to be in
> saving the secure_boot mode for later use.

Hm. And this only happens on certain firmware versions? If something's
stepping on boot_params then we have bigger problems.
