Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7446C4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 23:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKIXe0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiKIXeX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 18:34:23 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD4C2E9E1
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 15:34:16 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1322d768ba7so530069fac.5
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 15:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H69kl+BZM9mu7qjWYSR2TO9mixGoFPcMaOgCgdllHIk=;
        b=dvBjk7jh2RmiQDokWvgnl8UAvVwjeY7pponPtbdQi2EZH3TyC18Lf8J27d+Zf3h5XJ
         LcBYXHMsrbqWdOPzpCZs2ACpNfJj5DCZtxA3OCOlcP8sXdHvhKVjrWJDMoF6KM90cfre
         95AiSG3scJDkrlY0xuFJhpf4rbGyBW74OxzkEDlo3NvDAtGCDQAt8L1SMdYXxIN3frcN
         aXswrZwe/L3NrE3e3RGpA2NSvmGOklrnSx+8ks9+cFXhUZtXQ6CtQAk9A07V5JmVWL4+
         oVBwsyEnImP7Qpsz3dr89BhfS5Xp+bdaNGnc0zSjU6XaYK7EQilj5Z25r1cl0yCjmdTq
         72iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H69kl+BZM9mu7qjWYSR2TO9mixGoFPcMaOgCgdllHIk=;
        b=eJhX3KDiKHwbl6HIcyXrQVZk1huMN6nQiY6K8x8wBFmE/lPsMVxDM82CgMRvMf+73+
         c7dqwOR4eb/Yf9Bo/1leGIlsNNUZ5aYPhXP6K9qFlCSyAA+n/jngSIU+GPRZoj70UZYF
         DiLXWTQ2KJxV2ckV7biT3kxCfW3jPch6E2uKz2gEh1EjE0TOBL8fUJ9qVihru5fT8H49
         h7KmXekr5XCUUF0JECdMk7s7gN45ynMy4B8FllXx4XV/ax1iUhRxx7pOaSNhHlEHqi40
         NEiD9a+Jmvf8XWDH1aJ68bXRwzqlufMgu+2BHzZr3l1ZExrtQp7lQGjWhwv7I7H4yYPl
         cdfw==
X-Gm-Message-State: ACrzQf1Jl6Pku5S5TGFSZjzJNnJij5dFIKJYQOJEUM8h0EfmF8u61wSo
        Lklw6+5pTN1Sh7IdJ0SxwzMJvSq4oqeo1XHCGcep
X-Google-Smtp-Source: AMsMyM4qjyOq5UcyAbU3fCpDSj4bUqTY7Ut2MpZl3tFuZIzDm04cYZA3gQPE9DPmipGtZc6srHv0u7g3+BFjwprwPfc=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr37063952oap.172.1668036855843; Wed, 09
 Nov 2022 15:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com> <20221025184519.13231-4-casey@schaufler-ca.com>
In-Reply-To: <20221025184519.13231-4-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:34:05 -0500
Message-ID: <CAHC9VhRv2biawm1w=8sR=DMBhy8FLNwxRch13j4EUBkCRUpxrA@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] LSM: Identify the process attributes for each module
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 2:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add an integer member "features" to the struct lsm_id which
> identifies the API related data associated with each security
> module. The initial set of features maps to information that
> has traditionaly been available in /proc/self/attr.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  include/uapi/linux/lsm.h   | 14 ++++++++++++++
>  security/apparmor/lsm.c    |  1 +
>  security/selinux/hooks.c   |  2 ++
>  security/smack/smack_lsm.c |  1 +
>  5 files changed, 19 insertions(+)

Everything Greg already said with one additional comment below.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index dd4b4d95a172..46b2aa6a677e 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1608,6 +1608,7 @@ struct security_hook_heads {
>  struct lsm_id {
>         const char      *lsm;           /* Name of the LSM */
>         int             id;             /* LSM ID */
> +       int             features;       /* Set of LSM features */

I understand why you called the field "features", but I worry it is a
bit too generic for 32-bits of flags. Let's make it specific to the
LSM label attributes; how about 'feat_attr', 'sup_attr', or something
along those lines?

--
paul-moore.com
