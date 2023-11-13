Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA7C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 19:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjKMTXX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Nov 2023 14:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTXX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Nov 2023 14:23:23 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C91BB
        for <linux-security-module@vger.kernel.org>; Mon, 13 Nov 2023 11:23:20 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7b3d33663so56091127b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 Nov 2023 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699903399; x=1700508199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2dJtpXWc4gbVVGH7hGW/Ogsws4nDmHKXMPz4NZ8krY=;
        b=DPcS5aTXoqirkmhfKdBuaYV8rzkXuyngL0DhhWh6rYrKl/XkrGHSK1GAbRndLdq6nO
         8G8nUQDMPgnw5Um+Q2weXJIqihjnxCkZpYMYcCigmT0YcBRuHxH54nRAQYSwFQL1F+xR
         Xx7DtJ1plGh/08O1bU35vGXADMiUKEUlv/tbvLfmLIoYyHRazndgGWpSiJ9o0Ur86Oyp
         v8ixPkivxBSld58YO+fhHLnO4ibZSEKwLN81Tfj8gmsSumTD9LYgyKbglLESIm/aHTLS
         nxK6zOrbx63Q3VoCSPGkK6dVDbuF4gSr6LjtnSQZfwfIrxk7PB1TNLu9GsghGcBZI6Cu
         IzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903399; x=1700508199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2dJtpXWc4gbVVGH7hGW/Ogsws4nDmHKXMPz4NZ8krY=;
        b=uWcT3pTtnonVMEEo+Bb1abpZ30jaAP6KNtCwCPhP1SI+T4XUtgGghcTKiA80MP51ns
         wAKT6RWWHU1QicRQ9T5sFylp0ErAmIqwwlhlR16SX2uqjyOaH2UinSsvPLVzWz6lKV+6
         uu/nu+YbcpKnRvyllbbaMlIgK8beg1P1csvfgDoimbI2Bnu10hI6Zva4mwOO6JgOKxZN
         RyBETOaGgVexQ0ezRoHM8Vjk7fjf9tMNs/d3R+HacjNSqs/JcNfTAOUmi7NRPRgC6WcH
         g9ONiJZfE8xtJvo/8BxHQ9brjI3XpcITPgQXXklmL0cwcgUA1iZ+DFLYhIpG8eKmiIvk
         WF9A==
X-Gm-Message-State: AOJu0YzVmYUXMF6/YZzgF5oyCX0cQjDOLEd5L6j8uEv4b0N1xFO+2ZJg
        0hIkaNHTDj+Ezgae1dnYbHq6g3cpU8/6HuiJd9OdO7MOyyeLMn4=
X-Google-Smtp-Source: AGHT+IFaUCI/IBwhjm+t6hxj+bmnnobIrpPQFRlrLJbtPTHh7qPgFZJ+g7aZOa0BJOiuCDwc3EdY2iocDW4W2jWJAxE=
X-Received: by 2002:a25:dd4:0:b0:da0:470c:868f with SMTP id
 203-20020a250dd4000000b00da0470c868fmr6020448ybn.51.1699903399117; Mon, 13
 Nov 2023 11:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20231113192125.57117-2-paul@paul-moore.com>
In-Reply-To: <20231113192125.57117-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Nov 2023 14:23:08 -0500
Message-ID: <CAHC9VhQ26h=4N0iBpcZDHLdafBGFUHuuO_WaiJ=4Oe0R2+Dmug@mail.gmail.com>
Subject: Re: [PATCH] mailmap: add entries for Serge Hallyn's dead accounts
To:     linux-security-module@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 13, 2023 at 2:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Serge Hallyn <serge@hallyn.com>
>
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)

Merged into lsm/dev.

> diff --git a/.mailmap b/.mailmap
> index 2ba581ebb2cf..35086f4a7961 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -535,6 +535,8 @@ Sebastian Reichel <sre@kernel.org> <sebastian.reichel=
@collabora.co.uk>
>  Sebastian Reichel <sre@kernel.org> <sre@debian.org>
>  Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
>  Senthilkumar N L <quic_snlakshm@quicinc.com> <snlakshm@codeaurora.org>
> +Serge Hallyn <sergeh@kernel.org> <serge.hallyn@canonical.com>
> +Serge Hallyn <sergeh@kernel.org> <serue@us.ibm.com>
>  Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
>  Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
>  Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@intel.com>
> --
> 2.42.1

--=20
paul-moore.com
