Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F887C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 21:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjKJVhc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Nov 2023 16:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKJVhc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 16:37:32 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F984A9
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 13:37:29 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso2524746276.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 13:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699652248; x=1700257048; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4LwFOe4zkwKBg48YDHSwxTzhWWGv/+SKv2BKMq3x90=;
        b=ZS0Y4zSrPQMZ8GMMVJXVpsXA96lo9x4ImmgGa0Ec77clDLOPGrEyzzjKHS8cMlHfsS
         qKv9zdtIQK6fxwYl095/DliMJcMP7plBAX4M1mhVnr1odbV+lZ3GBDXiiZ7z5MM/qJR/
         Cd7UWfPJdKHB27drrQxSGLpeoCb9qLpJfOeZ/wMIIbaYRqHxDfBe66BicLgCdBkn+YPJ
         0zmkEgRy97TK2qdknYhlFOEXlgUWlwOpNIUfQbGZAlkMSyFUj/WO9zN8jlxSznYPMt7N
         btmbGtdp9RUiOmuBEwcXKF+0kA5nAkITSTRvZMNKgVgNmJyD/FAJuhTTAPf3FrZrEyTL
         BNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652248; x=1700257048;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4LwFOe4zkwKBg48YDHSwxTzhWWGv/+SKv2BKMq3x90=;
        b=M+FBWQEKN7nvIck/B+a/AZuAhbXUfdo2AtMhvI6kWm7NyrH6QIkkK/EfHCr++0T6+h
         Elv59nyTWaPpJaybCypiJpiGEPMcW1Vp5VvMbkOaJ8duW0X+yK2jGCiumO0XJUTQf9K8
         91iQpptq4mZCQIa/yvARhxFqFGolO31E2l04mgymGxrLJ/s4Nlp5DXtmByfq2RcRTPS+
         K8a3jDC0kd62pbwwOD1R6Wd99S11e+Mz6aeNonIQbAxQlK7zYw/ifoCbd8QlTBDZYU54
         //2NDAlPvr1/CqY0YuOxDEei7Hsm4YTU1m/MOuVJSzwbhpWCHqYnpGWLfLxhl8CXweeY
         mPpw==
X-Gm-Message-State: AOJu0YwplDomxdqVu3IyPz9gVUc03UpIBw2uhbegP5xhOqnp9p48ddKk
        493Cfn7VzkajHLI91UBNe7NSclfnGkIuqYOf9AMyxYztwBmX9Vw=
X-Google-Smtp-Source: AGHT+IEDScOWa/Zv9QA3w8qGts//YfBR2sf6zfI0h5p5KYfTrTqmMA4YsjadCpeuaH1P3JI1Oh90QHcSgL1R92s9xPw=
X-Received: by 2002:a25:cc95:0:b0:da0:6179:4294 with SMTP id
 l143-20020a25cc95000000b00da061794294mr382660ybf.32.1699652248299; Fri, 10
 Nov 2023 13:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20231110173442.79462-2-paul@paul-moore.com>
In-Reply-To: <20231110173442.79462-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Nov 2023 16:37:17 -0500
Message-ID: <CAHC9VhSYO637Q+VE3ypBgvZcUa1X8_FvWmkiC-BGx5deDi_=Cw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update/replace my old email addresses
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 10, 2023 at 12:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> I was recently reminded by someone who was unable to reach my old
> email address that I really should update the kernel's .mailmap
> so that people looking for me in old commits can reach my current
> email.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)

Merged into lsm/dev-staging.

--=20
paul-moore.com
