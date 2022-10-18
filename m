Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C98EC433FE
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Oct 2022 18:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJRSbF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJRSbE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Oct 2022 14:31:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816A719BC
        for <linux-security-module@vger.kernel.org>; Tue, 18 Oct 2022 11:31:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l4so14645146plb.8
        for <linux-security-module@vger.kernel.org>; Tue, 18 Oct 2022 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iy+LFikzHTs1J48QAEAHAm5YGvlj/kbcEpiv2VdTbbk=;
        b=iBu3LRdcEWjy4sMWECJg5kLUDIVKNFjlERJIDz8f280TVk7Nv6Zz0y+8eiWnZKTeah
         JrR6L/bfoap5pjeJ0q9SJKt/qhWjklw5U0jpeHEj9DrMgbyu7WCZwDeXHXGKqBg6mF1C
         JLTJOHwjDJOXfQfTnDbVyIxYspizRanVV0kKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy+LFikzHTs1J48QAEAHAm5YGvlj/kbcEpiv2VdTbbk=;
        b=Vdz1YxBDu6R8EN/7upDC5qb+ziYMmOPyOKEPAYC6ei9RwO6VFSMpRBHeSW4dOW/gjp
         /ZuzanXHXpNbGx+2lNBR2uWXaUzxoF/mj0NeYgcdAY+8LFFhW1rZLiv/VahF/3fYu3ww
         9jQWOA/spNGRlI76M5pK4YzqTv1Ldz6mbi8vqCM1Y4wjP3eJhfWN6rLapijGrYCPt8gb
         ntNblTulLmL8+uuLPFNtrbXSMyABaM5UAOV09rj7oVr2+mp69/GJiDyb3CWy4alUSwte
         +g8/YomFq0lhgBLlGA2fjw1DZ4RoDlXJx5vU3ffvA6Gtw9vkDEPuiUn7lg2G6Oifnwke
         qF0g==
X-Gm-Message-State: ACrzQf2SneDnicu5MNABdz2wO3yme8wcTUF3XveHyUC0gBJ13YTByMy/
        tR8otXodvh5M1Ft0j14BCmAzqA==
X-Google-Smtp-Source: AMsMyM4dhHmTVNxe1K5q0OPpxbYaxmEGnV634ItJa0zwjrZNESq53ZU9+CnAuOxxfXQIWgCxMXUa4g==
X-Received: by 2002:a17:903:41cf:b0:183:5a22:c63e with SMTP id u15-20020a17090341cf00b001835a22c63emr4197770ple.61.1666117862254;
        Tue, 18 Oct 2022 11:31:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001708c4ebbaesm8763339plg.309.2022.10.18.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:31:01 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:31:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 0/9] integrity: Move hooks into LSM
Message-ID: <202210181130.AF944615@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <0a8f21a6-02de-36f0-7613-06ed3daf934b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a8f21a6-02de-36f0-7613-06ed3daf934b@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 18, 2022 at 05:31:59PM +0200, Mickaël Salaün wrote:
> There is a complementary patch series that didn't received review:
> https://lore.kernel.org/all/20210427113732.471066-1-roberto.sassu@huawei.com/

Yeah, this looks interesting! I hope Mimi or other integrity folks can
review these.

-- 
Kees Cook
