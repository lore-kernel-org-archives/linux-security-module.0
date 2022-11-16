Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4675C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 02:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKPCXR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKPCXQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Nov 2022 21:23:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603D30572
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:23:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y4so15148415plb.2
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4P5R+pdJzfRaQ+AiQYGJf7nLDcFIhpzWyHRJ4pEd7k=;
        b=0xeei+KEJma8+7bCjJrBSqZjdASMgcsxxs7iBDy5axKbfmOawgDdQntBJX9iA0y3Ge
         G6Gy1lMN7tVXY2Erbb76siigFkxaswLs7VYRgoTjaGshahNNjOqjwx5v5wJRytpY8Xd5
         tVNEa2x58PhBlszKhe0120hr6QLpbK0xrUE9DHxnKTjbryjEExS+/FQTTo2Y+MwW4JxO
         YmtV7aKAch9dQQBlV4USkMttE26WXWzNrXEvNs0Fpp/ejI47FEjJXb3CdRF93FhNYge2
         hGhEO1az74j7uWL6nd2Nd1m458v15dGCsAYKs7BvVaZHg8M+3N1enW67CqhgyJLVbLv8
         SdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4P5R+pdJzfRaQ+AiQYGJf7nLDcFIhpzWyHRJ4pEd7k=;
        b=UVph7tOpzXKNY9CGI7t07CmjruqAzKT1x4VPJ4REwSWI+hDrrSwez1R8ZtHMAgJQOV
         7Z3+UyrIncCCRO+4Nh6d+HJgbPzpwg/z3L6LKxObpjR47FCcIrGBH0tElZ5z5yx7YbVE
         JDovWzwnOgfWMVcydR44DCqWrcPORaMnKhaCdVsgo2ndjDiLTt15ezsg+R4KuwfVK+Wd
         9plku5h2szColInVqRTyCDuDAPr8WhUcq714CMBRzLXKmGde8f04DMg7OYO2CGaPhdx2
         hLA1TethbrsUnhvFbQbs8BI4fZ9FZY0dLDXb5iX725mm/jSi7WGfFKapYMwwdgPNXuH4
         yDiA==
X-Gm-Message-State: ANoB5plJHCK6Gwm2WSgv+y/31klrVPMTxrYmX2yuDtQeUWdO3IoIuHed
        PbG/7ksGuCbq/1y0QAUHms4N1Yt0nG3FvcB+gI47
X-Google-Smtp-Source: AA0mqf4tyxqZL6dNinYLGxLglLTMkXwHLPOJ0/bfZpgKfism41nxlS7vrc0NoFjHNkpVYJJZvklKnBS1D73LJ26ZaSs=
X-Received: by 2002:a17:902:74c1:b0:186:c3b2:56d1 with SMTP id
 f1-20020a17090274c100b00186c3b256d1mr6847477plt.15.1668565394715; Tue, 15 Nov
 2022 18:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-3-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:23:03 -0500
Message-ID: <CAHC9VhQjtU0DFoVGav-nBh-09QXh+X=Cf8RgJz6nAjvcyNQ-5A@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/4] lsm: Add missing return values doc in
 lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Ensure that for non-void LSM hooks there is a description of the return
> values. Also replace spaces with tab for indentation, remove empty lines
> between the hook description and the list of parameters and add the period
> at the end of the parameter description.
>
> Finally, replace the description of the sb_parse_opts_str hook, which was
> removed with commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()"),
> with one for the new hook sb_add_mnt_opt.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 123 ++++++++++++++++++++++++++------------
>  1 file changed, 86 insertions(+), 37 deletions(-)

...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index f40b82ca91e7..c0c570b7eabd 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -176,18 +183,22 @@
>   *     Set the security relevant mount options used for a superblock
>   *     @sb the superblock to set security mount options for
>   *     @opts binary data structure containing all lsm mount data
> + *     Return 0 on success, error on failure.
>   * @sb_clone_mnt_opts:
>   *     Copy all security options from a given superblock to another
>   *     @oldsb old superblock which contain information to clone
>   *     @newsb new superblock which needs filled in
> - * @sb_parse_opts_str:
> - *     Parse a string of security data filling in the opts structure
> - *     @options string containing all mount options known by the LSM
> - *     @opts binary data structure usable by the LSM
> + *     Return 0 on success, error on failure.
> + * @add_mnt_opt:
> + *     Add a new mount option @option with value @val and length @len to the
> + *     existing mount options @mnt_opts.
> + *     Return 0 if the option was successfully added, a negative value
> + *     otherwise.

I really appreciate the effort to improve the LSM hook comments/docs,
but the "sb_add_mnt_opt" hook was removed in 52f982f00b22
("security,selinux: remove security_add_mnt_opt()").

-- 
paul-moore.com
