Return-Path: <SRS0=pW3O=MX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F5FC32788
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 15:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF722087A
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGmW4Qvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF722087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeJKWmF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:42:05 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46266 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeJKWmF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Oct 2018 18:42:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so3706815ywa.13
        for <linux-security-module@vger.kernel.org>; Thu, 11 Oct 2018 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vhHOhK6qIvD03E5j82CJydF0koblL9qnnu+X5reyDNk=;
        b=hGmW4Qvy01/0H+oeR2sl6jaevIREHbKsBEeL0KgYGYQVDxkg3lguRP1SCw0IB6mIEM
         lcd9gOlmm+cx38qOiw+KFjaAweXG14NOjliA2sDOs3WJoL7RKDrGdDEFBEwiDMjwPNDH
         CUSMpMk/UmVS/aA67+3zE8Mn15lZsTiNbaGas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vhHOhK6qIvD03E5j82CJydF0koblL9qnnu+X5reyDNk=;
        b=Ff+mXjTYovAbzinU012gUwbf0+9WbWwb10EXl8ODpkoQ2zQ5nyGW2dLGs0xUMxpHkr
         JAJ1RCldErhfNip/Xm8D/eDG1BQg8KN/DECFwviH+JXpC7tM7/gdn6ep4rcXgr/SS5Lv
         oP64TCOCF0A+EeuJLdabe6yygO2ZZzp2V5KJ7Z1VGMRS2Wt4TAU36UsZjHokj9A6Zpc4
         UNKHybdFa3v+0mnfn7HibMVr6M9PtbtU0LzXiKq7aQmXU5IMELoVmzPrxfjUJmFa1pOz
         rubyFjyfVj3juD9DvP/1/ypJLjG3688zv+FKSxnL8GD+wCYB7Gy/gcWwapgym5cyMG2U
         GbKg==
X-Gm-Message-State: ABuFfogKo48kwkbBwgR39dj2yuiN5Fu9gt29WrdIsx6jYOtFNYy6g3rr
        9bXA/plafMpaTJcFUet3pJrDtDu+trc=
X-Google-Smtp-Source: ACcGV63WWzQTnMVP3skiHmg4WcTIwT6dteR69YO8rbZWzAAKQ8kJUsvRMf8+hRLQR5O6GtN39NeurQ==
X-Received: by 2002:a81:2d89:: with SMTP id t131-v6mr1063641ywt.222.1539270868321;
        Thu, 11 Oct 2018 08:14:28 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id x185-v6sm15208401ywd.40.2018.10.11.08.14.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 08:14:26 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id y14-v6so3722289ywa.4
        for <linux-security-module@vger.kernel.org>; Thu, 11 Oct 2018 08:14:26 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr1074104ywg.353.1539270865726;
 Thu, 11 Oct 2018 08:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 08:14:24
 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810111443500.25845@namei.org>
References: <20181011001846.30964-1-keescook@chromium.org> <alpine.LRH.2.21.1810111443500.25845@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 08:14:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
Message-ID: <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 10, 2018 at 8:45 PM, James Morris <jmorris@namei.org> wrote:
> On Wed, 10 Oct 2018, Kees Cook wrote:
>
>> v5:
>> - redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
>> - dropped various Reviewed-bys due to rather large refactoring
>
> Patches 1-10 applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> and next-testing.

Very cool; thanks!

As for the rest, I could post some examples of how the new CONFIG_LSM
and "lsm=..." work (and how they mix with the "legacy" options). Would
that be helpful?

-Kees

-- 
Kees Cook
Pixel Security
