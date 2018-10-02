Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F0C004D2
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 16:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBC72064A
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 16:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AuCTrPWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC72064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJBXia (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:38:30 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37326 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbeJBXi3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 19:38:29 -0400
Received: by mail-yw1-f67.google.com with SMTP id y14-v6so1040965ywa.4
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3KjyMR08bmd9YZmum53kS/V/XW07F6Rp6ifIGqpPh2M=;
        b=AuCTrPWPVkjdDsflK4b3v5Nu5F/wwaZZXIByGqgI4xNRRHvWAYxNTFlAZcADMZCmiK
         NQJOPjWhluzj0VV4MUcGKvZKg4vjuWEs+7asTr7PD8ZltruGrOB0CBGbCVWuvc5q7yYd
         KZWRcJ2X1SYMqNEa2sf+yZh7xIBMqw4pgbv08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3KjyMR08bmd9YZmum53kS/V/XW07F6Rp6ifIGqpPh2M=;
        b=O5emwU1T0B5iBKdr93K/m8B1Rmh8NRr9WKrVmLx/3vSPdTIklC6RYL7CslBDj65KHC
         5cfJ9/ZQqBEauaxqdF6209JcDZdDpfoYsVsciA0dOk4Vi1Gb4YoTZC43TZRlWU6ex9EP
         n2sTXX8RRjSNeYk58G99gYdpayLxOn30laejZk+E9cltjxQqnfjmh0di1qr0dT3qD6Wo
         Wab3mAom3Fqyp/UV8eTnswtpxpgw41//D4SyZMvZdIp6SkIUgfZDQhWNsR9Lc8qfnhVp
         qf5WbHlE9Skqb1wQXCnjsEO9mqYvaPvSmgLeCosQ+0hiTgmTk4fBEQcSmeEUz11ID5W3
         EkPw==
X-Gm-Message-State: ABuFfogT4N8SCBZVwsDDYwSzO7zPHUryF7kfzCjaNkLfVcVexYX90d3N
        aLSln44pEEiS/hdFIwIoIRuYVTGMxBg=
X-Google-Smtp-Source: ACcGV62Lleh4LIU+VLLKgJMWcPZRavWgD9zPgb5MixfSBbAAMZvJB4QThdZ//wIWaoySkdjp3y6uRg==
X-Received: by 2002:a81:ae04:: with SMTP id m4-v6mr8969989ywh.474.1538499248720;
        Tue, 02 Oct 2018 09:54:08 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n207-v6sm5360857ywd.31.2018.10.02.09.54.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:54:07 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id h1-v6so1078435ybm.4
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 09:54:06 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr7666980yba.410.1538499246259;
 Tue, 02 Oct 2018 09:54:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 09:54:05 -0700 (PDT)
In-Reply-To: <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 09:54:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
Message-ID: <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 2, 2018 at 9:33 AM, Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
> It's always documented as: "selinux=1 security=selinux" so security= should
> still do the job and selinux=1 become no-op, no?

The v3 patch set worked this way, yes. (The per-LSM enable defaults
were set by the LSM. Only in the case of "lsm.disable=selinux" would
the above stop working.)

John did not like the separation of having two CONFIG and two
bootparams mixing the controls. The v3 resolution rules were:

SECURITY_SELINUX_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
SECURITY_APPARMOR_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
selinux= overrides SECURITY_SELINUX_BOOTPARAM_VALUE.
apparmor.enabled= overrides SECURITY_APPARMOR_BOOTPARAM_VALUE.
apparmor= overrides apparmor.enabled=.
lsm.enable= overrides selinux=.
lsm.enable= overrides apparmor=.
lsm.disable= overrides lsm.enable=.
major LSM _omission_ from security= (if present) overrides lsm.enable.

v4 removed the per-LSM boot params and CONFIGs at John's request, but
Paul and Stephen don't want this for SELinux.

The pieces for reducing conflict with CONFIG_LSM_ENABLE and
lsm.{enable,disable}= were:

1- Remove SECURITY_APPARMOR_BOOTPARAM_VALUE.
2- Remove apparmor= and apparmor.enabled=.
3- Remove SECURITY_SELINUX_BOOTPARAM_VALUE.
4- Remove selinux=.

v4 used all of 1-4 above. SELinux says "4" cannot happen as it's too
commonly used. Would 3 be okay for SELinux?

John, with 4 not happening, do you prefer to not have 2 happen?

With CONFIGs removed, then the boot time defaults are controlled by
CONFIG_LSM_ENABLE, but the boot params continue to work as before.
Only the use of the new lsm.enable= and lsm.disable= would override
the per-LSM boot params. This would clean up the build-time CONFIG
weirdness, and leave the existing boot params as before (putting us
functionally in between the v3 and v4 series).

-Kees

-- 
Kees Cook
Pixel Security
