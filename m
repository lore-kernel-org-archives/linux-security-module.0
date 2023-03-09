Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65502C6FD1C
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Mar 2023 23:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCIXp0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Mar 2023 18:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCIXpY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Mar 2023 18:45:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EBEFCBEB
        for <linux-security-module@vger.kernel.org>; Thu,  9 Mar 2023 15:45:23 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso8008280pjb.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Mar 2023 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678405523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joK1iLs9YJ7HYS6kSzl2rZbt/PuSCafHcz/xrLe7jGo=;
        b=bJFC/lAxRaHk+mJqFSplHzH565OHscdq/bY/9CaWiQOg8ijsx/QWt+KjSnlFrcR+xR
         4I1MJqqwVstjWukbZY6XdRsy9bNQSN/vXnzu/GEMWzZTYVGIw135HxxyK2++JSB1jCwy
         bP7vzNceDo79Gggr+2xGhQQcleXlWrDTzDQUlFJMW8ZQE1RtzafjjlEqdvydZ4fz8OTD
         Y6VnRI+sJpkqAnzSvB0URvwz+nejVbgHzuJuAT+kACmJuxKTloH6ahZu62YHu56dSLtK
         pQvzd09T9tcOEZKDsBrx1zvXbF56C2jQ+8HzE0y00ywXkIa00ErlFPhBOm7+RwTIXAz6
         4XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joK1iLs9YJ7HYS6kSzl2rZbt/PuSCafHcz/xrLe7jGo=;
        b=xks2Xq4rZQxywLvGMsMH2uYTqB6RjqSXAW1aooJXTBnYentxRdP7XZmDtLfK5koRr6
         rrAA/o693Y4ZNGWymN6WVsB+a8mZPGKuWxUAxcTRYIVsRlmBCxKx7hU+22QJ//etG/GQ
         ME6tOSHn4hufGYNPrpVhCXfjkBJU0QJuAMklG01ldd9J+T6y9jOZBSlpMF+8YQJTMhbS
         h1EaWvNCxb1SOiqGVubqX8nwnAPT5QHgaVIExnxDhl6z/NIKsZmxwNuORmkfy8L1aRuU
         cjIFhT01d8ExvZyHwooJWQvcI2jbqA+3+pdD3XIWhvDhJjZ8gOXKvRLURluwC0+t8pLi
         9JPg==
X-Gm-Message-State: AO0yUKWbQ9bGOKKetA2sz0j9VevxYVau+m+SyP8ZKwoDlOF4IvPnXtAT
        mrDkXk5zA82Z1HvhbzhJ+fKaeqKDTyMYJ2m9okNO
X-Google-Smtp-Source: AK7set9RqqZSFE77wMatvCcE/t3Pq4nptu8SVgLeYYg9Y3Xs8cDwkREIi1LMWiYTY9uI7Ha62QlVV3bMgcEiTsZhy9c=
X-Received: by 2002:a17:903:485:b0:19a:f22b:31d4 with SMTP id
 jj5-20020a170903048500b0019af22b31d4mr9142241plb.7.1678405523115; Thu, 09 Mar
 2023 15:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com> <20230309085433.1810314-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230309085433.1810314-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 18:45:12 -0500
Message-ID: <CAHC9VhSuXxpS_eae0gi4zGFYWEXrxFZD7joaV-qhNmmvf_tcMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] security: Remove integrity from the LSM list in Kconfig
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 9, 2023 at 3:55=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Remove 'integrity' from the list of LSMs in Kconfig, as it is no longer
> necessary. Since the recent change (set order to LSM_ORDER_LAST), the
> 'integrity' LSM is always enabled.

See my comment in 1/3 about "always enabled".

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

--=20
paul-moore.com
