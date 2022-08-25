Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B575ECAAA1
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 20:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbiHYUQb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiHYUQb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 16:16:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35154E2F
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 13:16:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u14so24676208oie.2
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ZgMztXruLTQO3eAHZM3AUoKaeW1NNMBMEA9g/nqS2+A=;
        b=V+MSpLhvK8ssXGPdp14E3Ri6AchW6Y3VHw/jB6f5/AKqqQko7X8aNurUl4RLb72MsZ
         okmh3UnwXBSORU/nhLDTx7QiRTGLyPLw//bVgebEcvivfKJFsLRKCZNB4Afg0odq6J9x
         3pRFjQnMbyrG7xpNr5VLpPh3BLWrhghNX/84tHCpQRzy2JGXiOcJpdOmVVhUH141huwa
         88IrqtZJZ01TgFaJdXmpBGGIsdtH5HI4fnQTTr63vh6cvnbzqkT4xmQ91cuxhBJEUfTy
         UzPyqf4orx7HxhRsd9C8N4tNVViGr55f96T/lAw/mSSIE/JRrVMmHLvBXGQO6l7LBjAK
         dsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ZgMztXruLTQO3eAHZM3AUoKaeW1NNMBMEA9g/nqS2+A=;
        b=RfFdQRLaqTKM+l9rJDF2I6PD6z7qVx2vG3lffxwlPHXgp6F4pDepucIJOcmxTiSBjC
         am6sIbGerFokwwTtsj65r9aGzCC7aKOaVmLxC8q+xcbiQm2dHN9iGiSKc7Ok1UcFx3xr
         3rA2rPWx64zTqyyQR+0g1NDjq5VZofegGni+Nmil/XaFHa8BmcRGm2IGnxkovkxA3mJK
         Hn/6wDM9WqcD/3ysDwBxpmSQbXJcen2TJpMoyzzKKS6zzjLvCc04JMzfDWO/RxVYbgDl
         +tdy2hgulUL2lWnS2n6+h4uVo1zKOUl/SpDDVnAYwFkbkIwkXyeZEdSKmUJrj7HOYVEN
         JiGA==
X-Gm-Message-State: ACgBeo15L0DIpOigg36C3vYKz4dsVoMqiKUTWQoUB/xu8gHgAEObuRXz
        O+nShPnpC/PFz6dDZtslLfefK9HCE5Epa/6yF8zb
X-Google-Smtp-Source: AA6agR78DIO4fW/hzdD/9maYcjYjTnNaSDTYqfBmdDvTRTsnC2UvFGSMNjsKpscEsGQiOyC568EFzpSmRfHv5SBhCcA=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr287762oif.136.1661458589545; Thu, 25
 Aug 2022 13:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220823144123.633721-1-mic@digikod.net> <YwUzfXaUFrPtnSMJ@nuc> <818012cf-c404-ec58-6c21-87ebee6a2522@digikod.net>
In-Reply-To: <818012cf-c404-ec58-6c21-87ebee6a2522@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Aug 2022 16:16:18 -0400
Message-ID: <CAHC9VhSF7UkpVjwyn3W75UA+6h7S5+S=fs52F4ZUwMM_STH1PQ@mail.gmail.com>
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_REFER
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 24, 2022 at 5:04 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 23/08/2022 22:07, G=C3=BCnther Noack wrote:
> > On Tue, Aug 23, 2022 at 04:41:23PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> >> With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
> >> globally denied-by-default access right.  Indeed, this lifted an initi=
al
> >> Landlock limitation to rename and link files, which was initially alwa=
ys
> >> denied when the source or the destination were different directories.
> >>
> >> This led to an inconsistent backward compatibility behavior which was
> >> only taken into account if no domain layer were using the new
> >> LANDLOCK_ACCESS_FS_REFER right.  However, in a scenario where layers a=
re
> >> using the first and the second Landlock ABI (i.e.
> >> LANDLOCK_ACCESS_FS_REFER or not), the access control behaves like if a=
ll
> >> domains were handling LANDLOCK_ACCESS_FS_REFER with their rules
> >> implicitely allowing such right.
>
> "the access control behaves like if domains not handling
> LANDLOCK_ACCESS_FS_REFER are in fact handling it and with their rules
> implicitely allowing such right."
>
> Is this better?

I'm still looking at the actual code changes, but I had similar
problems as G=C3=BCnther while I was reading the description.  While the
new text above is different, I'm not sure it is significantly easier
to understand.  I might suggest adding a short example to the commit
description showing what happens now and what will change with this
patch; similar to what G=C3=BCnther did in his reply.

--=20
paul-moore.com
