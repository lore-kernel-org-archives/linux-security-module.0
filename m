Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A83C25B47
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Oct 2023 21:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbjJXVTS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjJXVTO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4054510D4
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6be0277c05bso3952825b3a.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182349; x=1698787149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGAEInJILplp/po0Ydj4YdfWGw7IxU1M9ZsiqzzkF1U=;
        b=cRjSaLQJUrwa4AUcp31Zy8L/hLnp9LV1jJM3rtfxSp0iEh6TzfZywczgLftJcAe6O6
         P5DKVganNb5q4f8FiSyxdqlDhwvzrNVx4epmbJfnTLEQ1LmZTOFzUdCa7AKIrqzFnJl1
         qPciOj0QsJ8/02Ht8xDTcHk6dFCrjSCosrVcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182349; x=1698787149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGAEInJILplp/po0Ydj4YdfWGw7IxU1M9ZsiqzzkF1U=;
        b=iou6/z+gAA+XCjNHkueXflk0VlsYMTd8CZgpTwCPQN05/0SpHs3u1cg7DR60R9+g4f
         iYqXGwlnWUvUxCwm8DRn6It/RUBjbg9CyD8s1II9gi4nImP25/kR0ApdGSKRX0y+jZkV
         dLkR1LcRsgugCVvmagotcBz+6+8SNr4sMAXOC4AKpgZWw4cnh/Fa8ALtNzE0bTdGTfLm
         z1aACMGKSzucMyFg27ERyIA/agqx+Ot6I0ipfeZyY4Nm6GzhOnXjhy2Y9PeMq3/jrVAy
         CQjVTPooNw3YXLfwdprMq06IXanrenXqxSeyCow+q1BOBeMN88alK2qTgSvSdGWMDgB0
         oL2A==
X-Gm-Message-State: AOJu0YzMBEWRWwCtMZ7f/44v8MbskPRMCl4Q+WplJCYe743Smr9gBURm
        TXj862qYYwR5C4ZcpRuB2P01OA==
X-Google-Smtp-Source: AGHT+IF4UsUe/MDsFLT/6RmYo+0oZquyT6z1OqAlchXeQRBB10Ec2lC3ifsU5XaSGoCtW52NqTVUcA==
X-Received: by 2002:a05:6a00:850:b0:68e:46d2:e331 with SMTP id q16-20020a056a00085000b0068e46d2e331mr13120074pfk.23.1698182348738;
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79dc5000000b006bd2bbbaf49sm8079331pfq.122.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ima: Add __counted_by for struct modsig and use struct_size()
Date:   Tue, 24 Oct 2023 14:18:48 -0700
Message-Id: <169818232961.2100071.16281003220296579350.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSRaDcJNARUUWUwS@work>
References: <ZSRaDcJNARUUWUwS@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 09 Oct 2023 13:52:45 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Also, relocate `hdr->raw_pkcs7_len = sig_len;` so that the __counted_by
> annotation has effect, and flex-array member `raw_pkcs7` can be properly
> bounds-checked at run-time.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ima: Add __counted_by for struct modsig and use struct_size()
      https://git.kernel.org/kees/c/68a8f644575b

Take care,

-- 
Kees Cook

