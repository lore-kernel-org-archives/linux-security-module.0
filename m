Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61BEB64D8
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Jun 2023 13:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFUNb7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjFUNb5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Jun 2023 09:31:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDCE59
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 06:31:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bffcd3cd3f1so428861276.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687354311; x=1689946311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxfsUugMBYcIOsGuQu6JwBoanrGO3rsZrRGg4MZWgyY=;
        b=INVoaQVRowSXFMdEkw5cqhZQf8sAX/E8EsT7/QKbzfW1FdCpsLAs2cDwf0yK+iDFo9
         AoXF94/RtdnfEVCexO2o8UZRlBeSc0I3we3rGhjJjTMoAXzjvlU5YLqV9i36FtpyQ8cN
         KTv58M+Es7TeKzDrrVa9Ngw18hvSDsT2qwx+cR8JZ/efqHjwtjU7mZ/RYMlUnL8aiUwC
         SXHsJa+wBHuxiy/+s5RwsxLvlbUJgokrnMwh97Pi2TuKVAQl0n9pW8DM/yxInCFgbTLv
         vRD2+cDwOeXOEOuqAK+LkWNYK9vuQTTiizedHQzSb2TWx6dCsJqsjVOBTyA5FhDllqRP
         ahOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354311; x=1689946311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxfsUugMBYcIOsGuQu6JwBoanrGO3rsZrRGg4MZWgyY=;
        b=ODwRSFLFy9bKtNMkgtFOoiZjCTcGC0IpNQ+MfNC+pI/DrhXsoisPkcj/Zb4Z4Bm+mA
         NTPom5Tz9bJe2wz0JsoZZgBBXKLzX78hw44XQW4BoS63p2MQkcyhRvhhKsjDg37a8ugj
         nuCa5K38ydH/xVSxzd5nw22EqayTRulW2i/Zl402YYJVB3jEI9o6vciF/k4a05YuAJzW
         qpkufqHx+4jVTNtblyY/3q0oUWm+frzu71oUFLQ63J2ZzafcmNM9Nzw3xtxwGokTSg7O
         WVZr0de3f1ryEBcCm7W3wF/nHHonu2LjdOf3y18oTBIqtYuHfpqjRX8YNsZ2Lknf0tg2
         p+gQ==
X-Gm-Message-State: AC+VfDzh8MCeV7mtJ7w8wKG7NHrPiXT7oCt/2InkKyrIxVFmWTYIJGHK
        hNymWSJxifvEM8pNr4M0h5/YROfp+7WdFXqYfUdIhbhTpy6ijMU=
X-Google-Smtp-Source: ACHHUZ6H7BwzOeBZ5HHBikhghKIBlc0YzD3ldBJbWs4n2/YE2Kthbs0BLKFkb/v8wuWQjt2QKxMoues4/+Z6iRj69b0=
X-Received: by 2002:a5b:c6:0:b0:bc8:6354:5fb1 with SMTP id d6-20020a5b00c6000000b00bc863545fb1mr9912884ybp.46.1687354310801;
 Wed, 21 Jun 2023 06:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230621074418.497564-1-cuigaosheng1@huawei.com>
In-Reply-To: <20230621074418.497564-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Jun 2023 09:31:40 -0400
Message-ID: <CAHC9VhRT2q85gV31-a5SP3-Qz9Vnnqsn4snqRtkyE7YoTAj-nQ@mail.gmail.com>
Subject: Re: [PATCH -next] device_cgroup: Fix kernel-doc warnings in device_cgroup
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 21, 2023 at 3:44=E2=80=AFAM Gaosheng Cui <cuigaosheng1@huawei.c=
om> wrote:
>
> Fix kernel-doc warnings in device_cgroup:
>
> security/device_cgroup.c:835: warning: Excess function parameter
> 'dev_cgroup' description in 'devcgroup_legacy_check_permission'.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/device_cgroup.c | 1 -
>  1 file changed, 1 deletion(-)

This looks fine to me, and considering that it is both trivial and
does not contain any code changes, I've gone ahead and merged it into
lsm/next.

--=20
paul-moore.com
