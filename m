Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4762AC433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 15:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiGFPXI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiGFPXI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 11:23:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7AC13D3C
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 08:23:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu42so6662932lfb.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 Jul 2022 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ijBx4wXkhQ383VZeydtKSmqnuRY+UW9cAnNUcSCCt0s=;
        b=gIHHiPQep3iKhe7CM23AC5R/ogIyWvhaQ/0ylE0f1NZFxSvl00wvRN70KCV8Cj1Bzl
         oUStzOHFN5Kvl+CKEsppD5JNT/yxKuSITHWhfJZ9BHGd4U+GsyffahtC69z3eNb2rkun
         PNzZuMz0cj0h3OWosqVx1/cbjhI+dgtFBaxDZYBKuR9oQgHYx8hTAUoEbhHAl4xCO6or
         zLYZviU/G1trkYhYtlHfI3dPm95gtUNOEM7JSsUyDM1jYkJmk4OowFoWPRAXVTB4m96a
         oYANoLz8Colalgnq3w8Qnxl9rzrkWxUay4z8OEsMauHSd9LQQum86zd08GlgOiii1khh
         EOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ijBx4wXkhQ383VZeydtKSmqnuRY+UW9cAnNUcSCCt0s=;
        b=DIaVLKGrpsp/QSjIY5JME2Rw/rxpsDouHIXqnZ0B/h469M9a1hgV8C0vQibJhRzgGb
         A2FKD8erE8shG3f7qun2Z1qxSJaPUHpyWLi/Btio6eUVY2YAlg3DXVyYhfaeNecGH8yq
         6YdpkmJWii30u5mUDouYUvhnDr9U3G0D2UJiZTPINABTcw8aEqCoS22zevUNId5/JvPd
         IgB2S111m/di1uVR+RwX9lauNCoou6D9z3ubUteZL8ptZbPB8VxjzwDgUSOJwP1wHROw
         j6CuQ3rl8EuJSkB+raQoVivRRh6/qA5wOB345/5qiTbjMFG49DD0ljGVIluWd9fRhZdi
         n6Iw==
X-Gm-Message-State: AJIora+ktBDbJf1jkKfT/TKJ3vkTwMw3fhUamGBuAMCoPPlZRX7/o4hd
        1n+Dg1j82RviWvqyh8SYQrAbXnohMUzbqBKw6F+YLdRqo4A=
X-Google-Smtp-Source: AGRyM1tbbZuaUb9EOAPp2xvKO+LHCorYV0Mgvs+UFZdp0hOQC+nlqS6lQdriVwfZCiJBmXqHiTJPMIMWc/e/W6GQ3z8=
X-Received: by 2002:a05:6512:3409:b0:47f:af5b:b24e with SMTP id
 i9-20020a056512340900b0047faf5bb24emr28230842lfr.555.1657120984234; Wed, 06
 Jul 2022 08:23:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Wed, 6 Jul 2022 18:22:53 +0300
Message-ID: <CACE9dm-cNq+m04StHREnUj+r4Cf4z=dTaPN0odkYQSLb8KAmSw@mail.gmail.com>
Subject: LSM performance measurement
To:     linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Could anybody suggest a good approach/test suite to measure LSMs
runtime overheads?

-- 
Thanks,
Dmitry
