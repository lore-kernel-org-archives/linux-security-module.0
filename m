Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8D8C10F14
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6998206B6
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVAFhku/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfDRTfs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:35:48 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33904 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRTfs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 15:35:48 -0400
Received: by mail-it1-f196.google.com with SMTP id z17so8740301itc.1
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2019 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRy99qz2AMkYVZFv425R2doBAop8CHsZxNlVLtfW3eQ=;
        b=eVAFhku/XdVgMCLGF1pWwGePMOzh4kN+765FPgQ5wWCskNuETlJ/ljtK04DZ8DAMYA
         6KirlgWILO8UcOP7+VAIZfQY9YhW+mMFNpgTqK/s89RNKQNChTyEsMd5znxj6hEuLrDF
         F+LGCwhNW0tI+wknP6IPzs1pf5uJv4qR3elhxX+g4+NxUhKPVjc3+4GA7cPWKPaj0TFy
         l/WBggm3UjrrQI21FfbCJQWzBnfMvL8/xYW7aRcgkJK/CiH4WRIefhST2cUZ75EJXuM7
         x2MmFIi/peTST374MP6ex5Ys97JTlVh5hzQhWqhtH9IPGYcZMTZvdDEovy2VgyFVtyri
         Tn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRy99qz2AMkYVZFv425R2doBAop8CHsZxNlVLtfW3eQ=;
        b=i8f/10oDmL9xkd2vcyoY2wZ0AO567zYaw3AXzxg80LyDjRLmLNolgfJkTmvUD7ZBRY
         16Wp2eEO25jM3xOlhJ2vwTj/Uqv+Gu7uxrkoD7vZddHLhoHgE8SOVUNCzFpItM9Alw0x
         SzLZ/zYkvGWgosBBg/6CGcv5ymDW2MgJvbRl6jvmxrA1V42sntT3X/BGyFmRGh1k8jtq
         cNptnjQHOQaXVpgNB3H1CqMJP06QnUXBWb8FnZ8AXtnx/SDNeWZbycv5XZAZJLQwxism
         dI3H0uoYotgZ9pCGmJBRQeuUVkFUHEuEKQ4IocacWQSV4ikLTk4hDDtc/Nx8LvLkfHUl
         Qc7Q==
X-Gm-Message-State: APjAAAWZaR/i7QEFsRfuq5Jyl/j31kXjIrTVQkZQosl76S9LYZ58YeDR
        DjIMMf6ILkC2lCERr3TuvcpJJ5hLgiiimYCzQzQBhA==
X-Google-Smtp-Source: APXvYqyScEeuSVEoRXwlwqC9hN5nB+zKXCchKqADZb8Nc3q9sc3gR9XiN4iPfEkmpvi69xHp7KmFjOENqmEZBNnhlLU=
X-Received: by 2002:a02:b38f:: with SMTP id p15mr9719050jan.103.1555616147577;
 Thu, 18 Apr 2019 12:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-2-matthewgarrett@google.com> <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
In-Reply-To: <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 18 Apr 2019 12:35:36 -0700
Message-ID: <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>, cmr <cmr@informatik.wtf>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 16, 2019 at 1:40 AM Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> I'm thinking about whether we should lock down the powerpc xmon debug
> monitor - intuitively, I think the answer is yes if for no other reason
> than Least Astonishment, when lockdown is enabled you probably don't
> expect xmon to keep letting you access kernel memory.

The original patchset contained a sysrq hotkey to allow physically
present users to disable lockdown, so I'm not super concerned about
this case - I could definitely be convinced otherwise, though.
