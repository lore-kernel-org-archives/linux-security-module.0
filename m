Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27009C678D4
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 20:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCBUmw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCBUmq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 15:42:46 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC5D410A3
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 12:42:43 -0800 (PST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A89FD3F22C
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677789762;
        bh=VPNnC6C1cy3MGBtKJ7RY2J7qDK3sxM2tBtUziWuIYdg=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
         Content-Type:MIME-Version;
        b=EY+GbjazuT5xsbPweeYjnplxwl86drWyVLpbjwtvPOUdSsmUbF18VYMcPkFDOljhi
         1Bf196R6vj81u/rtNXU6I4/RZ34lbch/gor7HMblQpPeWcEeSVMZOUe+iLtwhxmuNh
         diLyIkO7D9UH+5Bk+ZrXb3w3swp17lCf4AEoknI3gpIB78JJ3Ik92/xiM3bif3EG+3
         1ZGTMmwZpci0hbesNhAeZlglMsRDrJohDJGrtN1DjUu3SWf9t3ppgia7PAuwYxn1YH
         NZAWtoOheD+MzIdUN2B1NmPZLuBEQ3kV2TZ0N8xICH9XoQ5vgH/EgG8v451AzOkS5D
         kXBrgQsvKhIkA==
Received: by mail-yb1-f200.google.com with SMTP id d2-20020a254f02000000b00a316be8a939so142276ybb.9
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 12:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677789761;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPNnC6C1cy3MGBtKJ7RY2J7qDK3sxM2tBtUziWuIYdg=;
        b=7WvT4jw1moAyrSvvF01OwH8NTuPjBatxMRa5uhl1su17QrDwP4/RbqOAs/DXwN3EDi
         k5cp7Eq/BLfMaVuKewfK0MFBKpDHFMmdpk2ncdz6aF3mdbk0PkESiZU18VxR0Fyp0Co8
         3Z0AS+mMo1Mvq6N1qLQ8ODyGIeCVfw0MhU29ezUuFoHDlwfiHC1yQ0zH01xVbE9661q3
         PQ6S4n2CFTM71fn9EZ2btIckv0xJN9CDrnYdyqkub2lrXzYDeWxSy7Q6C98NjECsep5d
         waojWuAM+QmXaDgwMwjHKU1JTrV+mzQHlCebvMnm0euDrXrPl2WIVu0mxhv5ZGtKgsw+
         ydMg==
X-Gm-Message-State: AO0yUKUG0GChrZe5FuZrjfYRYPmSZGYEHxC/ho4+doVdb6szPB6wXQya
        FlnivHHwChq/0/u0ISKlxEwWXHHXg58k1TMLXtdU6o5XXUac4sidFYJ+QA/sfIvvTl5p9BDmqbE
        f+DF1ErTbQLy/jPANj7kSUjZGVg2bHSSCkYormHQ1Cm+BFp/1h9NaGA==
X-Received: by 2002:a9d:803:0:b0:690:d198:4d1e with SMTP id 3-20020a9d0803000000b00690d1984d1emr1669424oty.8.1677789740530;
        Thu, 02 Mar 2023 12:42:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+mzZi4KGEKQQVH4HIHgt8mr09sF5ZEI/y0N5gvVHOM4lDo9PhDEhWGcQyAF/1JU7UCO5GrTA==
X-Received: by 2002:a9d:803:0:b0:690:d198:4d1e with SMTP id 3-20020a9d0803000000b00690d1984d1emr1669391oty.8.1677789740223;
        Thu, 02 Mar 2023 12:42:20 -0800 (PST)
Received: from ?IPv6:2804:1b3:a7c3:d46d:73b6:f440:93a4:30? ([2804:1b3:a7c3:d46d:73b6:f440:93a4:30])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d72cb000000b0068bcef4f543sm327296otk.21.2023.03.02.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:42:19 -0800 (PST)
Message-ID: <c010472791aa57c8ea838b5e85780f5be98898d5.camel@canonical.com>
Subject: Re: [PATCH 04/11] apparmor: simplify sysctls with
 register_sysctl_init()
From:   Georgia Garcia <georgia.garcia@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com,
        keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Mar 2023 17:42:07 -0300
In-Reply-To: <20230302202826.776286-5-mcgrof@kernel.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
         <20230302202826.776286-5-mcgrof@kernel.org>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2023-03-02 at 12:28 -0800, Luis Chamberlain wrote:
> Using register_sysctl_paths() is really only needed if you have
> subdirectories with entries. We can use the simple register_sysctl()
> instead.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  security/apparmor/lsm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index d6cc4812ca53..47c7ec7e5a80 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1764,11 +1764,6 @@ static int apparmor_dointvec(struct ctl_table *tab=
le, int write,
>  	return proc_dointvec(table, write, buffer, lenp, ppos);
>  }
> =20
> -static struct ctl_path apparmor_sysctl_path[] =3D {
> -	{ .procname =3D "kernel", },
> -	{ }
> -};
> -
>  static struct ctl_table apparmor_sysctl_table[] =3D {
>  	{
>  		.procname       =3D "unprivileged_userns_apparmor_policy",
> @@ -1790,8 +1785,7 @@ static struct ctl_table apparmor_sysctl_table[] =3D=
 {
> =20
>  static int __init apparmor_init_sysctl(void)
>  {
> -	return register_sysctl_paths(apparmor_sysctl_path,
> -				     apparmor_sysctl_table) ? 0 : -ENOMEM;
> +	return register_sysctl("kernel", apparmor_sysctl_table) ? 0 : -ENOMEM;
>  }
>  #else
>  static inline int apparmor_init_sysctl(void)

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

