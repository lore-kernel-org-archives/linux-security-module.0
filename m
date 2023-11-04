Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8E8C4332F
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Nov 2023 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjKDUpZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Nov 2023 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjKDUpY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Nov 2023 16:45:24 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155411BC
        for <linux-security-module@vger.kernel.org>; Sat,  4 Nov 2023 13:45:22 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-586ba7cdb6bso1743304eaf.2
        for <linux-security-module@vger.kernel.org>; Sat, 04 Nov 2023 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699130721; x=1699735521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqLx4B4eYaCl63fe+v3lssTiz/E1t615IQY+jLEC5QU=;
        b=PZhJTyxscLdurdTo4s0iF7exkH5ePveQrcDu8lF5bdDDOAKcmAKftldy/h1SqZmHaM
         alQaJ23ik20LS8hxmY4GauKrpkGlcCZcKYL+2RhW+5CzKAHxibFm07IvcHR2TUjtg/Qv
         +/h+2CDQ7JKqbq3PZCOnbEMJxhYhty6Apn73Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699130721; x=1699735521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqLx4B4eYaCl63fe+v3lssTiz/E1t615IQY+jLEC5QU=;
        b=rHkhj738V09hUfJiOXgnA4gGNzk5iZbsPWaPz0ziHAsGKgY0LhIvaDM1P6bfyN0K8S
         lKQN1ZDEavTwPOKs8fpE9xReoqimg/Hw68fxdeQoeGvZv5hBfC7PVxi4s2slLbEl8VEz
         HvRP9sc/wbTPKYzYR/9qwGSvHQnEuA1fPL7/7fz2UISfNDvosPMdSpi6pSuA0LoZAwvb
         zzpP+Ar74aD409TARXoqQKDG+TJ+rsFnYLWwhG58mXXIbw6uOL00VDtHT469FlYkwqcf
         p/KAydyd+CN1AVKboZfMdyRYMyGCYoNwjuV9/dTPdcAmcb6KK9ArzYNtoi8D1YDk5K4g
         iUWg==
X-Gm-Message-State: AOJu0YwzqAbZOQCOxux5EJ+yKU9qJFuNa2lLkkJim0zXwddyIOUGBOzb
        lJLx/REjRu5SfyAt6rx27Otqyg==
X-Google-Smtp-Source: AGHT+IGp32yGTqWv49b30WDAhnS22OWCItyJAuD53Fbd9/R1DAB9OVndnlGCgESoyNtM6mbiZdjQxQ==
X-Received: by 2002:a05:6808:181e:b0:3ae:4cad:91a0 with SMTP id bh30-20020a056808181e00b003ae4cad91a0mr33411223oib.6.1699130721428;
        Sat, 04 Nov 2023 13:45:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m24-20020aa78a18000000b0068fcb70ccafsm3240757pfa.129.2023.11.04.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 13:45:20 -0700 (PDT)
Date:   Sat, 4 Nov 2023 13:45:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
        pabeni@redhat.com
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202311041343.03239A8AC1@keescook>
References: <20231102005521.346983-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102005521.346983-1-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 02, 2023 at 01:55:16AM +0100, KP Singh wrote:
> NOTE: The warning shown by the kernel test bot is spurious, there is no flex array
> and it seems to come from an older tool chain.
> 
> https://lore.kernel.org/bpf/202310111711.wLbijitj-lkp@intel.com/

I was finally able to reproduce this and tracked it down. Fix is here:
https://lore.kernel.org/lkml/20231104204334.work.160-kees@kernel.org/

-Kees

-- 
Kees Cook
