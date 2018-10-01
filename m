Return-Path: <SRS0=sHE6=MN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB15EC43143
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 23:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5702E213A2
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 23:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHCJwBH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5702E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJBGSh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:18:37 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:42961 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBGSh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 02:18:37 -0400
Received: by mail-yb1-f169.google.com with SMTP id p74-v6so40806ybc.9
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XlzRVP5lKWv4LNLVaxHuF+5oEpeGtFvtjkJPXnHwLmc=;
        b=ZHCJwBH0NsNTCoJCYVEVIFVviLZE55GWjH3HNV/YNHhYqDhH43gR8E3SJSlHceYiJT
         XqKpRcRXN/TJ5mgd5suFztHggkMW6BVtJugZ21BC0tMgFgN+eUTS66ldYbdWO5RV9Ow3
         oQ82qOIY9CTedRLm9V2PAjd2h5n/bC7Cf0d54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XlzRVP5lKWv4LNLVaxHuF+5oEpeGtFvtjkJPXnHwLmc=;
        b=jbPmySXcFyiPJsqepxrtLDfwWNI+RW+PAbFEdoU2ZtKSj/Hx2eNE2OK25/MXGDLDvb
         mnrZRTihgnHX2/UMT5hKmdcCwil9gZ1dEXaaXYS1+LOmuzp7oAsOfL6CVHtbQjtVZPTE
         f4Wbclu0u/Ks66VG8+85jkvWakNKGxHG5IvGPFpXyV1BkSDhX0X6ToYqS6KWjPtdETV1
         KXFgJGo1FjDwPLNQwfravJCLSgnDVFAVaVx9nTYL7QTWffalJ8xe9hPOb+Sm8vy6e0YO
         608wtU89fdjXHxJP8PkCj8XBaJULGdYOW6B5hAz5Q5QWc15jk2xW7Lc+G03XEFD601lH
         O2+Q==
X-Gm-Message-State: ABuFfojuY9y0miQXF0/DtzqXRVuRnmKevwZAIgn4JDMpj8wv0mAxqpdQ
        R/Sf68fJgwMb7yv+m1PK//Xv6feUfwY=
X-Google-Smtp-Source: ACcGV63XwZtQy5YTMpbqWynRVTy+B/y/9DdkkPP1HYQpE5dwIDgE/DJWIUqXEikXD9/s+BJ7vcUOFw==
X-Received: by 2002:a25:83cb:: with SMTP id v11-v6mr7225244ybm.477.1538437102624;
        Mon, 01 Oct 2018 16:38:22 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id p128-v6sm7383862ywp.65.2018.10.01.16.38.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 16:38:21 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 5-v6so53079ybf.3
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 16:38:21 -0700 (PDT)
X-Received: by 2002:a25:238d:: with SMTP id j135-v6mr7127848ybj.137.1538437100765;
 Mon, 01 Oct 2018 16:38:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 16:38:20 -0700 (PDT)
In-Reply-To: <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 16:38:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
Message-ID: <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
To:     John Johansen <john.johansen@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 1, 2018 at 4:30 PM, Kees Cook <keescook@chromium.org> wrote:
> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
> enabled. Is that okay?

Actually, what the v3 series does right now is leaves AppArmor and
SELinux alone -- whatever they configured for enable/disable is left
alone.

The problem I have is when processing CONFIG_LSM_ENABLE ... what do I
do with the existing "enable" flag? It's set by both
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE and apparmor=0/1.

Right now I can't tell the difference between someone booting with
apparmor=0 or CONFIG_LSM_ENABLE not including apparmor.

i.e. how do I mix CONFIG_LSM_ENABLE with apparmor=0/1? (assuming
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE has been removed)

-Kees

-- 
Kees Cook
Pixel Security
