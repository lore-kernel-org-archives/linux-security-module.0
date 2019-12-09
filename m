Return-Path: <SRS0=cm7D=Z7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB39C43603
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Dec 2019 23:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76693206D5
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Dec 2019 23:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vfpHg3Sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIXNL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:13:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41261 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLIXNL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Dec 2019 18:13:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so12087020lfp.8
        for <linux-security-module@vger.kernel.org>; Mon, 09 Dec 2019 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iqCmV8B8buco1LRLoG4l+riVC0C8+TxOU4n9PNGmJs=;
        b=vfpHg3SzO3CBdRIdyHFuw//KvHTqLIcWOrZLD9+rVX2TFW78RtPNQOyV9vUMkA72xn
         omowSZ7qbpIWvkmIjuyYXMWJGRaYXu24pTNqpPuikBJuU9UWi4bJ5l/0Go0wu+aFM1v0
         TXls+WdIyd54EPRPX19Go76xwzH/vwCcE6tTcIqRAOapHqwhRp8ECRAUrOE339j+RJce
         /h3q3YVi4htvZCiozVi402UHvSw0ll1khLtlwk8R3YrELetlrhSBwtWFC2Xzk1fKUmt3
         IPE+hixApxGce0ojEiAGRkm8h1g89mVGY6y8co2NK/KmEAAw/LJ9BlDDaA0uz5i6M8YN
         fuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iqCmV8B8buco1LRLoG4l+riVC0C8+TxOU4n9PNGmJs=;
        b=ptCjCfN5mc88lzaxXIRdhd8qMzNIGiHyDGpkPsIznyrSLg+RbF9AcddCKBpHd/IxFx
         8dU4wEFcQ/EzdEW6gpVtvvrjGptx7aI7zKWath8tc/oeh4f0J4cbZ4PghiVhS1DdRURD
         20rfbPfQDwaY1nMjtDy2Og+6Qc2pEQYk1n5S3OVofyvmHsFUnVZ8kxEjx1DwXDfLf+sR
         r4ZeFTi09xqe8unMJxlc2Y38ZlJ1RKmwYFglGGW2s4sd5lrPfyHamBnxi5qqKl3I0dQS
         Pss7aYfMc+c1aWPNWAbVZMrmCKDCkKvTOhjm0t5jq/Or28OSKrurFQ581ZSJshRLCfaO
         yqVQ==
X-Gm-Message-State: APjAAAVBGhjz+wVJVpjoAwhfalGkd8p0mNVOMatJdq9PgG7aSF44UyHA
        jWxvz/8xPihxl/EpaPzAa8dgSUWEwn6xqturXcPb
X-Google-Smtp-Source: APXvYqxK8lT8+yxmtO2aK/Kxw6gT2abY7GDxhFOS0fW2Oaes5lOumRYTMsFywEd/1NbHsDj/1kBfAInstC24JzG8uy8=
X-Received: by 2002:a19:4a12:: with SMTP id x18mr13515294lfa.158.1575933188814;
 Mon, 09 Dec 2019 15:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20191127170436.4237-1-sds@tycho.nsa.gov>
In-Reply-To: <20191127170436.4237-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 18:12:57 -0500
Message-ID: <CAHC9VhQ8nV3CQNzfQ+xW=kgcM3ZK_6+gg-DfhjVh5FuRON-Ppg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] security,lockdown,selinux: implement SELinux lockdown
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>,
        matthewgarrett@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 27, 2019 at 12:04 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Implement a SELinux hook for lockdown.  If the lockdown module is also
> enabled, then a denial by the lockdown module will take precedence over
> SELinux, so SELinux can only further restrict lockdown decisions.
> The SELinux hook only distinguishes at the granularity of integrity
> versus confidentiality similar to the lockdown module, but includes the
> full lockdown reason as part of the audit record as a hint in diagnosing
> what triggered the denial.  To support this auditing, move the
> lockdown_reasons[] string array from being private to the lockdown
> module to the security framework so that it can be used by the lsm audit
> code and so that it is always available even when the lockdown module
> is disabled.
>
> Note that the SELinux implementation allows the integrity and
> confidentiality reasons to be controlled independently from one another.
> Thus, in an SELinux policy, one could allow operations that specify
> an integrity reason while blocking operations that specify a
> confidentiality reason. The SELinux hook implementation is
> stricter than the lockdown module in validating the provided reason value.
>
> Sample AVC audit output from denials:
> avc:  denied  { integrity } for pid=3402 comm="fwupd"
>  lockdown_reason="/dev/mem,kmem,port" scontext=system_u:system_r:fwupd_t:s0
>  tcontext=system_u:system_r:fwupd_t:s0 tclass=lockdown permissive=0
>
> avc:  denied  { confidentiality } for pid=4628 comm="cp"
>  lockdown_reason="/proc/kcore access"
>  scontext=unconfined_u:unconfined_r:test_lockdown_integrity_t:s0-s0:c0.c1023
>  tcontext=unconfined_u:unconfined_r:test_lockdown_integrity_t:s0-s0:c0.c1023
>  tclass=lockdown permissive=0
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  include/linux/lsm_audit.h           |  2 ++
>  include/linux/security.h            |  2 ++
>  security/lockdown/lockdown.c        | 24 -----------------------
>  security/lsm_audit.c                |  5 +++++
>  security/security.c                 | 30 +++++++++++++++++++++++++++++
>  security/selinux/hooks.c            | 30 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  7 files changed, 71 insertions(+), 24 deletions(-)

While I remain concerned about the granularity, I think this is about
as good as we can get right now without potentially messing things up
in the future.  Applied to selinux/next, thanks Stephen.

-- 
paul moore
www.paul-moore.com
