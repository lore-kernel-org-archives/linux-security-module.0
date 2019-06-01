Return-Path: <SRS0=lcqx=UA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D11C28CC1
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Jun 2019 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF8527741
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Jun 2019 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="es0MlBBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFAPNF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 Jun 2019 11:13:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37226 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfFAPNF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Jun 2019 11:13:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so8014699pff.4
        for <linux-security-module@vger.kernel.org>; Sat, 01 Jun 2019 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FuMzTWUyqXr275cppjWpX1GkBsQf41wiq5bBOzf0p7U=;
        b=es0MlBBjQF5vDMIQF8iwnHZvqreL+oTa3LkoTa/FMgnla6ZY7sI29PUJA/3KIN/OSn
         Aro/2BTNLgMLEPAX8uWnORO5XA3wECzSCyCx69U01Qg1+3G4+RmK3JDxWG/22GknwUzu
         mrwS4QQfVAOz9Ea+tvoYf8kNbOqeeU83bDixQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuMzTWUyqXr275cppjWpX1GkBsQf41wiq5bBOzf0p7U=;
        b=RmMnRPp9XB5rbXLoIwark1tns4DDePlTAdu3Ftxso7nCSz0G8FgjsAjR+hvP4loEnN
         d80tOeXU1E+fs/AgRv8omtFU8ewfAGH9fAt8vJRCgoz3lHEupIsk8FJBFdGtO4pGik4a
         Lt36VqUcDw3p/QvKu/tPGAJYkx4NYFZtg3yjght22hbqNyRFm+T0d+qhZeXWbhQQPPAJ
         Z1gxjNB/toL9ZlVLvxnRS4xw47e7nYmu0jz4Ini/xBSWxGzzGpMCKhDy414yNRYvfT3/
         vLVmo/1/vVm5VxL1Z538Kw1WSoViFA736Gepx8gp5vLiVGzIR575EgyMwBUT4Ra0Le7b
         ykvg==
X-Gm-Message-State: APjAAAV99En5vrUVCxXTKsrjci7Q0nL9JAtoPnef/HgUvixizQ8nYsUg
        XQJ89aCKoPNzdwzFdelltf1EeA==
X-Google-Smtp-Source: APXvYqyp2usoU7ISvLNDRPGsupiSidlvEoNYcvEu2wZUVI+aexGbDYwy8Y6tIVtkL7Nsdz4L2AeaoA==
X-Received: by 2002:a63:1650:: with SMTP id 16mr16219153pgw.164.1559401984422;
        Sat, 01 Jun 2019 08:13:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j37sm2038546pgj.58.2019.06.01.08.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 08:13:03 -0700 (PDT)
Date:   Sat, 1 Jun 2019 08:13:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
Message-ID: <201906010810.345B635DC@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 04:09:22PM -0700, Casey Schaufler wrote:
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> [...]
>  58 files changed, 1217 insertions(+), 779 deletions(-)

58 files and 58 patches! :)

I (and the mailing list) appear to be missing patches 51-58...

-- 
Kees Cook
