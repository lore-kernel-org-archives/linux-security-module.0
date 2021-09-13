Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2AC433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA0860F8F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbhIMQSP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Sep 2021 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346117AbhIMQSO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Sep 2021 12:18:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23392C061574
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 09:16:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso404611pjb.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IDZIxlJ99gLdFkYdOSMzYolkAWVQKBtzOhQTZ1gDmSw=;
        b=Xe77udHSg1RQKT3n2dzL86D+5A6b6RwlPTuOttOqXmLHwGuI4yHdyam7xuO9y2Nx4l
         Rnn39mkf6qBKwDkVtnD0NelaokpRhFdbrJMH2N6qjJuLWHmteAopctN5/88j5ZMhxMcp
         dkA8UmdRwlj885/53PXQ9mhH5whyWMn062qVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IDZIxlJ99gLdFkYdOSMzYolkAWVQKBtzOhQTZ1gDmSw=;
        b=cCNSgGepiYqFF4rniaMUf7FtVYM1f2JJEsE7LoPf51UaZ1MR3ukYIrM58kzCEYwDXi
         EqFIJdbGnFP4ksQDzuSQvLM1C2KpSzgBjwov7j3bg+WGrZKxk5pP/Gouh50+MVwaua6V
         TmkpXfH0L5GpG3y43kpuMdWaccJnI3GOafASEZxMhGzuWl84aqMydpDqCEDADeZMgC6m
         kq4ORercyxiMA+l7Ayk2zyJb4HB04qTK3yIusCbaNjg2ioal5ZOt9KN0erRXLZPYptGx
         pcrkp/B9f/x/tKQZwM6iuSBTjXBRF7ZAe0W8LuLQpETG77E+dXud+hofJuEPvH2CGCzX
         U35w==
X-Gm-Message-State: AOAM530kom5KNPto51UoCHsxwjX82YW4Cygo9XGChSdrzpOoR+pLulJe
        2VvqYZbaaJZn+pfScPfIwSWpZQ==
X-Google-Smtp-Source: ABdhPJzxadjqW2LJU4GyD2BIzxgOGOyVfpRbJb916IoUdjLS/cdFgxKDZaq0XT9SbyZ/m9uvG3JARA==
X-Received: by 2002:a17:90b:3a8c:: with SMTP id om12mr348392pjb.137.1631549818658;
        Mon, 13 Sep 2021 09:16:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm9403659pgn.36.2021.09.13.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:16:58 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:16:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] landlock: Drop "const" argument qualifier to avoid GCC
 4.9 warnings
Message-ID: <202109130912.F061D2E1@keescook>
References: <20210910223613.3225685-1-keescook@chromium.org>
 <b269cdc1-a4f0-d614-f026-dc0f7c455da0@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b269cdc1-a4f0-d614-f026-dc0f7c455da0@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 13, 2021 at 01:19:19PM +0200, Mickaël Salaün wrote:
> 
> On 11/09/2021 00:36, Kees Cook wrote:
> > When building under GCC 4.9, the compiler warns about const mismatches:
> > 
> > security/landlock/ruleset.c: In function 'insert_rule':
> > security/landlock/ruleset.c:196:34: error: passing argument 2 of 'create_rule' from incompatible pointer type [-Werror]
> >    new_rule = create_rule(object, &this->layers, this->num_layers,
> >                                   ^
> > security/landlock/ruleset.c:69:30: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[]'
> >  static struct landlock_rule *create_rule(
> >                               ^
> > security/landlock/ruleset.c: In function 'landlock_insert_rule':
> > security/landlock/ruleset.c:240:38: error: passing argument 3 of 'insert_rule' from incompatible pointer type [-Werror]
> >   return insert_rule(ruleset, object, &layers, ARRAY_SIZE(layers));
> >                                       ^
> > security/landlock/ruleset.c:144:12: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[1]'
> >  static int insert_rule(struct landlock_ruleset *const ruleset,
> 
> I guess this is a bug in GCC 4.9 (i.e. missing automatic const upgrade).
> Couldn't we backport a fix to GCC 4.9 instead?

I don't disagree, but I'm just trying to deal with the fall-out of
-Werror. Perhaps speak up on this thread in support of deprecating
GCC 4.9?

https://lore.kernel.org/lkml/20210910234047.1019925-1-ndesaulniers@google.com/

-Kees

-- 
Kees Cook
