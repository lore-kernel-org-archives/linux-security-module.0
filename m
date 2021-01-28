Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1649C433E9
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DF664DD6
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 13:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhA1N2J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhA1N2H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jan 2021 08:28:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F469C061573;
        Thu, 28 Jan 2021 05:27:26 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f2so6281007ljp.11;
        Thu, 28 Jan 2021 05:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tvqUEPKnNcrsTtiavlBzi2ibquYTuocPU0umzSH5LI=;
        b=seuMePA/mnST1btiw896yyME8C3fNYkPM9VYQKEh5feuJ0tmW65ic7NwAqM8r4VvHL
         B8fsdPAnb/cScDv8Ssd+A9XUEMiL6377sCP9TdyE+PEVosdYRHqtNLU0ZM4dv4H3eSim
         ALVOjNb3MGsOSpoz+cC4dZ9JqL8b4g5kq21kbUDf1+7IPkKy1KI4ISsZIVY3u8LQLiq1
         aomzPReExT48wDC2D+NCQwR31C0Lpb3zBv+alWb2Cavgvg1bBdfGITu1q1FF4zfNvN+H
         oanqmAxu6vym2j5hj4tXflpFFxiso4swJOHAkzvanW0ncMu7fgKgZywToqfZ16A4Pdoq
         Okeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tvqUEPKnNcrsTtiavlBzi2ibquYTuocPU0umzSH5LI=;
        b=bl5cr92OUU6UvAts03azeC7ne2sNmKdTeUoQenXn1Hgb2nIZAx856W2kO2thTj4c9E
         75UIvky0jL4ycWWUnEOzhBuxfGv5suloZ5DXcOVQT+JIvnpebGejmoU2hicYY6exctRC
         MOXcbE8BxhL85G7gbNks93Ds+1dEVsbR/FOg6Ckq9KEKk+ZDf00PaGrhhqOsBeGxKrjN
         tgPZsFVEI/R5LF7Uel8Nbgxkxz18Yom+nnHJKa2BvRB85L1tespEH7UIaB1yVVkoPqq9
         OANRGO8WPd17Z9TEtzOCT7s41RObMNEL+ul2mS8IFaMiXfSgP+fV6aHxkdN59Qi3YG4y
         FY8Q==
X-Gm-Message-State: AOAM532HOro1Taj22vP80RggyhvTf+VchjTaK0weawEHGPUlBt7YPE0P
        jCsQXfgxn2CtZxBWBBK0C9Y=
X-Google-Smtp-Source: ABdhPJzsiPTIa9b1AXsJ61Sto0REoDpd643CbZjruyzw88VOao4q8PSyQdxcyJbrPgiMAgAc5UFZjg==
X-Received: by 2002:a05:651c:2112:: with SMTP id a18mr8568028ljq.341.1611840445011;
        Thu, 28 Jan 2021 05:27:25 -0800 (PST)
Received: from localhost.localdomain ([5.76.199.233])
        by smtp.googlemail.com with ESMTPSA id d12sm1610387lfm.163.2021.01.28.05.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 05:27:24 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     andreyknvl@google.com, casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mhocko@suse.com,
        serge@hallyn.com, snovitoll@gmail.com,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] smackfs: restrict bytes count in smackfs write functions
Date:   Thu, 28 Jan 2021 19:27:21 +0600
Message-Id: <20210128132721.1111920-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5271074f-930a-46e9-8ece-2cc65d45dc19@i-love.sakura.ne.jp>
References: <5271074f-930a-46e9-8ece-2cc65d45dc19@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> >  	/*
> > +	 * No partial write.
> >  	 * Enough data must be present.
> >  	 */
> >  	if (*ppos != 0)
> >  		return -EINVAL;
> > +	if (count == 0 || count > PAGE_SIZE)
> > +		return -EINVAL;
> >  
> >  	data = memdup_user_nul(buf, count);
> >  	if (IS_ERR(data))
> > 
> 
> Doesn't this change break legitimate requests like
> 
>   char buffer[20000];
> 
>   memset(buffer, ' ', sizeof(buffer));
>   memcpy(buffer + sizeof(buffer) - 10, "foo", 3);
>   write(fd, buffer, sizeof(buffer));
> 
> ?

It does, in this case. Then I need to patch another version with
whitespace stripping before, after label. I just followed the same thing
that I see in security/selinux/selinuxfs.c sel_write_enforce() etc.

It has the same memdup_user_nul() and count >= PAGE_SIZE check prior to that.
