Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A404CC433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCEB207DF
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 19:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Pu38ZgHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgGTTtP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbgGTTtP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 15:49:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AAEC061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 12:49:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bm28so13703968edb.2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vjke7jCctlJqIXSJCb1I7t9lplbKcUewiqmBoHbpGsY=;
        b=Pu38ZgHzmER5WHND44TQKnpw2/HrfVAfqZKDGMcqJx5gHPdDZMlvApvUrBOHe6Adoo
         gdp8BqZ0UWyMQ/w+1a6wixrUZU3k99PBE5ER64xjdfeBpI4+JIL603yLb+k8sy0xevIf
         am2RhPVPNMYixwQYORjjbpuMDTgjukBu8m2XiuTowavxheKbSihcp05ZOdNmLCr+IctI
         4ZNKfvK3iuwtw00Qgi4lFUmNUPKu/XMUt7GzDhl80EPyhRVhxeEhtv49RTaLvMepnCdJ
         7EvUZECQoitBHu/+muqfCCJtzcIMjDKlezA3VdPT6+EpXH0TIsn/5/MQBZf2mYt0RDR/
         3rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vjke7jCctlJqIXSJCb1I7t9lplbKcUewiqmBoHbpGsY=;
        b=lv+45qrLbOVao2Fh+8uE3iQwe92O2i6uHoZ18FoC4cLprAsBJZmb9WWu9k9S81WTXk
         weExvxPNKBorlLaTgIbx4I4WN6Ktugm+d/n4P91Lf4M4CP90spu83q1zTXd/ZpkJoW35
         MtAisSs63bOoLmpLFytNBujuNXlJ3Mf7THCE4OvYoBRRCRjkc60QduxMtFp9olQn3BzC
         5ALIeRv0nogcoa23obKON6d7+NQ5030RoDyE20JzXjshrcSlM8yepf+blThjiHm21MSc
         ZRCS32ItP271Vur7ejP2UeSZyBkH4iTWhWLFanyDSdrljweNfNMGo5imeGmXRusqvI2y
         N2aw==
X-Gm-Message-State: AOAM532zZWI2XqQq1sdJXMx93ZetV5XhSTSgKjUqQ9uRJstIDNrxfDnk
        Py30qj8HqmDn7FD+ZTrPUGVPGIoG5pfjgaRb6Di2R4dCNw==
X-Google-Smtp-Source: ABdhPJxypHp9Oh4nY0MPfFVKdgszqTCmCF2+o8cwSAxSxKlddb9s5IYcDtcQRxKbNa/KyP5GugJvpWEQn6c0fdlmQ0c=
X-Received: by 2002:a50:cd95:: with SMTP id p21mr7179188edi.12.1595274553667;
 Mon, 20 Jul 2020 12:49:13 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Jul 2020 15:49:02 -0400
Message-ID: <CAHC9VhSYA3SpFCwPx67NNYxgVjpGCDW4ykUO9AJmmVZ=PJoYsQ@mail.gmail.com>
Subject: ANN: libseccomp v2.5.0 released
To:     libseccomp@googlegroups.com, linux-security-module@vger.kernel.org
Cc:     Tom Hromatka <tom.hromatka@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On behalf of the libseccomp project I would like to announce libseccomp v2.5.0!

* https://github.com/seccomp/libseccomp/releases/tag/v2.5.0

The libseccomp v2.5.0 release is backwards compatible with previous
v2.x releases and is a drop-in replacement; no recompilation of
applications is required. Applications will need to be restarted to
take advantage of the new libseccomp release.  While the v2.4.x
release stream will be supported for at least one more maintenance
release, all users and distributions are encouraged to upgrade to
libseccomp v2.5.0.

The core libseccomp library is the work of 56 contributors, and this
release is a significant upgrade over the libseccomp v2.4.x release
stream.  The v2.5.0 release brings new support for RISC-V and seccomp
user notifications along with a number of bug fixes and performance
improvements.  A more detailed list of changes can be seen below:

- Add support for the seccomp user notifications, see the
seccomp_notify_alloc(3), seccomp_notify_receive(3),
seccomp_notify_respond(3) manpages for more information
- Add support for new filter optimization approaches, including a
balanced tree optimization, see the SCMP_FLTATR_CTL_OPTIMIZE filter
attribute for more information
- Add support for the 64-bit RISC-V architecture
- Performance improvements when adding new rules to a filter thanks to
the use of internal shadow transactions and improved syscall lookup
tables
- Properly document the libseccomp API return values and include them
in the stable API promise
- Improvements to the s390 and s390x multiplexed syscall handling
- Multiple fixes and improvements to the libseccomp manpages
- Moved from manually maintained syscall tables to an automatically
generated syscall table in CSV format
- Update the syscall tables to Linux v5.8.0-rc5
- Python bindings and build now default to Python 3.x
- Improvements to the tests have boosted code coverage to over 93%
- Enable Travis CI testing on the aarch64 and ppc64le architectures
- Add code inspection via lgtm.com

-- 
paul moore
www.paul-moore.com
