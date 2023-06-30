Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD40FEB64DD
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jun 2023 03:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjF3D1q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjF3D1n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 23:27:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BDC35A1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:27:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so5764a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688095658; x=1690687658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRN6qWsVu0mB1ku4fPTz09e+/lMrKAM1ocX41R6p7Gk=;
        b=soWnwzrTr9hKh0W3aqnqEN2ZcGCbufVtjT17NhzB4wsFdSXzlRDGZgj6fxlukK2MKn
         YsfdXQvKUaTg3JKW/BUM6tobUWXWciOdUv6jl2E9eGPg7EF9YV9WKQTP8f7DKOxvu/9v
         s0rl20ZxzAyL45Vn6SpokC6QcAWuBapLJ+lbzu0NiNjwXKd2V6pthnHll0r/Y//8sStD
         Q3AlCzR1YqBW3ivuGi7BdN4m+7yc8x0Lpugwqq1AcUmogleDxYyjpH+tgbsa3kYkEQUX
         7vuSoyoAL717NLP88dWX6Xdmdf6/O+jP6oRM+a+ef9t+WWGF53lUE1yxazd3gLXJe2yo
         25jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095658; x=1690687658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRN6qWsVu0mB1ku4fPTz09e+/lMrKAM1ocX41R6p7Gk=;
        b=ETmZDAu0iVl/AByMUxLkL95yLvJjS7Az29v4Ha9WfRzZ18p6ExCtypjtIlFilX5lu9
         Y6CtznpYBfyHIlXQlN7Gvm818R2fiVipBPv/BFa1fOzi0e6dEFyH6APlKIQJgoINFQvO
         a1F2w8RCVWbr1Lrzy8WwqdIHYvAkeS+RyKSxrsPnz5hNu4YXbXG5/cMntcdDLLq5JX5y
         uxLvSNIXC2xogL5mgteQmNNEfGi9fx2BH9ehD+goPpGSdGMJ4b9ADm+cOt/h8mxLkbsX
         9SbL6WhAeC9XV+HoFNcFmOpBWp+ZAcoIJ4BQ69RSdMwi5sqqUFqgcEJRsHpz7jfEl9ka
         KF6w==
X-Gm-Message-State: AC+VfDzXGKiC3LsBTFNcmZR+hsY51/uAK/+wCtHRtbjOa5ir20aXZ/cR
        3wL2jhVDhrpkNJf0IfJl9BdWnqIKhg0TnljRcnqNzA==
X-Google-Smtp-Source: ACHHUZ7ZUJn81AAcrfvyG7dBaqTj3v9qdubJ+SWeC50c+iFxxUBBGPEqwxbk0ZLgn2ugtR9tB/qjhK9XVxx7Es5LYjQ=
X-Received: by 2002:a50:baaf:0:b0:510:b2b7:8a78 with SMTP id
 x44-20020a50baaf000000b00510b2b78a78mr218316ede.5.1688095658215; Thu, 29 Jun
 2023 20:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230629233454.4166842-1-jeffxu@google.com>
In-Reply-To: <20230629233454.4166842-1-jeffxu@google.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 29 Jun 2023 20:27:02 -0700
Message-ID: <CALmYWFtj1rEwJQmE4nrpCswxWf8TuW9T-p7NVGsA39JoZm+nnA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: mm/memfd: vm.memfd_noexec
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 29, 2023 at 4:34=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
Please ignore this, I resent V3 with a cover letter.

> Add documentation for sysctl vm.memfd_noexec
>
> Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=
=3DgZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admi=
n-guide/sysctl/vm.rst
> index 45ba1f4dc004..621588041a9e 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -424,6 +424,36 @@ e.g., up to one or two maps per allocation.
>
>  The default value is 65530.
>
> +memfd_noexec:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This pid namespaced sysctl controls memfd_create().
> +
> +The new MFD_NOEXEC_SEAL and MFD_EXEC flags of memfd_create() allows
> +application to set executable bit at creation time.
> +
> +When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> +(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> +be executable (mode: 0777) after creation.
> +
> +when MFD_EXEC flag is set, memfd is created with executable bit
> +(mode:0777), this is the same as the old behavior of memfd_create.
> +
> +The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> +0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +        MFD_EXEC was set.
> +1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +        MFD_NOEXEC_SEAL was set.
> +2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> +
> +The default value is 0.
> +
> +Once set, it can't be downgraded at runtime, i.e. 2=3D>1, 1=3D>0
> +are denied.
> +
> +This is pid namespaced sysctl, child processes inherit the parent
> +process's memfd_noexec at the time of fork. Changes to the parent
> +process after fork are not automatically propagated to the child
> +process.
>
>  memory_failure_early_kill:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> --
> 2.41.0.255.g8b1d071c50-goog
>
