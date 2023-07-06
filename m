Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E94EB64D9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jul 2023 20:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGFUnE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGFUnE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jul 2023 16:43:04 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F201992
        for <linux-security-module@vger.kernel.org>; Thu,  6 Jul 2023 13:43:01 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57023c9be80so14683897b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jul 2023 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688676180; x=1691268180;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmGpQ0efT2wZVXb4F3IH8qHK4EeJiTGN9U9jo8MzXZg=;
        b=dSza7dYDzugroOVz/pO5bsjtNsqjrkOGJFr781lXmcXVGtJfWMb9FxH/V1Ddk01lOB
         129f81WYKff/IwoCS+e8WR1EHI/k9zIaF5wIEoVxKdtquqRZTF8hEChFPJSilqJN89rd
         1BhhfTrqd9DnD2XZ+EYffPrghRWi5BPVWrQCg2oTgaeNjaV1Bgnekyh+uWvN2P2VWyxX
         v0hhietmqt+0ndByOh4ahrLMCs7Yk1BL/IjrCe6q93Gr6ecSqRAFEfAIWbFLjpXfg4gk
         m3Ps4IGxBaaSeK2DTi0u5+1vXgUxHTMoyCKCFlDSFSFcjQymxSeaYDAvqnxTK3y6jXiT
         CEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688676180; x=1691268180;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmGpQ0efT2wZVXb4F3IH8qHK4EeJiTGN9U9jo8MzXZg=;
        b=c6p94RtimObOJGMm6WuuBksmlaeA3zSu+Qi7RzHC8DSu1w3sTAUh6SPIqmsMu96E+w
         MskKsNyVww/2eUtc7sOhe00ayGV4iMvDbKh+2IPexWiL8wvSBxgRhXY2m+MuwC4nV8nL
         PhGf11N9HT9/R/fCFBZ0a1AD/LRe4twh1kqg/NXBSvPavQ19WD3hzBMVUlxthcD3h0xF
         +swq9WURmlV38Our4jsoVfFtCql2+f+EoxRrh89gyJCNWQN4k0ewhmLS40UHQnm5XPDB
         0yghaXmI5z19e0iR9lEYKwQTUZH9QHUMlMtEpb5P1uvgETUwqGuZg4HnfJlSrZ5D0iVi
         MqpA==
X-Gm-Message-State: ABy/qLbHvmyvYeWqbkG5kRimlhYe25ok/YdMFRGG5r4TNcMMxPBgTloQ
        P/fr29l8OIa9L8d7E+FibwBuWM4vA4hQrMoEoEwY6FCOG2HSZj/LWA==
X-Google-Smtp-Source: APBJJlGilj7SENOyabwlZ8rbsluGeAHSgFuoJRdAEHT0R8w5xhKaCnB7ObwZXJ30mA7gluXQXRROXtqVOHIHAiiXo+A=
X-Received: by 2002:a0d:d647:0:b0:577:228f:467f with SMTP id
 y68-20020a0dd647000000b00577228f467fmr3340030ywd.36.1688676180223; Thu, 06
 Jul 2023 13:43:00 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Jul 2023 16:42:49 -0400
Message-ID: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
Subject: ANN: new LSM guidelines
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello all,

With some renewed interest in submitting new LSMs including in the
upstream Linux Kernel I thought it might be a good idea to document
some of our longstanding guidelines around submitting new LSMs.  I'm
posting this mostly as a FYI for those who are working on new LSM
submissions, but also to solicit feedback from everyone on the list
regarding what we should ask of new LSMs.  If you think I'm missing
something important, or believe I've added an unfair requirement,
please let me know.

I've added the guidelines to the README.md at the top of the LSM tree,
but to make life easier for those reviewing the guidelines I'm
copy-n-pasting them below:

* New LSMs must include documentation providing a clear explanation of
the LSM's requirements, goals, and expected uses. The documentation
does not need to rise to the level of a formal security model, but it
must be considered "reasonable" by the LSM community as a whole.

* Any user visible interfaces provided by the LSM must be well
documented. It is important to remember the user visible APIs are
considered to be "forever APIs" by the Linux Kernel community; do not
add an API that cannot be supported for the next 20+ years.

* Any userspace tools or patches created in support of the LSM must be
publicly available, with a public git repository preferable over a
tarball snapshot.

* The LSM implementation must follow general Linux Kernel coding
practices, faithfully implement the security model and APIs described
in the documentation, and be free of any known defects at the time of
submission.

The entire README.md file, including the guidelines above, can also be
viewed in your browser at the link below:

* https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

-- 
paul-moore.com
