Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D5C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ED02082E
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJBOD5c1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfDJRJs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:09:48 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40302 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJRJr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:09:47 -0400
Received: by mail-vs1-f67.google.com with SMTP id f22so1796948vso.7
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNQVfrVuhTyjxHi15oDnjEfjux7E73KgI0KREivdICc=;
        b=DJBOD5c1u3JylxT8EWxXeMpj9PjuFWxXq9Hk1O/1OM6dAO2/E/7rnWIeoojUQZdLYA
         413nQH+EpQyTf5DtTCvVCSlp/1QoXbnkoWCVTeDJYcnsJRRa7sI21qYsEshBzFfDgDsD
         1AKFm2IQSIyJAruHrfbSnf9xdsVDHLcjbdWAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNQVfrVuhTyjxHi15oDnjEfjux7E73KgI0KREivdICc=;
        b=oKtUH7p103CqdZHC72OEYqR/TEXMpKlfco/BDh9AovUQkyjy1+PrpUiOMv3h95Iuzn
         TvIgzLXiifLRHBEDPFPyHKFl2wsJwhk8h5Er9wriZVv4cvqMXus1G3ZJSH87+TEIxszb
         QXQdRjc/Phot3R+gml/CdSSxIOBRNAjgSoje0NhM8F4K1XrYcumAvRCNhQbuDnHiq6db
         8LFq3CdfGu00wFTONhri3Vk55GR8+5pRlOT2eLlL85ufY0IrFE1HDOUyy5NgwS48biuy
         JtEBHMnkrpHR7fbC40VZzdcOj96BkVyt+xHC4ICXUGTP5KJpyIOhSPC6MP/Q/aaqgBo+
         +YoQ==
X-Gm-Message-State: APjAAAXFTB9c7oCW977k1ZPDvvJnvz2XeV2X8Fv+obcllyqC6izcpHlC
        gTfdRFbCUgQZNkJnf/kFE4jZpFy863g=
X-Google-Smtp-Source: APXvYqwIbBxnE/zdo592vHcmFIAVLbBIB2GshAcWMJsRCiguWiAxcn58W97SmKLsatxzeYVBSLMWSw==
X-Received: by 2002:a67:ea53:: with SMTP id r19mr26421358vso.12.1554916186540;
        Wed, 10 Apr 2019 10:09:46 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id r3sm1320308vkr.18.2019.04.10.10.09.45
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:09:45 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id x194so742476vke.0
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:09:45 -0700 (PDT)
X-Received: by 2002:a1f:ab8d:: with SMTP id u135mr21669317vke.80.1554916185066;
 Wed, 10 Apr 2019 10:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165434.206579-1-mortonm@chromium.org>
In-Reply-To: <20190410165434.206579-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:09:32 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKid6ggjD7G=qLoAGdpprxQiXziKu5g=rcGw+d0sUPr9g@mail.gmail.com>
Message-ID: <CAGXu5jKid6ggjD7G=qLoAGdpprxQiXziKu5g=rcGw+d0sUPr9g@mail.gmail.com>
Subject: Re: [PATCH 01/10] LSM: SafeSetID: fix pr_warn() to include newline
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 9:54 AM Micah Morton <mortonm@chromium.org> wrote:
>
> From: Jann Horn <jannh@google.com>
>
> Fix the pr_warn() calls in the SafeSetID LSM to have newlines at the end.
> Without this, denial messages will be buffered as incomplete lines in
> log_output(), and will then only show up once something else prints into
> dmesg.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/safesetid/lsm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index cecd38e2ac80..2daecab3a4c0 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -91,7 +91,7 @@ static int safesetid_security_capable(const struct cred *cred,
>                          * to functionality other than calling set*uid() (e.g.
>                          * allowing user to set up userns uid mappings).
>                          */
> -                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions",
> +                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
>                                 __kuid_val(cred->uid));
>                         return -1;
>                 }
> @@ -103,7 +103,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
>  {
>         if (check_setuid_policy_hashtable_key_value(parent, child))
>                 return 0;
> -       pr_warn("UID transition (%d -> %d) blocked",
> +       pr_warn("UID transition (%d -> %d) blocked\n",
>                 __kuid_val(parent),
>                 __kuid_val(child));
>         /*
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
