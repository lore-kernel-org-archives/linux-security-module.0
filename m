Return-Path: <SRS0=RoHj=BD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1400DC433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jul 2020 03:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFA720714
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jul 2020 03:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595561515;
	bh=EMCzbpv9o1G+k3ZQ/98rZF32fAUg3pIZDXpgoj0im/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bZQiSKE6MP5VRP2CIAQxJiwedNA/JPl4tMIKAS3SYzCCdDRt+nwPUZnMwc/8kMnjU
	 Mo0F9nTWdFIWiX2sSVBxix9WpdQLy4KTHHNEhWdlf8QEiSKCNwn/zAjkLL0YhrMqol
	 AGBdwLuLA0KlYR0VUJbFjHoZN7tJA1da4Z3L5ZNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGXDbz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:31:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43751 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXDbz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jul 2020 23:31:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id k18so5998067qtm.10
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2020 20:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2plnO1Tv1UATJ8BOOV+vwHmEVSthH+5Wk186p7sPDY=;
        b=SxkFD7X5Vevkh/kNFfkyvQUBl7Tzyh+1D9RUj1qSlXijgbaPbzWEq8MUYoJ0yYhKAq
         UN1mLMYI00YWNHFvhKaZyeytdnAChxcNGsBIwooFSk+qNUnXeXtvxAOqkX0xTTmCZ6LB
         zpwKHCB4v3tBIPz7peagmFfXWoC2XbBpCoXRU4cG5w/V46qMwCGoSEYSrE2NEIIwRBV4
         x1AKi6c90hR4tpgXVZE39/cQU+6DYIJEwifq2Pid62kHdkTPYTjThd4qjJoSzGmuF8He
         sqGGvdME5MYuto8KOvRfR6mYcLZwnNWvtzjta900dl9InlFJr4DSZ8evIIr3b+QHBVDF
         deTw==
X-Gm-Message-State: AOAM533QRRIpxIeQS05y/8cJNz+UhfSO699Jfn+9/DP4DxBQZVUSSnEn
        LDAlEl111sYZLeDGX7n/jLuGVhvsUrLnQwzjpkJyjg==
X-Google-Smtp-Source: ABdhPJwt89R+bp++SIh4d14As5UkmEEGxdwgUOqaPblvqh6KpHBQKbDR7fvzTZQ/yZ0Vi1B9ltxmeTiqWHX+ZsLE6ao=
X-Received: by 2002:aed:3023:: with SMTP id 32mr7500462qte.37.1595561513682;
 Thu, 23 Jul 2020 20:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200723091818.494712-1-mtk.manpages@gmail.com>
In-Reply-To: <20200723091818.494712-1-mtk.manpages@gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Thu, 23 Jul 2020 20:31:42 -0700
Message-ID: <CALQRfL6MXR3i5W0_cbmJ1BXbnxhHkCL2wQAryPW2LuORjcm5oQ@mail.gmail.com>
Subject: Re: [PATCH] Manual pages: use "root user ID" rather than "rootid"
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Applied both this and the cap_from_text man page change.

I've also updated the latter page to show that what used to be
summarized by cap_to_text() as: "= cap_foo+..." will (in libcap-2.41)
be the equivalent, but shorter, text: "cap_foo=..." which is also more
intuitive.

Cheers

Andrew

On Thu, Jul 23, 2020 at 2:18 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> The capabilities(7) page has for quite some time used the term "root user ID",
> which is, I think, a little more precise and expressive than "rootid".
> I think it would be good if libcap used the same terminology,
>
> Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> ---
>  doc/cap_get_file.3 | 6 +++---
>  doc/getcap.8       | 3 ++-
>  doc/setcap.8       | 8 ++++----
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
> index ceacbaf..3f73734 100644
> --- a/doc/cap_get_file.3
> +++ b/doc/cap_get_file.3
> @@ -18,7 +18,7 @@ manipulation on files
>  .sp
>  .BI "uid_t cap_get_nsowner(cap_t " caps );
>  .sp
> -.BI "int cap_set_nsowner(cap_t " caps ", uid_t " rootid );
> +.BI "int cap_set_nsowner(cap_t " caps ", uid_t " rootuid );
>  .sp
>  Link with \fI\-lcap\fP.
>  .SH DESCRIPTION
> @@ -66,13 +66,13 @@ capability in its effective capability set.  The effects of writing the
>  capability state to any file type other than a regular file are
>  undefined.
>  .PP
> -A capability set held in memory can be associated with the rootid in
> +A capability set held in memory can be associated with the root user ID in
>  use in a specific user namespace. It is possible to get and set this value
>  (in the memory copy) with
>  .BR cap_get_nsowner ()
>  and
>  .BR cap_set_nsowner ()
> -respectively. The rootid is ignored by the libcap library in all cases
> +respectively. The root user ID is ignored by the libcap library in all cases
>  other than when the capability is written to a file. Only if the value
>  is non-zero will the library attempt to include it in the written file
>  capability set.
> diff --git a/doc/getcap.8 b/doc/getcap.8
> index 2ad8092..04b601c 100644
> --- a/doc/getcap.8
> +++ b/doc/getcap.8
> @@ -13,7 +13,8 @@ displays the name and capabilities of each specified file.
>  prints quick usage.
>  .TP 4
>  .B \-n
> -prints any non-zero user namespace rootid value found to be associated with
> +prints any non-zero user namespace root user ID value
> +found to be associated with
>  a file's capabilities.
>  .TP 4
>  .B \-r
> diff --git a/doc/setcap.8 b/doc/setcap.8
> index 582c781..463752d 100644
> --- a/doc/setcap.8
> +++ b/doc/setcap.8
> @@ -2,7 +2,7 @@
>  .SH NAME
>  setcap \- set file capabilities
>  .SH SYNOPSIS
> -\fBsetcap\fP [\-q] [\-n <rootid>] [\-v] {\fIcapabilities|\-|\-r} filename\fP [ ... \fIcapabilitiesN\fP \fIfileN\fP ]
> +\fBsetcap\fP [\-q] [\-n <rootuid>] [\-v] {\fIcapabilities|\-|\-r} filename\fP [ ... \fIcapabilitiesN\fP \fIfileN\fP ]
>  .SH DESCRIPTION
>  In the absence of the
>  .B \-v
> @@ -13,13 +13,13 @@ sets the capabilities of each specified
>  to the
>  .I capabilities
>  specified.  The optional
> -.B \-n <rootid>
> +.B \-n <rootuid>
>  argument can be used to set the file capability for use only in a
> -user namespace with this rootid owner. The
> +user namespace with this root user ID owner. The
>  .B \-v
>  option is used to verify that the specified capabilities are currently
>  associated with the file. If \-v and \-n are supplied, the
> -.B \-n <rootid>
> +.B \-n <rootuid>
>  argument is also verified.
>  .PP
>  The
> --
> 2.26.2
>
