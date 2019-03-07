Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A94C4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 22:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031820851
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 22:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vgo0ZuHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCGW3E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:29:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52484 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCGW3D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Mar 2019 17:29:03 -0500
Received: by mail-it1-f195.google.com with SMTP id g17so17960437ita.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2019 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNxJ3foSkA4SZkqYFT+UIjdNLs58toH+QOhrzUMtpYc=;
        b=Vgo0ZuHfZ0CQsRUYsH9bmQmCVMGzvvZf0zYxZGh9TjXtesRrpqj9H3qW4qnYrCCU3F
         9GR73nxfrpQeuIdnF1OXEhLvB96J/rQvI9isT5i5FStkanUr3Sw1NTwbJOJVOTcdSM7x
         ebCNzVAQKuF3/ZkmlMStUgUt69BxOzeHEz3CQi5ka+Z0QyqHiEocp19IzRsfPqz8ocv1
         z7maRj2F+vV5Awf/vysGKYj5R8OXYSjQ8fNuGJX/9JX1XNi6DVJoRkzXnLlAtNKaHZBT
         UYfTVmCwehNQ9pQamd6ylSMkfpla/ILa5FZJFoPEfm3T0BUx+8VP9StX5o9BW5RedRaf
         7QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNxJ3foSkA4SZkqYFT+UIjdNLs58toH+QOhrzUMtpYc=;
        b=R/XFTQd7UDHkot7+/K2poVOLtuPJ73A43TBp0y2B6cXEr1eEC4J/8qK6fGr7oyAUUc
         8zPMpGxoNFhofT+YTbQJxKPosGmPEj7B/5ADcVBsXre0fbGb9ueeC+FMNA6wmKImGikV
         DIkUNT4q6TtVP0NDp+oLudTreUT4QleD21CSWgpGOW/HDvZRSOLA7wewEgETmsoIfD5M
         NznsA/G7iRlLlr99AP9aAA5/w14EjZTBhKS+b72mX2ZQ09G5A/mr4KlHeULmqJmCFyTb
         ++PtzZnrobyhpQdE8bJWjDS88fPsTd21AT+o/5tiBGlGpX+I19XCD4rZ4Y6LsftgIqpW
         ecCw==
X-Gm-Message-State: APjAAAXCE786Q8SlA7Y6m3CkT2S90tShraeeqAzBlNipMSoTjVzAmGtV
        jLXOoorpeiHY9p2HnZi0zd8BAo5YiqIT2I7Nb/A0a+xvFjE=
X-Google-Smtp-Source: APXvYqy43x5FazluW1X9TdVxWggDEgzXnLX6+pFxYl5tfuPVTEaHj5SdjRk99bEssezrmdKgcOhdOIvCihQxJQ9kiY8=
X-Received: by 2002:a02:76c2:: with SMTP id z185mr8696301jab.102.1551997742985;
 Thu, 07 Mar 2019 14:29:02 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com> <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 14:28:52 -0800
Message-ID: <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, jforbes@redhat.com,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 19, 2018 at 11:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> The secure boot mode may not be detected on boot for some reason (eg.
> buggy firmware).  This patch attempts one more time to detect the
> secure boot mode.

Do we have cases where this has actually been seen? I'm not sure what
the circumstances are that would result in this behaviour.
