Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D67C001DC
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Jul 2023 14:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGaO5W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 31 Jul 2023 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjGaO5V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Jul 2023 10:57:21 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0939C6
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 07:57:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5838881e30bso51281277b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690815439; x=1691420239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quZ65fsDTDMU4Sigezf7NU4XwLJapG5s9gUccJ8izRc=;
        b=Nz8KH5RDWuQ8LPZOzvITcDlyhkUuiXGvxkzpyNTPxcIZ1tlAKwvUyel2KCgDqBtaPc
         gjayjdKt8Z96NXhePI4Yw5JHs3KnBe5FzdLIOHaJN7zzsW9pVCBwZoDR+cZpJcBIZK28
         Vu2YzYTC/zQnoZdqXMUYbeI0nYoRSpxE8gJTNePhFkkSsGTNPj4wjSt5maevPjkDoWr8
         V0sYcAvtZr2SWDh472yROd+JjpSYSdDpAfTLfekqVVfBmyom5IWsLmgT5/tJupPQXZNA
         lDHqCKO19BNj89vP8N6qSlHlPwm3lmjZZHizQV1vdUKR1hCN8f7JqPyxpuy4Gty9OvrL
         jnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815439; x=1691420239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quZ65fsDTDMU4Sigezf7NU4XwLJapG5s9gUccJ8izRc=;
        b=el/qFWtQMpgMRIYLY+nsdm1RN3nhTEA9JwX8L8ItopLMPMIqQ/B9cwtZj3HxWW6dw8
         iCn8dJQul2NOkPWbbb/LjIOwhNxXObOiQLaAKlxesqRiXZNbMRO4zWmP8ejrcqnNnYnj
         6F2VXGwJzHW5JjHY22GadpvjNFLOgwSS1jE+R0g8Zdn/kxUTJSn3UcGHSea+Sm8IT4xx
         U7vls2HZDhEb1yOR70ZOFM4yXGfa5zL/5gCoTu7UDrxCLoKcrDfTDcOv4plmBu7YWlWf
         edeWKMigTQ+z6bp/w+vydoRevwSUoaoHStjaNEmGN/kX2T5wuO3Hppa0v40Bsw25Vok5
         6Yqg==
X-Gm-Message-State: ABy/qLbOej5zlLKZMsKPO0ib2ZmcF9fWvNW16wQYjlruCXOLHr+G20Hk
        j1jBl6STnCxmCIJkICv88c0AMnu5kOHB/RBNoDpaA6XKeA/eNiQbnA==
X-Google-Smtp-Source: APBJJlFsGJ9uYaEDCke8dccR7KzZ/mY5m2FR7xM4YxZGK16777syGzWaO5hoI8nvpQHapjL+AxNPLMj1X9BNEbjClJM=
X-Received: by 2002:a0d:cf46:0:b0:577:1533:ea95 with SMTP id
 r67-20020a0dcf46000000b005771533ea95mr10763794ywd.28.1690815439180; Mon, 31
 Jul 2023 07:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230731103822.GA4093@wind.enjellic.com>
In-Reply-To: <20230731103822.GA4093@wind.enjellic.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Jul 2023 10:57:08 -0400
Message-ID: <CAHC9VhT_6yv=hgCLUMYf154=-ARY5+V+FMi_0O+_t2rsb341Eg@mail.gmail.com>
Subject: Re: TSEM feedback.
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 31, 2023 at 6:39=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
>
> Good morning Paul, I hope this note finds your week starting well.
>
> We submitted the patches for the V2 release of TSEM three weeks ago.
>
> We received some feedback from Randy Dunlap on some documentations
> issues that we went on to address.
>
> Haven't heard any reflections from you.  Was just wondering if you
> were swamped or had possibly missed the submission?  We didn't include
> you as a copy on the notion that you didn't need two sets of patches
> landing in your inbox.

If your mail hits the mail archive on lore.kernel.org, it is almost a
full guarantee that it has hit my inbox and/or the patchwork instance
I use to ensure nothing is missed.

As one would expect, it takes a good deal of time to review a patch
submission as large as TSEM, and the rather ornate language used in
the documentation only slows the process.  Rest assured it is firmly
on my todo list, but please understand it will take some time to
properly review.  In the meantime I would encourage others to
review/play/etc. with TSEM; nothing builds maintainer comfort quite
like seeing reviews from other trusted members of the community.

--=20
paul-moore.com
