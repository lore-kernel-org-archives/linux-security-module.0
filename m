Return-Path: <SRS0=feNe=7Y=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E70FC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Jun 2020 15:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09225206A4
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Jun 2020 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591891166;
	bh=tlh1UmC1eo1sAQf/CMrtCtWvKecQM3a4IY3S6L819XM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IQVkh/Auzgl0prSgo/wnEbhNvGhCzncE6ChYs99Az/O1GfrerqG3u0uRaSkI1VANC
	 aK5j6pWLFlu/kV1HRjIbg+qK53BosMiFmOIvoAwM0rADd6R+QOxh19eXtOpOK+6dKR
	 WLqkluXlo/YE62xiP3NBvSlp/rxJ4hAVBGw7x33Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgFKP7Z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:59:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32838 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgFKP7Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Jun 2020 11:59:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id e16so4945649qtg.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jun 2020 08:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXHzycWNzw8xmZwBMjYM5hvV02agAwUDyISXSYhyXUw=;
        b=D+IpvITdqKJeDutjnM4gCrDhGXDkCnzWecr2hX8p2ZptQV/ahgc27kJpoHKp5tmHZl
         f6es/YgdwVkDoeG82uteBTohtEMMljI1gcBVDRaQosyc/EjKJR0AW73pUtG2KpcCqJCv
         g7/Xs8jJz2LoIdX7koUM1z82GcOhH0FR+3o4buB6HJ+aeI38ls1aRvtBGpSNwrZ1+wDN
         1T0qZnTcYk4YbDyIiCqSJlSBYK4XDNX+u9nKIbMtKwS4TAcxwI1CGFkBssQtPYTR9DEl
         7zdOurFeKhZVUQTIstIa8yGtfL8cEaUsvU9O8vPjGce6TNCAIoatJNl0siSEkoKTj0C9
         yxlw==
X-Gm-Message-State: AOAM531Ltngv7nP6O9VfJ8dXsB3LZ8F1RG9md+FUAXk8rGd96UOsCazY
        ys5Xgr9WDGpWRogK5LovF5V6XFrdiCmUrRqoxmV7HocW0EBjgA==
X-Google-Smtp-Source: ABdhPJwrHypQKck3M7xbFeHQcl+ya9hAgGpRK2Yr47dkVtvBRF940utoEC1PNStJmHzjQBn54i+c4A4ivldLfGqlALo=
X-Received: by 2002:ac8:1772:: with SMTP id u47mr8567893qtk.177.1591891163631;
 Thu, 11 Jun 2020 08:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200610065735.3975740-1-mtk.manpages@gmail.com> <20200610065735.3975740-4-mtk.manpages@gmail.com>
In-Reply-To: <20200610065735.3975740-4-mtk.manpages@gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Thu, 11 Jun 2020 08:59:12 -0700
Message-ID: <CALQRfL6802XRA2egkJuc0nR9ptn9EbGY8fn-T2_tjoM3i5TZsg@mail.gmail.com>
Subject: Re: [PATCH 4/4] cap_get_proc.3: change "current process" to "calling process"
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks. All applied:

https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=589f1f1624528a5153e27f6c54ae49d7beaa183f

Cheers

Andrew

On Tue, Jun 9, 2020 at 11:57 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> The term "current process" is kernel-developer speak that is often not
> understood by user-space programmers. Change to "calling process",
> which is clearer.
>
> Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> ---
>  doc/cap_get_proc.3 | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
> index 0238601..b0a61d1 100644
> --- a/doc/cap_get_proc.3
> +++ b/doc/cap_get_proc.3
> @@ -89,7 +89,7 @@ file.
>  with a
>  .I  cap
>  as an argument returns the current value of this bounding set
> -capability flag in effect for the current process. This operation is
> +capability flag in effect for the calling process. This operation is
>  unprivileged. Note, a macro function
>  .BR "CAP_IS_SUPPORTED(cap_value_t " cap )
>  is provided that evaluates to true (1) if the system supports the
> @@ -122,11 +122,11 @@ capability set must have a raised
>  .BR CAP_SETPCAP .
>  Further, to raise a specific ambient capability the
>  .IR inheritable " and " permitted
> -sets of the current process must contain the specified capability, and
> +sets of the calling process must contain the specified capability, and
>  raised ambient bits will only be retained as long as this remains true.
>  .PP
>  .BR cap_reset_ambient ()
> -resets all of the ambient capabilities for the current process to
> +resets all of the ambient capabilities for the calling process to
>  their lowered value. To complete successfully, the prevailing
>  .I effective
>  capability set must have a raised
> @@ -139,12 +139,12 @@ changes to the inheritable set by the program code without explicitly
>  fixing up the ambient set can also drop ambient bits.
>  .PP
>  .BR cap_get_secbits ()
> -returns the securebits of the current process. These bits affect the
> -way in which the current process implements things like setuid-root
> +returns the securebits of the calling process. These bits affect the
> +way in which the calling process implements things like setuid-root
>  fixup and ambient capabilities.
>  .PP
>  .BR cap_set_secbits ()
> -attempts to modify the securebits of the current process. Note
> +attempts to modify the securebits of the calling process. Note
>  .B CAP_SETPCAP
>  must be in the effective capability set for this to be effective. Some
>  settings lock the sub-states of the securebits, so attempts to set values
> @@ -274,13 +274,13 @@ attempts to set the capabilities of some other process(es),
>  If
>  .I pid
>  is positive it refers to a specific process;  if it is zero, it refers
> -to the current process; \-1 refers to all processes other than the
> -current process and process '1' (typically
> +to the calling process; \-1 refers to all processes other than the
> +calling process and process '1' (typically
>  .BR init (8));
>  other negative values refer to the
>  .I \-pid
>  process group.  In order to use this function, the kernel must support
> -it and the current process must have
> +it and the calling process must have
>  .B CAP_SETPCAP
>  raised in its Effective capability set. The capabilities set in the
>  target process(es) are those contained in
> @@ -288,7 +288,7 @@ target process(es) are those contained in
>  Kernels that support filesystem capabilities redefine the semantics of
>  .B CAP_SETPCAP
>  and on such systems this function will always fail for any target not
> -equal to the current process.
> +equal to the calling process.
>  .BR capsetp ()
>  returns zero for success, and \-1 on failure.
>
> --
> 2.26.2
>
