Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC105EB64D9
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jul 2023 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGDSdE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDSdD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jul 2023 14:33:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343210C1
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 11:33:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-986d8332f50so698051966b.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jul 2023 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688495581; x=1691087581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvbEOwmuACzLZlIyKGNPoeNAnhtuCQRGw6xxql/GyT0=;
        b=WMQG2Wa09zAmTLEemKZZ2B+/k9d5ROg3/Ze4UWWfq+waBsApwfVupdf++PItf7jpLs
         5RrLa+1aE8KwS71DF+Yt+brdKxfFXK4nrbYMJ1Zvzatl8R/P3h8GoppFih/euTafkpu6
         Mlo4iYhoNeZn85G0TF5emJA12Pkhoqdkf+YR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688495581; x=1691087581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvbEOwmuACzLZlIyKGNPoeNAnhtuCQRGw6xxql/GyT0=;
        b=T5RIRtW6u6++HD9R1LVJ/byj/Nw6PLrT7oaf5cp6mBdwZuMTopUTtmFaJKhAO8HHbQ
         AneSNh+J4O3m2NO3Ok8ffu3frtQ1Kc1uJ/sDGj0uA3txBdqhvj5rUglotvsWGGZVzzwD
         eJ+CsDrVaXlkl25ggS8RI3UbO1nr4FC6Q+75vyfBpSlYNzH/Wk6c1Su7ed9goPJHRkeg
         Xd6qIf6OZkLYUu0An7Uz1QWc/0Tkfve+AkWG6Ui3zqi7DcIpzfddRiEXl89ExOs9cGyr
         mM+nnWOvquPgjx/ahcz4Q0iORUeBLHXfl7xMyf31rM2hMQZq0i7Mha7cLDP4T0Vb5sZR
         BIVA==
X-Gm-Message-State: ABy/qLaOfoEkT/woZJO4DN7ls+NZKVekrIEGeYLdlkTqG9Djyb4NMnL3
        VNW0Lf+Tk5RJwniyEOn9UqW9ziL+wggeoGNO0cc7e6k1tkmliGxC
X-Google-Smtp-Source: APBJJlGx3lTM+CL506twufVxJycIMNPdeD9H9aZW7tPIe9ZMr86LWa6c1iW/2P9GyZtQYsURT3bsRu6S37iStdQaXkk=
X-Received: by 2002:a17:906:74e:b0:992:3aa8:b21 with SMTP id
 z14-20020a170906074e00b009923aa80b21mr10401620ejb.25.1688495580542; Tue, 04
 Jul 2023 11:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230630192526.271084-2-paul@paul-moore.com>
In-Reply-To: <20230630192526.271084-2-paul@paul-moore.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 4 Jul 2023 11:32:48 -0700
Message-ID: <CAJ-EccNa+itDRRwZJo7ukNG4VVXdZUu7h+W=7r4qvV0zSF5-cg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update SafeSetID entry
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 30, 2023 at 12:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Micah Morton, the SafeSetID maintainer, last posted to any of the
> public kernel mailing lists in early August 2022 and has not
> commented on any SafeSetID patches posted since that time.  Attempts
> to contact Micah directly over email have also failed.  Until Micah
> reappears I'll plan to continue accepting SafeSetID patches via the
> LSM tree, but I'm going to mark SafeSetID as "Odd Fixes" for now,
> and add the LSM mailing list to the MAINTAINERS entry so that the
> LSM list will be properly CC'd on any new SafeSetID patches.

Hi Paul, I've moved on from working on ChromeOS and checking my
@chromium.org email on a regular basis. I was trying to check in once
per month or so but I guess its been a couple months since I've signed
on -- sorry about that. This sounds good to me, I can't necessarily
make any guarantees that I will be a responsive maintainer going
forward (especially since I expect changes to the SafeSetID code to be
very few and far between). I'm good with whatever you think is best
here. Thanks!

>
> Cc: Micah Morton <mortonm@chromium.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35e19594640d..ad910c462cd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18599,7 +18599,8 @@ F:      include/media/drv-intf/saa7146*
>
>  SAFESETID SECURITY MODULE
>  M:     Micah Morton <mortonm@chromium.org>
> -S:     Supported
> +L:     linux-security-module@vger.kernel.org
> +S:     Odd Fixes
>  F:     Documentation/admin-guide/LSM/SafeSetID.rst
>  F:     security/safesetid/
>
> --
> 2.41.0
>
