Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E243C04EBF
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 00:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6428720834
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 00:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oNri3LK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6428720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLEAba (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:31:30 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39920 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeLEAb3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 19:31:29 -0500
Received: by mail-yw1-f66.google.com with SMTP id j6so7788949ywj.6
        for <linux-security-module@vger.kernel.org>; Tue, 04 Dec 2018 16:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HI/NZ9Pl5qptqj62pAcHKWa5WGEOJQMbSZKqqsDETqg=;
        b=oNri3LK4r0hcjcqotwrisMzz2j0myVO82+wol3vLJA/0+JWznFP4USftJ1BnOBM7U4
         k4p9ifiBRgrusIoF3dsoJUWxDn/Z/wCKnYrdHNz1eeK0c2pc7hNan1R5DmhcnO78isuM
         sYxC06KfXJQ9ctqZWUQggofzDYqNjKAM740co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HI/NZ9Pl5qptqj62pAcHKWa5WGEOJQMbSZKqqsDETqg=;
        b=lZPdnE0e4ZIe6wD+pYoNZxvIjb/1vBgnJhv3aHvxnCKtDX+XUJXbbhpTzPGFy6gCTM
         kj6+ENJa/Et7Wddlgp2cAry3aq+z9OhTj9YMg28UXJx/nyNL1DibCWc72RlflklVWbUU
         5WT4oDBEhaKmgU+Kg+ZNvZkizNYVY5JMbaId5QQ5lY7ZQfv099hqL1Ws0/pXk/qQsF4h
         +LxxUPQSaryK5WkycVoHWAQx6zyHmyM5fxfxvkuVAkRQt/sfkdqNLBr3WXwHlz3dx6UO
         ubhwL0n0xHqCaA4bLfhYsZiHo8WlJA+Kt+PTjfnV4inwRhdtRgMetmLV68re40NtIrAR
         buzA==
X-Gm-Message-State: AA+aEWaLx7ajwmfkiR2R5tp34uJ2bcSKid6cjCfX5kiZ/YkcuUl2Ymfs
        K5s3K5fmxccwv3sD+bEGk8uqqMowfiA=
X-Google-Smtp-Source: AFSGD/XCQrOYJLW340LUUDxCzuQTRZEHLxzlI9wVo0fN4zTr5Nl7OOgr8BY1VMahkMmucfGjjtG7sA==
X-Received: by 2002:a81:7242:: with SMTP id n63mr7392800ywc.495.1543969887853;
        Tue, 04 Dec 2018 16:31:27 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 131sm6060669ywn.88.2018.12.04.16.31.25
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 16:31:26 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id j145so2769689ybg.11
        for <linux-security-module@vger.kernel.org>; Tue, 04 Dec 2018 16:31:25 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr20736357ybi.171.1543969885074;
 Tue, 04 Dec 2018 16:31:25 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 4 Dec 2018 16:31:13 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
Message-ID: <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> v5: Include Kees Cook's rework of the lsm command
>     line interface. Stacking is not conditional.

Can you resend this series with corrected "From:" lines in the body, etc?

Beyond that, I obviously like it. James, what's needed for this to move forward?

-- 
Kees Cook
