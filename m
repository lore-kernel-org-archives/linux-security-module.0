Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174A7C77B7E
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Apr 2023 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjDUTiN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjDUTiM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Apr 2023 15:38:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8B2106
        for <linux-security-module@vger.kernel.org>; Fri, 21 Apr 2023 12:38:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b60366047so2165448b3a.1
        for <linux-security-module@vger.kernel.org>; Fri, 21 Apr 2023 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682105891; x=1684697891;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g+8KsC/ps0LMXEpHmka3cbEEb7/Wjlyl8f2Ais31wDg=;
        b=TK6vvebPUf1UeLmGpfiJxvNuCRWGMhitiOmb9/goJ91+yAjgSFg+mHSRB/KVVsb18A
         RFxJbBfGPaCqHVrO0InPUKhDVPt6zgbxJtw6otYnZGVxlX91i5CVrfhb6MrSbRC2nTok
         colBViehRtzJ/qltyNiMi7m6qufynv//C2Uhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105891; x=1684697891;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+8KsC/ps0LMXEpHmka3cbEEb7/Wjlyl8f2Ais31wDg=;
        b=ItPasSxTN+6gua3utfVdu2cDqcZVdAw3y2PN9WSiSv8JZO608/IFadxAS85Xe5Et0m
         Ydtz1jqssMfDtudI/vyIJODFKxez1h514TmK5IJHisThyakKrnZq0256NBb6uVnk51hB
         QIE0JCQvf1OseeW4JKerVol2fByjTq0tEd3VdoiyJifLNfDQnJqpTx/hv1ctnimBXk/L
         4KX16Rt1VxZLbZFJlUNVjjDGAWevZ8sl7X+1/e1IAjd9Uki1vyAOJ2hD6YGNqibAS/WN
         jyK6izbyncI6oWJJwCwE00sxBlb3ED78XeZcgX7uT6QbKkE7aAJH5BLtuEcmADZBREX2
         96yg==
X-Gm-Message-State: AAQBX9fAyEnpJUJXEnIOBpEOcsU+NVKjC48g4kxmWh85rIBratrD2kNY
        2WwZVry8+K6rH3dQmWrCrpC9Mg==
X-Google-Smtp-Source: AKy350bfqz+mZsZOStlbT0+QIWIq9Tqr3Q9vUdYvJgyrTPWlg5kO0aBPO6oy9v7iFdSfvZQ9yjTOvA==
X-Received: by 2002:a05:6a21:3297:b0:f2:bd5a:9ba1 with SMTP id yt23-20020a056a21329700b000f2bd5a9ba1mr2142265pzb.62.1682105890935;
        Fri, 21 Apr 2023 12:38:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa9-20020a056a002d0900b0062622ae3648sm3331494pfb.78.2023.04.21.12.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:38:10 -0700 (PDT)
Message-ID: <6442e622.050a0220.827f3.7171@mx.google.com>
X-Google-Original-Message-ID: <202304211238.@keescook>
Date:   Fri, 21 Apr 2023 12:38:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 05/11] LSM: Create lsm_list_modules system call
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-6-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 21, 2023 at 10:42:53AM -0700, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
> 
> The calling application can use this list determine what LSM
> specific actions it might take. That might include choosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
