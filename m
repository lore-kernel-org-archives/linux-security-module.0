Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275D3C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Feb 2021 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E3A64EB3
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Feb 2021 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhBRTuR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhBRTfY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Feb 2021 14:35:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A2AC061786
        for <linux-security-module@vger.kernel.org>; Thu, 18 Feb 2021 11:34:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q10so5790945edt.7
        for <linux-security-module@vger.kernel.org>; Thu, 18 Feb 2021 11:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=c4NCOHqlaolHGqdkr1amleTsjWwegvUhICByRNknl9o=;
        b=VYP7Kxn2xl6USBdk1jBYIwDJwjHivxnwpkFDglZqSgeMN1gHRG+QjhHArffCbM780/
         R5PdBRu9lniq+JLN3TBJ8ADffMBC/mRFGRyrdhBcDDYeiNAvKb8Nkm8xs05+TjHF7Ay4
         64aIeYAK3LYWiotIw2+EC+EGNREeiiUZT98tgQYA44zKpiRXRIlGtSl8rppbmC1ueLH0
         xfULZWfgB7UwXgFnT+PgcSb1JithYeEc0lEI69EoUlBxUBcxiWNZT5X07odMGOaRMwqR
         LB8/RJFG17UzONpC1rxeuCKkf+FRUcLBdJ1u4vGV3nqFL0WJezxcFfgC29VAPDlbPNq1
         tVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c4NCOHqlaolHGqdkr1amleTsjWwegvUhICByRNknl9o=;
        b=S+JFkYIDK8iGbfIpp5ATZocKgoD/VrTPeL9w1Ic5LTPUuJu7xLOAJ3jACq7APBeRLm
         7Wtp/otp2ooJoLz9w1+GotrJYXH2yNfrEgx7y6jVPMou7P0T+urK7xQDUhhkF0if01hp
         cyAGeGx3ukNY3DWNwmw/IKKSsO0J1hHyk2D3pKBe4OSU4Z7a8+HqfQ+PwO4ZuQhqoq2v
         ol+KGzkWYBWOrKWAszs6WlsC1/xcIHYehW9nZBgWErk/Y87L1NTmeDbRCHiGzB2OQxy0
         /MOSI/GNoS9v6DndPjHK8M7L7qogW1vMLBJMMHaikQHpg1W51Ql1qxDtjso/ZOJeBGWd
         gsEA==
X-Gm-Message-State: AOAM530V9n8XK3kkVQKDlscuuPwlv1K9BkL1UPoKMCTUZObFoiA9Haij
        c3umqYN/OGvpkdthB57ptlrfmyCgzfIzwOi3v7BJ4Opy/MfaSJw=
X-Google-Smtp-Source: ABdhPJwpsC+vm8CzQEpfKZRHzdetnGTBoYfUnbFd5gkMtykFEPATHNNgEnqXIQm7R/p6kcs7bbTH95jkroqxH+lam48=
X-Received: by 2002:aa7:c5d4:: with SMTP id h20mr5541872eds.161.1613676881441;
 Thu, 18 Feb 2021 11:34:41 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Feb 2021 14:34:30 -0500
Message-ID: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
Subject: security_task_getsecid() and subjective vs objective task creds
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi all,

When looking into a problem I noticed that audit was recording the
wrong subject label for a process.  Doing a bit of digging I realized
this was caused by the SELinux security_task_getsecid() implementation
returning the objective security label (taken from task->real_cred),
and not the subjective security label (taken from task->cred).

Looking around at the other LSMs which implement this hook, Smack and
AppArmor, it appears they both do the same thing: return the objective
security ID for the process.  Looking quickly at the various non-LSM
callers of the security_task_getsecid() hook, it unfortunately looks
like all of them expect the subjective security ID to be returned.
The only caller I'm not 100% confident in is binder, but from what I
can tell it looks like they are expecting the subjective ID too.

At least we are consistently wrong :)

How do we want to fix this?  The obvious fix is to change the SELinux,
AppArmor, and Smack security_task_getsecid() implementations to return
the subjective security ID (->cred), and likely make a note in
lsm_hooks.h, but if someone can see a case where we would need both
the subjective and objective security labels speak up and we can
introduce a new hook for the subjective label, and likely add a "_obj"
to the end of the existing hook to help make it more clear.  If
neither of those options are acceptable, we could convert all of the
existing callers to use something like the line below (assumes
current), but that is the least appealing option as far as I'm
concerned.

  security_cred_getsecid(current_cred(), &sid);

Opinions?

-- 
paul moore
www.paul-moore.com
