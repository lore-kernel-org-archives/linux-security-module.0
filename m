Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D58C38A2D
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Oct 2022 23:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiJYXz5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiJYXz4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 19:55:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FE46176A
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 16:55:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o70so16816297yba.7
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 16:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5LRtOwsgMjiG/T/RlhpMeb6c5Pcvl4gwCXqW6XiBfE4=;
        b=oqkI4n2vgRR+nNW4d1fbfl1EA+nb2KiU9LcyVN7KL7UF82vCTxKTJ9RUIDDE08yV6o
         BkMBrzTw7mGZzJgUTxhksfjhp+DuOp5C2S5O4h3kyAaMTQNAPOffo/1qFxDU8MxEga4m
         LpdH+Yj2/Esm/sfAJNS7DJ4Yu7jIn5jnDMHRbY/4Zo5G+Fws5KMPlAvuZH69meYRuYEZ
         xv43qEUhmALTyKgBoFCmaRncdDmNvx/1l/NK8m3yhLHztuyOw85gyfq75f1mzNH9RuDI
         hH7lO16ZJ7siEe23xCq2q11wR0OXFx5RR/SMPcAZj7KRwpKfUfnJb3q2z9jTdd776mcJ
         wSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LRtOwsgMjiG/T/RlhpMeb6c5Pcvl4gwCXqW6XiBfE4=;
        b=u41OJTSaeFZ3juT0l60GofYasD+8vvHyn+MA78SEwt1EoOdnao5a5UaCAhUjseXfMq
         h2LVHgHOxbY5Yy1oD6SEKlQnHaoA9tXGXYnkrfBrA/q86KV+0G8kGaFhAsuKhM6ZjHFQ
         XoNjBZsVORljZGfWZ6oIYdCPtmIQS9f0vA/ZYf3AXRLgs25ks5g1kLzvvnv+BfHPm7oZ
         NKjlfZPWWWFyql3/knRZbQzLNmwZEc0Prmdcz5ZRwZeRwkpOTHSz3wHCIYyciG18liaJ
         zPIcddRdVxWuuloYK6nz97oviV+v6eR0LKXzX8cKxWprVglTtRx25lGul081Xu3lKp5F
         lkMw==
X-Gm-Message-State: ACrzQf25XrGMtzNCQe6q37afpJhEN/8iTzte7Wo3iFbBxMNS5NGwc4mZ
        sKs7R2yrgU3h6CYGCGE22UO8rhRKDuIThsl25iKkfaym6hIB
X-Google-Smtp-Source: AMsMyM7So/swA7ZwWg9ScX70E9TrwvHn2c19g3aFsY/RmSWsTd44UqTuK1tWCum3OOqWOE8ueUeFLBEmaavufLD2Nq0=
X-Received: by 2002:a05:6902:124d:b0:66d:5ce6:5924 with SMTP id
 t13-20020a056902124d00b0066d5ce65924mr37564019ybu.320.1666742153855; Tue, 25
 Oct 2022 16:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221025060333.4295-1-liubo03@inspur.com>
In-Reply-To: <20221025060333.4295-1-liubo03@inspur.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Oct 2022 19:55:42 -0400
Message-ID: <CAHC9VhTBQx4sW1JLyopvTHjVS9ZXnGO0gRHZ372iqS8rmiMNZw@mail.gmail.com>
Subject: Re: [PATCH] audit: Fix some kernel-doc warnings
To:     Bo Liu <liubo03@inspur.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 2:04 AM Bo Liu <liubo03@inspur.com> wrote:
>
> The current code provokes some kernel-doc warnings:
>     security/lsm_audit.c:198: warning: Function parameter or member 'ab' not described in 'dump_common_audit_data'
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  security/lsm_audit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 75cc3f8d2a42..ea5d35dce674 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -190,6 +190,7 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>
>  /**
>   * dump_common_audit_data - helper to dump common audit data
> + * @ab : the audit data to fill

When we need to comment on audit_buffer structs we usually refer to it
as "the audit buffer" or similar, e.g. kernel/audit*, and in
lsm_audit.c the term "audit data to fill" is typically used by the
common_audit_data struct.  Please update this patch to something like
the following:

 /**
  * ...
  * @ab: the audit buffer
  * ...
  */

>   * @a : common audit data
>   *
>   */

-- 
paul-moore.com
