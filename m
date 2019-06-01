Return-Path: <SRS0=lcqx=UA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D4AC04AB6
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Jun 2019 01:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A7A26F76
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Jun 2019 01:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559351915;
	bh=Mw+rwVSb5/LlCGeIAUzZqfm3N9lHZ+uRIKyeNP4lOrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fmW8ZuXHBcPPatPx2BJpTa0Ldhxb66efbg/mYwpI/9p0Hr0D7RY8/w01ffjnoupzZ
	 GtemiruUxD6ei3QmPTcj7UtG1ZeYn4GTvx4yNWoa0M+yDb4vbnP8QYkitNQiK7iKWm
	 aKW7DrZ0ii2RwJRiKqTcvGGWl4zwWiSzFre3Hb/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfFABSe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 May 2019 21:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfFABSe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 May 2019 21:18:34 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD5426F74;
        Sat,  1 Jun 2019 01:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559351913;
        bh=Mw+rwVSb5/LlCGeIAUzZqfm3N9lHZ+uRIKyeNP4lOrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmQkX4JgC4RQPwCWS/q6Lhztvd36ltD9nSqkvNqDwcDBMkal7ZMQKuGocYdzPTTi6
         4HPz2jp+h9SSimOqoRsErp/iGmTRfQv94QDo2tDoRmL5FtqaLgcYEii7jT2kHe0iPt
         0dVdmLkCd4cUB2fzkLts29ZCEQThZy/jQYS9KAG0=
Date:   Fri, 31 May 2019 18:18:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sandeep Patil <sspatil@android.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Marco Elver <elver@google.com>,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm: init: report memory auto-initialization
 features at boot time
Message-Id: <20190531181832.e7c3888870ce9e50db9f69e6@linux-foundation.org>
In-Reply-To: <20190529123812.43089-3-glider@google.com>
References: <20190529123812.43089-1-glider@google.com>
        <20190529123812.43089-3-glider@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 29 May 2019 14:38:11 +0200 Alexander Potapenko <glider@google.com> wrote:

> Print the currently enabled stack and heap initialization modes.
> 
> The possible options for stack are:
>  - "all" for CONFIG_INIT_STACK_ALL;
>  - "byref_all" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL;
>  - "byref" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF;
>  - "__user" for CONFIG_GCC_PLUGIN_STRUCTLEAK_USER;
>  - "off" otherwise.
> 
> Depending on the values of init_on_alloc and init_on_free boottime
> options we also report "heap alloc" and "heap free" as "on"/"off".

Why?

Please fully describe the benefit to users so that others can judge the
desirability of the patch.  And so they can review it effectively, etc.

Always!

> In the init_on_free mode initializing pages at boot time may take some
> time, so print a notice about that as well.

How much time?
