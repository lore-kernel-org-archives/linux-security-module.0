Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE52C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 10:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78BC2078E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592301797;
	bh=X84sKt5PQLBc6tu+9pZlqv+58ESwXd+4uih/06fLewg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iEryhfT3P78Z/6m1DKV5+TnfP2f0fOKGamEufuW/f7+in5ojPJWOdWkDC/RxpdPpO
	 YJjPauSlkhBOzs8DmOduZzI/EDRiU5a4D7JsOFOQFvH9cgTa6Rxtm2MNhOd4yktsxu
	 f9Ge4Rctz8SMeLiLKj80B+1iOWBZJoBPyMkdap48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFPKDQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPKDQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 06:03:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121BA20767;
        Tue, 16 Jun 2020 10:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592301794;
        bh=X84sKt5PQLBc6tu+9pZlqv+58ESwXd+4uih/06fLewg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcet8w7K5NFpfHYfjfkLwL1qs9ZtjQohV31jXzphpq9OJxrIfz+L3oKah5JqyJwBm
         Ll3/YYZjEJNs6kCySvEebEtGdmH1rR97oUQ5Pdv7wwPAPNtyStJHZ/Dzye5j87MfmC
         m5/TnAyj/7cZ4dTvD0O1tjANuBK8ZYpuZu2zEdJ4=
Date:   Tue, 16 Jun 2020 12:03:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     glider@google.com
Cc:     yamada.masahiro@socionext.com, keescook@chromium.org,
        jmorris@namei.org, maze@google.com, ndesaulniers@google.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
Message-ID: <20200616100309.GA2614426@kroah.com>
References: <20200616083435.223038-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616083435.223038-1-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 10:34:35AM +0200, glider@google.com wrote:
> In addition to -ftrivial-auto-var-init=pattern (used by
> CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
> locals enabled by -ftrivial-auto-var-init=zero.
> The future of this flag is still being debated, see
> https://bugs.llvm.org/show_bug.cgi?id=45497
> Right now it is guarded by another flag,
> -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
> which means it may not be supported by future Clang releases.
> Another possible resolution is that -ftrivial-auto-var-init=zero will
> persist (as certain users have already started depending on it), but the
> name of the guard flag will change.
> 
> In the meantime, zero initialization has proven itself as a good
> production mitigation measure against uninitialized locals. Unlike
> pattern initialization, which has a higher chance of triggering existing
> bugs, zero initialization provides safe defaults for strings, pointers,
> indexes, and sizes. On the other hand, pattern initialization remains
> safer for return values.
> Performance-wise, the difference between pattern and zero initialization
> is usually negligible, although the generated code for zero
> initialization is more compact.
> 
> This patch renames CONFIG_INIT_STACK_ALL to
> CONFIG_INIT_STACK_ALL_PATTERN and introduces another config option,
> CONFIG_INIT_STACK_ALL_ZERO, that enables zero initialization for locals
> if the corresponding flags are supported by Clang.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Nit, your From: line of your email does not match your signed-off-by:
line :(

In the future, you should fix that up so that maintainers don't have to
do it for you...

> +# Initialize all stack variables with a zero pattern.
> +ifdef CONFIG_INIT_STACK_ALL_ZERO
> +# Future support for zero initialization is still being debated, see
> +# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> +# renamed or dropped.
> +KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> +endif

Gotta love the name...

Anyway, if this is enabled, and clang changes the flag or drops it, does
the build suddenly break?

And does gcc have something like this as well, or does that have to come
in a compiler plugin?

thanks,

greg k-h
