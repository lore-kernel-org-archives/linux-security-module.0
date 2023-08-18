Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2312EE498E
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Aug 2023 18:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379309AbjHRSCB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Aug 2023 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379330AbjHRSBc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Aug 2023 14:01:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C32D59
        for <linux-security-module@vger.kernel.org>; Fri, 18 Aug 2023 11:01:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565ece9636eso886298a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 18 Aug 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692381690; x=1692986490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYBhb547ncMi3wuUeN47Qu32Xgp7Mgncg35363KdjMY=;
        b=e8Q1lB1q/5WpShrGBZOlVAiH4jHMVpOUuaOqIgAkBvaujIY8uzpya5ESLBaG3ix8nb
         FHUNTjwbqpghd11R4Q+G2sU0BtL4HRvOe1svnqwdTQzKOSgMk3Jyhq+iNgCDAYct9ETm
         lToX6VZMeh+e1RqjKH4Tk4VV24davAJq54e9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381690; x=1692986490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYBhb547ncMi3wuUeN47Qu32Xgp7Mgncg35363KdjMY=;
        b=DqCelfwJaWB6vScWquPeFP0lV09awjaCo7J4qHU2HEWdav/zI1GUkSE6AnrcUiL+95
         pvI2HVSBJL6OnBgCXzO/smNZ8XXUDL8hwvnKuIQC9kRx2A0OvWFyawN4c1dw6kiZZIIA
         MfxQTAD7Kmx1SxyxDE9hzdv7vnULVyKBtdGZdhoYlu1lQJS6d9WvsMgVlHg4TqDH0DVu
         J44vO55OM4XpOrzUEuXMQ2v7ENt86GSrGBnjJY1Vuh1rxy+28ml95F5AJQ5QJCoKc16Y
         PqSuvCwLgWCs96QmeiZq0ENgtNLplmk3DnJF+RcssDrHOYKAdetAri5834Ql/9gze29i
         s46A==
X-Gm-Message-State: AOJu0YxHgjb4O7IfGQw8o1n3Qhxn3v5LZMtle0N+qc0RHIPz0VWM1W75
        cMVsitpQMkgjXO0ef0O0xrFLng==
X-Google-Smtp-Source: AGHT+IHK7p11ROoF/GBRTRYvtIRFeZ79ofBB2FpFJ+GKVFcVF+S6Zy6V00Y0yvuoDiCNKNnDjwtw1A==
X-Received: by 2002:a05:6a21:3984:b0:135:10fd:31b0 with SMTP id ad4-20020a056a21398400b0013510fd31b0mr3565014pzc.15.1692381690480;
        Fri, 18 Aug 2023 11:01:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78095000000b00687087d8bc3sm1883813pff.141.2023.08.18.11.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:01:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] integrity: Annotate struct ima_rule_opt_list with __counted_by
Date:   Fri, 18 Aug 2023 11:01:15 -0700
Message-Id: <169238167326.1457886.12849640803727382145.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817210327.never.598-kees@kernel.org>
References: <20230817210327.never.598-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 17 Aug 2023 14:03:28 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ima_rule_opt_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] integrity: Annotate struct ima_rule_opt_list with __counted_by
      https://git.kernel.org/kees/c/a4b35d4d05b9

Take care,

-- 
Kees Cook

