Return-Path: <SRS0=FO2U=YS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1882CA9EA0
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A155B21872
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FE/GwmYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505728AbfJYQpW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:45:22 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:43552 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633101AbfJYQoX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 Oct 2019 12:44:23 -0400
Received: by mail-il1-f175.google.com with SMTP id t5so2393291ilh.10
        for <linux-security-module@vger.kernel.org>; Fri, 25 Oct 2019 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FnNCWhzA8wzAQcW3IvtMxmOw0mIYmbzhbuz8jcog3z0=;
        b=FE/GwmYd89R7oOACf+gouF5/sDJA7KfixcIXlgu0Zy2xBlflmjGhsPtumrOF2/chO7
         ukgC7RpX2WU0ieTsoaIEsugTNO9IxVY55sHdmI8YDpkuFlrYNj3TJ3Yyh4TkMX3TEZVP
         euzKnHoQXH1CnnfPJ8ycKy7wwlV1V2ytUcp0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FnNCWhzA8wzAQcW3IvtMxmOw0mIYmbzhbuz8jcog3z0=;
        b=q7GjWvpfmVsARBmf9sl2T2Q48TSebOhHGpgh70RLHpHncE88rYOwkj3MVZ14bNTFyZ
         +o7/2pD/ygwboWswQHmLeThBal5lvYIQMz9C8mEsjGWAh5y2oBjbV3vai8IT157KPUoz
         3WAfnZnqm2RQohyhmB8bwvRxIV7f/FEtU/PdfvSWTRGDmtZyzc7IgNqZOgtHWUIhV7Uc
         FB9g2P+Ff5X45eUerJYpLqO8Um9+9h52c9kog8B2q8ZExzJsqovrSILXjch6W5Ffm9/c
         lJRefg9XSAWcsT7uDLU6IJ9dfYLyBp32HKWMWeg79c4P1efHU4kWWWjN33hNaf/YM33G
         R4pw==
X-Gm-Message-State: APjAAAVnSu0LR31+6I20jWpmofdsX3jzIwiyF9ZujCn/bbFuA2E2ha+L
        iQOMbnIVvlYvLeJLxOW7jYWapr1xF9c=
X-Google-Smtp-Source: APXvYqwplTp4urBExPhvW25l2L+/Ju3JVHBS2+uFvGllPrRfHCui0ndNyVgsV/dJodnzbqd+6w7Ttw==
X-Received: by 2002:a92:c8ca:: with SMTP id c10mr5418488ilq.229.1572021862266;
        Fri, 25 Oct 2019 09:44:22 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id t16sm333490iol.12.2019.10.25.09.44.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:44:21 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id z10so2399911ilo.8
        for <linux-security-module@vger.kernel.org>; Fri, 25 Oct 2019 09:44:20 -0700 (PDT)
X-Received: by 2002:a92:d101:: with SMTP id a1mr5273789ilb.142.1572021860411;
 Fri, 25 Oct 2019 09:44:20 -0700 (PDT)
MIME-Version: 1.0
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Oct 2019 09:44:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uui+a6TS85VNv3XVApq7xYifd8m_ZTmShTC2jeGEO4jg@mail.gmail.com>
Message-ID: <CAD=FV=Uui+a6TS85VNv3XVApq7xYifd8m_ZTmShTC2jeGEO4jg@mail.gmail.com>
Subject: Please pick ("LSM: SafeSetID: Stop releasing uninitialized ruleset")
 to 5.3 stable
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If you're still taking things for 5.3 stable, I humbly request picking
up commit 21ab8580b383 ("LSM: SafeSetID: Stop releasing uninitialized
ruleset").  While bisecting other problems this crash tripped me up
and I would have been able to bisect faster had the fix been in
linux-stable.  Only kernel 5.3 is affected.

For reference, the crash for me looked like:

Call trace:
 __call_rcu+0x2c/0x1ac
 call_rcu+0x28/0x34
 safesetid_file_write+0x344/0x350
 __vfs_write+0x54/0x18c
 vfs_write+0xcc/0x18c
 ksys_write+0x7c/0xe4
 __arm64_sys_write+0x20/0x2c
 el0_svc_common+0x9c/0x14c
 el0_svc_compat_handler+0x28/0x34
 el0_svc_compat+0x8/0x10

Thanks much.

-Doug
