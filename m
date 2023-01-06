Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7EAC63797
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Jan 2023 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjAFVWV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Jan 2023 16:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbjAFVVp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Jan 2023 16:21:45 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3665840BF
        for <linux-security-module@vger.kernel.org>; Fri,  6 Jan 2023 13:21:37 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g68so908684pgc.11
        for <linux-security-module@vger.kernel.org>; Fri, 06 Jan 2023 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nscYWIrRbImg5p/QoRk2LSGrqlyTf2VI1IplInec8Wc=;
        b=OFMqJwDh4LPlA8Zz0KkW+6L0lbDp5CBZT442htKuEMpSYVMwigNk/wZNJ/o4hBuaFh
         ajmV8QQVjaoo5threYy36tdtqt1EhF9E/zt71sO8JeN61VKNPFhixgkgl/eltSBtaFkD
         mjk3bqGc5Nnb4VCF32DJ5EmUwQsprMpdIsTJAq/GAIcvAHfhhxqBaVHcLN4YHWNHJc87
         PIIbKEX/IeSAMbdHXkLSrbhTALuSspTTs/2+rG7mOYc1S/yOB4NR2FKJyMTm/L1S5sMG
         rgT4LlTO+ZI8onf3a0CGKwe9b5KovL+jO7iWAPBiZaG82cAt3hksehXJrTae7Gp6bFnj
         HioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nscYWIrRbImg5p/QoRk2LSGrqlyTf2VI1IplInec8Wc=;
        b=zDxpcKiuNHDKwwclduS5qXxezjOv19MBx1mgb3wCrCDuavZD2Uxwl+mE4YG9Atuinr
         CkCxTeExY36LK3RbbrRPuDpE0crcb3PDGA1LI43feUXePRBb8Nu5hp5yoeebWCjMCvfm
         H1myQqh7tc32/E3JRTsN2IV1kLu2AtkorPfEOTOsQ9Cx1eTNtMEaYJjSwvXWgWio5PZz
         XF6IZtCqaUjkW4AFZA1Ya+oZJslmNTmHA7Y/an4A9r2sblROSWki1G3sxV6661pKIOok
         J0aAVR3qiqfDrbGZf5lFW9W8Pfk/v20DZUtIhrG1GMs/fHF3arbmbRMCP+c+0UTaGMVK
         YGMA==
X-Gm-Message-State: AFqh2kpTqgj0aeu2GxA8rz7jRD3UShTEu7V/Udy1FR5HmxVo9OoEgL0K
        aKfoEGJjssaXufAoT0QBd5cqPHq4TO0g/FWpbx4c
X-Google-Smtp-Source: AMrXdXvkkuKmNAQAxLd52KKekhGg5ivFAYkK2Xs/NEmo0uPlOMRrJOs8uvswb1oxToVMHYh+Nap64bsEhlypn23a1Vw=
X-Received: by 2002:a63:db51:0:b0:477:96e2:9065 with SMTP id
 x17-20020a63db51000000b0047796e29065mr3301051pgi.533.1673040096986; Fri, 06
 Jan 2023 13:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20230102204525.4399-1-rdunlap@infradead.org>
In-Reply-To: <20230102204525.4399-1-rdunlap@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Jan 2023 16:21:25 -0500
Message-ID: <CAHC9VhSGTKKbQkhjQcpfYxsh=9z-TzrWaiiGmNWqt8jAgD8xKg@mail.gmail.com>
Subject: Re: [PATCH] ima: fix ima_delete_rules() kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 2, 2023 at 3:45 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use correct kernel-doc syntax in the function description to
> prevent a kernel-doc warning:
>
> security/integrity/ima/ima_policy.c:1964: warning: expecting prototype for ima_delete_rules() called to cleanup invalid in(). Prototype was for ima_delete_rules() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  security/integrity/ima/ima_policy.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff -- a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1955,7 +1955,8 @@ ssize_t ima_parse_add_rule(char *rule)
>  }
>
>  /**
> - * ima_delete_rules() called to cleanup invalid in-flight policy.
> + * ima_delete_rules() - called to cleanup invalid in-flight policy.
> + *
>   * We don't need locking as we operate on the temp list, which is
>   * different from the active one.  There is also only one user of
>   * ima_delete_rules() at a time.

-- 
paul-moore.com
