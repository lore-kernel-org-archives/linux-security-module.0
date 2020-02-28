Return-Path: <SRS0=sUyx=4Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBAC3F2C6
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Feb 2020 00:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5885246A6
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Feb 2020 00:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Yfz/dwe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgB1AT6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:19:58 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38462 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbgB1AT6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Feb 2020 19:19:58 -0500
Received: by mail-ed1-f49.google.com with SMTP id e25so1250290edq.5
        for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2020 16:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2d3j7s2zGq88eGCYYBgoxbarV4Ni/c3HRBevGkEtC+E=;
        b=Yfz/dwe7hdNdhDYtvkTgelMe69ujfFAX85cYWLUJYU53XqlSN+ZZIVO/aB0DCnAgFL
         yogQ88Kns2oMaE++fd1ioc2N2YA3rhSIWGxUPQVNwUUwaZJ94WvZaToYjjsAJl2WtSg+
         Vd0ddzcgg2vRzQUJqJ7nyQ9A2mXOxxhOtl4M11RG5iqseFWr7LbBeUkZTJmYhrNuOXMK
         AB05ktDQXHyDMMmWM0k+KUUpk8vzLGtL/VytNgjXAAHrp6/sPyeIuJbSV4jmQW710DQo
         F+u24b0n1W1duGvwDZrzJjxGZ2T4VDsyEWfvhKbpvcgQJCqD0NDB/icLPmra5QwK4NtW
         CwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2d3j7s2zGq88eGCYYBgoxbarV4Ni/c3HRBevGkEtC+E=;
        b=FFusTMfIzoXgf890Oa2PXtI+d3rhEXKLRwOPn8B5pKIUcifjyC6ojGL4+UgbeuludT
         8TW9gC2n/HL2qRJFQ7VFuB5uN3z4lQDUVe6DUQkIIYbwnDLRKU1wSMjcUfjaZdHL5Brf
         xaOzcOHQMzwnP1nAJvzB7b0ifJDXBl9tiyjM7qO2h0auSCmeIO/lhLufOSW/cdtD1r/b
         shv6Nar6Wu7rilADI1uq2dljWut9kcjRp82W6s0dm7XMQMZLDQ9M9Pdu2ov+inackTgy
         UkKzJa/4cWTOyGeY/TtOnNH/DDZY5jBKPgWW8fyEpPZF0SqcwPmrnnjH9Tr+FGQCKgIW
         n6Rg==
X-Gm-Message-State: APjAAAU2cnd3nTqNGv+uZ5ozrs29wbgfoobtj2f+IaWycbEJbXJLQFrM
        IobQC3Ea5cKg8Ee121+NsKiebc0vIXwStqx5C5jg
X-Google-Smtp-Source: APXvYqycdKQhyyKfJtxSH8zFdmErASq74BrOhKNx/usCq0ra+pIFWn/buWSihr6hm/uLdvEdOyGT0fgoOOVh5OJlINY=
X-Received: by 2002:a50:e108:: with SMTP id h8mr1057844edl.196.1582849195142;
 Thu, 27 Feb 2020 16:19:55 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Feb 2020 19:19:43 -0500
Message-ID: <CAHC9VhQ=W4R2LGCxaKzVEx4J31m4-F7mDo2BOMTqso2JdScHzw@mail.gmail.com>
Subject: Please revert SELinux/keys patches from the keys linux-next branch
To:     dhowells@redhat.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi David,

For some reason we haven't been able to get your attention on the
related SELinux mailing list threads, but we need you to revert commit
f981a85690dc ("security/selinux: Add support for new key permissions")
from your linux-next branch.  Can you please do that?

-- 
paul moore
www.paul-moore.com
