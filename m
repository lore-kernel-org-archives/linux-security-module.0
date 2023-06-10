Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27892C7EE2F
	for <linux-security-module@archiver.kernel.org>; Sat, 10 Jun 2023 15:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjFJPHr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 10 Jun 2023 11:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFJPHr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 10 Jun 2023 11:07:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03603AA4
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-652d1d3e040so2250656b3a.1
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1686409665; x=1689001665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+OwDas9lj8b/o3V8lkOk9a6MOfWBvvSjFJASd1oAkw=;
        b=OOATwZuJz1XpIayU6qEWJsTjt3CY+4SMX0O0hFz4qhukDiqKsW+2HfODMVSjDY0PS8
         dM86VQyjvRTSnncMd8NEQ1Y3ajqSyztqwK1L4AHsdyCggJCjMPhoHDYKqNNW/QTmsvkl
         My6SqZzBK775E7qllyKf/D3HPM+CU0UogJlokXdyYcF3DIiOmW498DR8UJaYMOxa4taL
         sO3cymRYwckFon9LanxHS8e9U/hC5GpwfPqq9UwNBxRTStvS4jMi3j+bn53NCB2HcAzM
         zZwpBqsJYUp+qDWJUUO7vVRWb6hTATh/04CW99B7zboxr6WE5Dc4EPBPdzzm3JjPAp3M
         PTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686409665; x=1689001665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+OwDas9lj8b/o3V8lkOk9a6MOfWBvvSjFJASd1oAkw=;
        b=OqOJw+yy5HfPZr8E0Srd8w1mhGV7cmPpDYqdYpEvsrsPoSdNoKn7IF2kjhGLu+yZzd
         upEMezLGEyHGevA4ezBTCKdWuHHxwY06Z+iP4zEN7Z8rRctXHpnVJGBggoiaiXqrNzHC
         6pM5wPmCLZEE3kmxwuRLdw1S4ZtcvzQyL0LvQb245ZYi3SkyNb3vdHaZlQXuTCGi3eCD
         /R9ckyrsDEIjYlxt9BAD2E6l5IH9/M2QGubYKwbku0tOjiriImkcEnINlYAWTeOh9sqK
         qBr6bPrUbY11k169em0Yj1eMfu2CrSDv/9HWONsF8tRtFe0V8Px+lqgFJ8lEw34Ajhyc
         lKNA==
X-Gm-Message-State: AC+VfDycNv6pWkOeSmXM1o/tPIimq3XDZS3prafQgrSVfOuEhNIoumYg
        csnDTMVFl5/WceFxvubdJrWGVA==
X-Google-Smtp-Source: ACHHUZ4r4eCGoy6iuu0IW9XAISMqoeXHH/Fv2bhIfewU3fQ3CD19OKfSes9kinrORhYOGStJ4RF3lw==
X-Received: by 2002:a05:6a00:22c4:b0:646:b165:1b29 with SMTP id f4-20020a056a0022c400b00646b1651b29mr5033723pfj.23.1686409665296;
        Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b0064cb6206463sm4231318pfi.85.2023.06.10.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Date:   Sat, 10 Jun 2023 08:07:42 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yi He <clangllvm@126.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Add a sysctl option to disable bpf offensive helpers.
Message-ID: <20230610080742.5b51a721@hermes.local>
In-Reply-To: <20230610110518.123183-1-clangllvm@126.com>
References: <20230610110518.123183-1-clangllvm@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 10 Jun 2023 11:05:18 +0000
Yi He <clangllvm@126.com> wrote:

> Signed-off-by: fripSide <clangllvm@126.com>

You need to use your legal name not a hacker alias
in DCO since DCO is intended to be a legally binding assertion.
