Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F27C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jun 2022 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiFHUOK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiFHUOJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jun 2022 16:14:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A3193C7
        for <linux-security-module@vger.kernel.org>; Wed,  8 Jun 2022 13:14:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q18so18571734pln.12
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jun 2022 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=++fqAeCKas2xwY8gYmLSLZhWwyCDt2zR6rtP3Oe8sas=;
        b=EWEYlt4U4jqJOne5vOd8O+q6+x/Vr3TjxkiSAZsECiDNQpOGVSpqNgVYDdLKnewzGu
         sMzzE0R9k2qiGDnu9g+gYXg2PWUUwAuRPnG2dfZmlckxIEZiub873/pxjGhHzyvSUvK0
         GCUSY7Fevw7RzJv1GTZC13c1iEtnjsC70h/Ws9DjFYQVoMmloOsqr+m6Er+Rw1tW7k42
         nLTSfoeKjFnTLApNBVlZYOu6fKxfkJhZLoeY0rSIj+kuI00jttWjJ8jiJaR8IXjFPrIS
         r/dO0RQN7onVDA2FyJRW289OLJ4BAl00Ihe4x41hzmco8CZmJYp6336x7E3mOGJF2hKD
         wqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=++fqAeCKas2xwY8gYmLSLZhWwyCDt2zR6rtP3Oe8sas=;
        b=dzVF6WCKP4FkFkAX6/x6Yhb3xhPjSqJ4nPNUBk5vsLTMnXF8hS+ZvY/9Dg1hPHieQF
         Mo3ynuhwwq2P2EhY7+uPWiKmYsoI5mplx41UjvFSFmEnvazNXKXjk4ZhBHmPDb1rfuFi
         yM24Y2wI3mnXlZWQlW+yk5wIHQFUfZtD3W+AeK1DXqLV7AdnQd0Mly+LKM7rcUA2uDvl
         jNA8CiOf53I9J+lhmYA9U732Otd4+1rknFzXVgA1wluJSu8cNhD+N5lQKALtDZmJ8jSA
         SUqnG6Klhmt9ftUJEBRfb0oM12WkxATQgCoH6OqHj2AKc0pTHKlrz6eW9oPRcEKH38/m
         dNGA==
X-Gm-Message-State: AOAM532z6UYXfsYZZlSVyXn2pETnu8+QaedqAkXQeE9SSI0MKC5C79QZ
        Vref28z8xB8GZZO0aMrQuagqhT/WhIs=
X-Google-Smtp-Source: ABdhPJyKR0Pt7P0+mWi3+WWsRkywqkRjhwP+j+dMdhL92JX3i03f5lgIR2RgOWOMmA5VeGR11mVsMQ==
X-Received: by 2002:a17:90b:1d90:b0:1e8:5a44:820e with SMTP id pf16-20020a17090b1d9000b001e85a44820emr900465pjb.217.1654719248403;
        Wed, 08 Jun 2022 13:14:08 -0700 (PDT)
Received: from localhost ([49.36.239.137])
        by smtp.gmail.com with ESMTPSA id e16-20020a056a0000d000b0050dc762819bsm15503081pfj.117.2022.06.08.13.14.07
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 13:14:08 -0700 (PDT)
Date:   Thu, 9 Jun 2022 01:44:02 +0530 (GMT+05:30)
From:   kingdeep131@gmail.com
To:     linux-security-module@vger.kernel.org
Message-ID: <249045321.171.1654719242110@localhost>
Subject: Researchers are finding
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Good day and here=E2=80=99s to a stable and prosperous calendar year.
Many groups plan to stick with staffers working from their homes as opposed=
 to large offices in 2022. Does your organization anticipate challenges rel=
ated to contract management as a result?
