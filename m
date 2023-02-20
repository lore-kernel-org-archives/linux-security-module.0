Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31560C61DA3
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Feb 2023 22:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjBTWdl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Feb 2023 17:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBTWdj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Feb 2023 17:33:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266ADE059
        for <linux-security-module@vger.kernel.org>; Mon, 20 Feb 2023 14:33:23 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 99so2792829pjz.4
        for <linux-security-module@vger.kernel.org>; Mon, 20 Feb 2023 14:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3UQN/oFTWo4MxSfvqWVfGxfsh6wvtc/4Ez36p/TidCA=;
        b=MljBF3mEH2huOvVjZJqUp3uEvdilqJEFeLwn4tmgDpwghTULscjSWj6nLpWddZvBtp
         4Bpug/9j7+MaEBstZu4UnK/88XTI1M6urI3/6oaG5sizaMJRpvPpDvsVhGW2GzyaoGze
         h9DIU3h++6f65BGAesEbwVi3BJZx+0o69ZJ0MmNdZebnyE2bFEgyNhwKTICdJzqb9z5M
         LrpPTaha/RXP5d+CAAVflDWByeW4/BhKaX9yH0OVXs108MJcW09ZxDLvlaJSB4AkyK1b
         hrnydbScOxAygpqWZojzJz8/BI9smtTzEO3pECFscSg7QagmjAg4awupVcaeMUJonSBJ
         7wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UQN/oFTWo4MxSfvqWVfGxfsh6wvtc/4Ez36p/TidCA=;
        b=O7K5gFiLQEybGRbRLFvlPjmuIQaQjFNevWec/+1gWML3vaQWqS2q08l+MWpQjxIj8f
         d6bstxqyGtw4k5pAwMqdCEnYUU5vtm1QBj1nbEBOR6ZAgEttl4xf0V6BMWOwGuLkZpFJ
         yQqlISCqU57TEEiEeCvJ/i2bYQe30yzoh/IuH5+sutV491q2o+UqGYTLms8mKJ9bN0Fp
         g1OkcvvmiSXt1fQIRyQyYOaeoWOv5YO1fk3DD1vbNZQRFDV2rKPwgGTLa8onicIbovRt
         1HXhyWNyAtmK3CfH5CuT1B6/0WFvFmINgOpqxkBFQpaIuVkOK68VqYP82+AhkMGMAhr9
         7rRA==
X-Gm-Message-State: AO0yUKXhMotmYsAbfle8aj0wHEKQfyPwFK/W99zNxk3gQcJpf5f2khwV
        msw3/LaqG/qI2ttORV68dWNvwG4pKSufyqiP3R4CtgZPxdUu
X-Google-Smtp-Source: AK7set9+SlWCdkx/IU3giDBk4VabWyHsCp0gSMtzC6rz9MkU58J90H77HEMEzYJ1uyXNvm9rR0dPTJ4F7YjYVETPpys=
X-Received: by 2002:a17:902:6ac5:b0:194:6417:cd27 with SMTP id
 i5-20020a1709026ac500b001946417cd27mr362989plt.34.1676932401944; Mon, 20 Feb
 2023 14:33:21 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Feb 2023 17:33:11 -0500
Message-ID: <CAHC9VhQOxGZHTZ9=PS_q6rhBZ3de0gyBU6-R=0m6vncZc02s+g@mail.gmail.com>
Subject: LSM pull request for Linux v6.3
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Just a quick FYI that there were no patches queued in the lsm/next
branch for Linux v6.3 so you won't see a LSM kernel pull request from
me during the current merge window (assuming there are no breakages).

--
paul-moore.com
