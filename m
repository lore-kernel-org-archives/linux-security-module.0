Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ECAC4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Nov 2022 15:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiKCPMY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiKCPME (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Nov 2022 11:12:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ADA1C10B
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 08:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 703FEB828DF
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 15:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A32C43144
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667488286;
        bh=bniCAy1g4sGfzDEIIDctFfu6afFtYgYFG63GSJYI7jg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f+Bo4acdNsVsk3QFwDOy5D3v1rTgag1bOVEIkfAzZKhfkC3vWkc4vIw++xRyV/m6X
         yfnEBhhXHsNTEGIo/O++tVC3lGrV8kCqaazslgPOng2+s03izjHf3TEwASRrIKXfbZ
         mOZFDhpBAs2iXUDS47jyum4rjkTe2xXZ1jMvJLXGLKGJkyMtuz6Kq5OMKebUQZ2eDJ
         IB2VCLQD13LJdlA4deYJXKyc7pJPKN/rk+1zmm4UsBDZg/9gARN8qPZbIGU+e9BLkK
         uk01bLk1PXjE7ZmAXkzo6hzmeaTdUKK720td/UeSNXUe5vCBrA5JNO4NqFqCwk7H2T
         eNuORb5CKZ6sw==
Received: by mail-lf1-f52.google.com with SMTP id f37so3326252lfv.8
        for <linux-security-module@vger.kernel.org>; Thu, 03 Nov 2022 08:11:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf03WyTtepDzYBBejtXglVTEv+OqbAq1Exfu+E7uPXHOJtBneGaJ
        5ig6GN0v6a+qoevfN36EjgBFQ6KhdtN4fBAZBK4NeA==
X-Google-Smtp-Source: AMsMyM4jINPb7umoaCKz8QypKSvBgLTh17Ae+KPTbRb/nAdAKOwn5WPfjW+jlk9lO3Lkc4w8ci1HePaoAiinWI+o8WY=
X-Received: by 2002:a05:6512:36c3:b0:4a4:7627:c57 with SMTP id
 e3-20020a05651236c300b004a476270c57mr12204530lfs.398.1667488284062; Thu, 03
 Nov 2022 08:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 3 Nov 2022 16:11:13 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5nwsdaG57HHkNubPptkB=_Mz68TVzmX8+Tg=ZFjMX3pw@mail.gmail.com>
Message-ID: <CACYkzJ5nwsdaG57HHkNubPptkB=_Mz68TVzmX8+Tg=ZFjMX3pw@mail.gmail.com>
Subject: Re: [RESEND][RFC][PATCH 1/3] lsm: Clarify documentation of
 vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, revest@chromium.org,
        jackmanb@chromium.org, shuah@kernel.org, paul@paul-moore.com,
        casey@schaufler-ca.com, zohar@linux.ibm.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.bouchinet@clip-os.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 28, 2022 at 6:55 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> the callers, not what LSMs should return to the LSM infrastructure.
>
> Clarify that and add that returning 1 from the LSMs means calling
> __vm_enough_memory() with cap_sys_admin set, 0 without.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: KP Singh <kpsingh@kernel.org>

> ---
>  include/linux/lsm_hooks.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..f40b82ca91e7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1411,7 +1411,9 @@
>   *     Check permissions for allocating a new virtual mapping.
>   *     @mm contains the mm struct it is being added to.
>   *     @pages contains the number of pages.
> - *     Return 0 if permission is granted.
> + *     Return 0 if permission is granted by LSMs to the caller. LSMs should
> + *     return 1 if __vm_enough_memory() should be called with
> + *     cap_sys_admin set, 0 if not.
>   *
>   * @ismaclabel:
>   *     Check if the extended attribute specified by @name
> --
> 2.25.1
>
