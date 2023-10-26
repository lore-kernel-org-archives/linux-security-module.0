Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660D5C25B48
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Oct 2023 14:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjJZOtH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjJZOs7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:59 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724ECD4D
        for <linux-security-module@vger.kernel.org>; Thu, 26 Oct 2023 07:48:51 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49e1ef0c60dso462699e0c.1
        for <linux-security-module@vger.kernel.org>; Thu, 26 Oct 2023 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698331730; x=1698936530; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lzK1pFiQoRniXEGjF6tOObNRoBOW1hYjV90v0xvTKY=;
        b=XIsBta2gqorH+eW1Tl5gX/6yDCS3r+s/cKlITjSWU+mnuMN0AyOiNMu6UJs4jgBgsZ
         E2SjWe0+5yAusnUReHe6sqUBR21Sc2Igl9v/yZm328P6J/T/+DTh/p/TiT6rXJNUEeUu
         wdLUF572YEKcVH1pI2MPpa8kIHUPdPcssA7p4DFdXE8fYUWMlHm9vgvYfkoztI/OfkQM
         xlI3WZSeqDepVZpfg9oda6eYM2mCGXUMoOmF1hTRyxVISY4i6bCIXL0U/kqb1NB7OrDN
         lE+NLOti8OCm4TSm5iEz2nOKq++oktT2Vb6t3E9nQrcbTLQuHmFsMKK254D93ENsedLH
         UnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331730; x=1698936530;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lzK1pFiQoRniXEGjF6tOObNRoBOW1hYjV90v0xvTKY=;
        b=QV3SFmYICa2uTW95hsr8YjmnhZoYNUsl6Kz6v+fqFSSqtenmRVBLmahe5dP9PUR8Pf
         CikQ0Sl0yA2snrZAM376MlBwmRyAeUtTuifDGeHWbq0LQKrc4PgSYAy3RzDXeNmyEbu1
         cgiE3YifNPgPBZQNo63AH86jM+oX6Ep8yZCBFm60EPleEviqIcgCmzXKJGIJKD7J+JjL
         JtaAccOwtFMcmyBfk6cCOlJq37qD27LmbKSdXfmMm8K9iT9hxZVeQFlPg0ODMqFXGYI/
         G/f6Y/CyKbBfC8mpmiXwV4BLMQ9+jftTeMTT8rnzPmASketoIy+n0rVZ7djnMW01s8Wz
         yL5w==
X-Gm-Message-State: AOJu0YzWquE9Ki21TtmMDMojLCklS6V0pWruzi1aPCxurmmguerDDEhj
        6Lpoweu1gCC7vi2keXZKu7FN
X-Google-Smtp-Source: AGHT+IFOXcomS2z3Xzc1G+uf0v//E62w4tPep5wRMeQeBOXCc+hIrVPCulRaJjMdlYiUzKHt5WCX0g==
X-Received: by 2002:a67:e050:0:b0:457:e32d:1732 with SMTP id n16-20020a67e050000000b00457e32d1732mr15674294vsl.4.1698331730343;
        Thu, 26 Oct 2023 07:48:50 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r13-20020a0cf60d000000b0064f4ac061b0sm5252286qvm.12.2023.10.26.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:48:49 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:48:49 -0400
Message-ID: <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT  calculation
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG_COUNT
> calculation, used to limit how many LSMs can invoke security_add_hooks().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into lsm/dev-staging, thanks!

--
paul-moore.com
