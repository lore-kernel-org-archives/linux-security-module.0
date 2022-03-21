Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E782C433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Mar 2022 17:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiCURjO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349426AbiCURjN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Mar 2022 13:39:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673A18B798
        for <linux-security-module@vger.kernel.org>; Mon, 21 Mar 2022 10:37:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so31391411ejb.3
        for <linux-security-module@vger.kernel.org>; Mon, 21 Mar 2022 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n0Cyy6sE5ez/LBL91UzE7qo7B4HGwRn4htwPLu7D43w=;
        b=BDbvDD5rAsVlZQodi9IiKxV9I9qo942+X+0lVAzpxFmUB9W3HcGau4/NqeDwN0AnzY
         3QzjOfDjYNQXn59QGxEtrU4B94ADELaKYZ0kqm3u7WPw2hHas36P0XJSUSXtwIP4kB/J
         w+q1l/dGYFZ8+BzuswafySc2VMUyUS84XyEm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n0Cyy6sE5ez/LBL91UzE7qo7B4HGwRn4htwPLu7D43w=;
        b=OY97tsTVN+off6bkoV2NFhhePmiDowHvVCqOmiBASRPUP2dafeQcm0YpzmiGEljHOJ
         CSdWRpu0887Xo7umoGjNVE8gAYfqMgCKDcUDDB14N3s7pY8wnmb2uP7hAsj0KYBk9jW1
         qOpiDlMIfXTJ0nAx67zTKzTegk3+BBrDzWLELDdgWArdVX3FbALDr0BKdTHJ/pF9m0aJ
         /ZJhAki40Qcw68L+JS4LspjMx6MwzNoSNJVpIMOtFa6z8xy1nFXiAh5ejVk2OVPWMePB
         CfrmxzNVw1Lz8gXvAQmkughdOjtoT9FfKD1DQCcoHw+k9+55TiinTdCExd4K5TAxjhty
         OuOg==
X-Gm-Message-State: AOAM530O9RamoEiyOnrR5g/g13a1oYnpuOSOPAXkaEISJEbPZqBguOVB
        ucsxeL7EO/g8vnFl/ASH9ntmNeLGhjfmJdNe9kgZ4gyCu3GVY2cw
X-Google-Smtp-Source: ABdhPJwMV+aKnppISSLu5O+KrQJbuTxl6FDfrgq3AN2QcTU+OqBr39t1xc+513T3CjLB65wX67CO5qywru2NKUTU688=
X-Received: by 2002:a17:907:6d9e:b0:6df:bb09:10eb with SMTP id
 sb30-20020a1709076d9e00b006dfbb0910ebmr14743292ejc.409.1647884265650; Mon, 21
 Mar 2022 10:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220321115913.478505-1-mic@digikod.net>
In-Reply-To: <20220321115913.478505-1-mic@digikod.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 10:37:34 -0700
Message-ID: <CAADWXX_06uyx5KLE-6pv6pqQJ5qH4EqYiYK7rGK3zMyEZjW4dw@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock fixes for v5.18
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Christian Brauner <brauner@kernel.org>, Tom Rix <trix@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 21, 2022 at 4:58 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Please pull these Landlock updates for v5.18-rc1 .

Micka=C3=ABl, both your pull requests (this and the 'trusted_for(2)' one)
were marked as spam for me.

The reason seems to be that you're using a SMTP host that doesn't
actually do modern anti-spam measures (no DKIM), and while it does do
SPF, gmail really dislikes it.

There doesn't seem anything in particular standing out in the email
itself, so I suspect your hosting provider (seems to be infomaniak.ch)
ends up either being in a block of IP addresses that is also being
used for spam, or it's just allowing a lot of spam itself.

Some people think that gmail is being way too restrictive about these
kinds of things, but since I hate spam with a passion, I end up siding
with rather strict spam measures.. Honestly, if an email provider
doesn't do DKIM in this day and age, it's not a very good email
provider imho.

               Linus
