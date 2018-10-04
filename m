Return-Path: <SRS0=kUy5=MQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE3C64EBC
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Oct 2018 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8E520684
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Oct 2018 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jq6MlHiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8E520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJEAgd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:36:33 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34177 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJEAgc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Oct 2018 20:36:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id 184-v6so4275005ybg.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Oct 2018 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YZF2kZ3iG0YmjmrTtLhI4Qs8+EJcx02N0LLLJQzoRyY=;
        b=jq6MlHiD/czH0qPiR6JGrFIAFyJU5HtMWdjEl7tTe6k8WwK7UDwEvzj3kV1PQVU13r
         s0P8aUuvvV8uIXOcUyE9Qv2WNeKBEAR5HsKkrt32lBQUy0G/f9K6JmK6WY88UFR7j6+G
         PtuCliwFqIDH8NO/yiJlKNCMgKwjO1Wlpdys8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YZF2kZ3iG0YmjmrTtLhI4Qs8+EJcx02N0LLLJQzoRyY=;
        b=K+MOopMgrzuqUG1JX2SCWBm190dNc5yLUKAKjK0+xteui52YXvPKPBquP1K85OZW4m
         AvEsIjlplDERCjRp8f6RU77FcoVjcKy6ExwAW5wWv2rdXzVbHhlFuOwHZhnmpeY3PrAl
         nCed11t6nFR6kOOn0NgfeLS/iwezzg3dVgIOvh1w3xigbHt0VCPrrgzm+EK4OmZsmwP0
         wWPKsVrHt5acZzMi9tDnW0u6h9t5+ohCDtiFJCG6fHEdQqTvdDlBOQ3IKDf/xm4rTEuH
         GinQFePLrPXQrPmUTKR4/dPeSjBP/nOkhFD6PLhupZI6W5NHpuZPp5QK4CArHHFX0WqD
         izcQ==
X-Gm-Message-State: ABuFfohRwzvXYzms17EaosGI3+IstOpINry9zahYtNTrBq7jUp/Yin2Z
        UzBH8XWomFQ9UWQ2fJoRM3H40weAg88=
X-Google-Smtp-Source: ACcGV622XNaOewB9ANWuV5S8IG54xFAqRlX5KOrhn/X4p1W1zgXLWgR9b9FyC8fQffuGTDHMVXyGMA==
X-Received: by 2002:a25:860c:: with SMTP id y12-v6mr4319251ybk.101.1538674932895;
        Thu, 04 Oct 2018 10:42:12 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x185-v6sm2112916ywd.40.2018.10.04.10.42.10
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 10:42:11 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id w7-v6so4260594ybm.7
        for <linux-security-module@vger.kernel.org>; Thu, 04 Oct 2018 10:42:10 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr4285875ybk.209.1538674930444;
 Thu, 04 Oct 2018 10:42:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 10:42:09 -0700 (PDT)
In-Reply-To: <QlTG4dQyxeJfFuHbDfQswJ-FPDDZAOn5tyV7I0oSdFNyYRX1WrbTJP9zw0SWoAb0b0m1bE0Do2aHxA8V0qzX9X8g3hsiLLdw7EuFLbAjcAM=@protonmail.ch>
References: <20181002005505.6112-1-keescook@chromium.org> <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
 <alpine.LRH.2.21.1810040416500.13517@namei.org> <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com>
 <f016c836-cc9d-0a2d-fb18-930b43898cdf@canonical.com> <CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com>
 <QlTG4dQyxeJfFuHbDfQswJ-FPDDZAOn5tyV7I0oSdFNyYRX1WrbTJP9zw0SWoAb0b0m1bE0Do2aHxA8V0qzX9X8g3hsiLLdw7EuFLbAjcAM=@protonmail.ch>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 4 Oct 2018 10:42:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJksqQDOYZy_HyQNgUTNauOw40APfKSop+viXh5bcXmSA@mail.gmail.com>
Message-ID: <CAGXu5jJksqQDOYZy_HyQNgUTNauOw40APfKSop+viXh5bcXmSA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 4, 2018 at 10:40 AM, Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
> Sent with ProtonMail Secure Email.
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Thursday, October 4, 2018 6:18 PM, Kees Cook <keescook@chromium.org> w=
rote:
>
>>
>> I don't want to overload "security=3D", but we can if we want. It would
>> be as above, but a trailing comma would be needed to trigger the
>> "ordering" behavior. e.g. "security=3Dselinux" would disable all other
>> majors (retaining the current behavior), but "security=3Dselinux," would
>> disable all other LSMs.
>>
>> -Kees
>>
>>
>
> I don't think giving such big impact to trailing comma is good idea :)

That's why I prefer a new lsm=3D instead of confusing security=3D. :)

-Kees

--=20
Kees Cook
Pixel Security
