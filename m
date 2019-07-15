Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50FCC7618F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 19:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C5A20659
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 19:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z40FzhiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfGOT7y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:59:54 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50877 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbfGOT7x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 15:59:53 -0400
Received: by mail-pf1-f202.google.com with SMTP id h27so10827238pfq.17
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OVQw66IG1TeMxfp3qBGrO0Nq5KpRlHDYY3Tp9RJoAOQ=;
        b=Z40FzhiN7QkHIcm/x7gDZHaqhdbVO47xKXmIio3X9TEl7ZUHg90pEn4lcoqCG0D9+n
         mdAXwlxahi+fq0F/hSMkqYP25JZ+J/7ULdCc2Pv2E9Zm8mpBNodj9X65rUwGA50KJFKZ
         8ndCz1zbYqQ1LlHxearlu6JmCtz8AC0c2NxO8Ne3yMHNTHpr5kRxQ0SytQLChXYOKbyl
         7xpf/XXqa6bmJcDLZSKOHYPkH4so0+jl2lZOyrSGHRvgZzklAqXaFL+UG465c98cXhbY
         7hnsthwoJm4iPXB0NbkdrrQubHduIV1aL6zKunghD6eZl69UQlg1rzqAuqQxcsuW8Cr/
         IF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OVQw66IG1TeMxfp3qBGrO0Nq5KpRlHDYY3Tp9RJoAOQ=;
        b=a3zZ0YdhCmS1PHE5jf8ULfO5j1gKo8Y4RUT2rogtWHK//ZZyeofQTKkIlfLUl97c1v
         II/ZSN7jmDrugFOC18qekN3xdBSJNn7Pfnu+QhHi7RGEz/TjK5DOCj2LpW9DsodWct/c
         VDJtduUYEJL+5NPfCHwNWBI1u+2PWSfeT/d0e77NpaFWJP9zQ2BA7n4G3D+f2gwdISAr
         dEVnjnCM9+EOmcEBVInklSpMwCL0xknorehfu3FKb6py8iqQ0+4u1ywBRm2lBVaMuhNj
         cfcupiVJ90QSLDsPzUWuAGd4u5HX+gr537HUSplX014mkeEe5+RSNq8DV0VG35i6dugY
         MU/w==
X-Gm-Message-State: APjAAAVuiy0zxxSCerPGmrO9u5gPecECHa4RXx3HiPMIxJmmkkbJr+Ks
        GsFvFi2SejXYqtELDLLyyBfHr34XLptltlpuKMQoDA==
X-Google-Smtp-Source: APXvYqwcpVzkeCXm6tbCeVNWzSBQUBVwsOErkSfLJInKW26yH5Uxxr2SMb/+OqxhgHFmgFPBQ448BNZj2m/5sN2/HVk81g==
X-Received: by 2002:a65:614a:: with SMTP id o10mr28000193pgv.407.1563220792933;
 Mon, 15 Jul 2019 12:59:52 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:17 -0700
Message-Id: <20190715195946.223443-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 00/29] Kernel lockdown functionality
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Minor updates to the previous patchset to take some review comments into
account - no significant changes in functionality, other than that the
eBPF patch now only disables the kernel read functions as requested.


