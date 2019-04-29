Return-Path: <SRS0=32Xp=S7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457F7C43219
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 22:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138A02075E
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 22:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AF2He1xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfD2W45 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:56:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46415 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfD2W45 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 18:56:57 -0400
Received: by mail-io1-f67.google.com with SMTP id p23so10468130iol.13
        for <linux-security-module@vger.kernel.org>; Mon, 29 Apr 2019 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gygjGy0Tx6m/3bovClGd2rLBa0pi6fNkHAIxfSZ8kUM=;
        b=AF2He1xZrzkq68YRqvXpoaCfGbxnrVNa2SJu9UdF1Z6AYKHNfcloWp1li3hqdeB8Yw
         MMLLDS6kIn076fI1Wk86rvhdrAp3CTIc33eVG/u/H06seb031gy2PyWw/pSUSCpXqcs4
         QHWbCKbbkFGOAuP4i2ubnx/2+0b5W+Z3rkMYDMSUq1gvH1tfWVKTYKsR2k7Kmc91wGlR
         P5edMWkg5ant75Z611KNqa0EZJGvVW9z+435VcX94/x/UQIxv6XKzHiP+mMarsqSwTVQ
         le5Aa1ygiTZrQTZWiRMmP7I+cjqXXVUxk9fgBwc7Mmcgsum9SlhUFBYDXshYBzqR4xyK
         569A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gygjGy0Tx6m/3bovClGd2rLBa0pi6fNkHAIxfSZ8kUM=;
        b=TmXaYrhwpyCiAvKXj0ZY6JSZZq+beMFzHxh58whdiNpM4DMRXCqg+/TAyegvHFpXEE
         gHf6gta3hIhEcWt1ctpdZXTV9LOC5YwQVeyEpxzmNIEf9nT6dMS6KPanJTTO6noucWDt
         mxmhuKBN8N+OMZah+fWuPT3jwQ+gQ0WUTegWPcHRLxX5I8IXMSvquCPOgDoYJH52+Yun
         OodEWAE8ZjQGR4aMpVjFuR/eKT62ukmoJO4KwvOFlCa+2cgWnjPm9mw0BT2ck3+Q5wGk
         V++UgXvK4Dwi+DWUg84PDCgw9QhHs9RHDvtG8zCcyTcC6uOghnPwL7yNFQb/WAAwi+sO
         qPhg==
X-Gm-Message-State: APjAAAXJD+/m0XsW0SS7oLLLnWfHrNxwnirSVwOH8v54SfEhu8UNs/08
        F333dYXGv9Ou4x5BmQnZmxeQ0lDU0vF4S8dwDyN2RA==
X-Google-Smtp-Source: APXvYqwELCQYSYxRolEnxOwvku+vu6EGCFx5Boay6oC9nRGmg6H97OlakZWLGo8xgn/GBDkG5aLRGbOMS5HGrk//aDw=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr6314345ioc.169.1556578615904;
 Mon, 29 Apr 2019 15:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com>
In-Reply-To: <20190404003249.14356-2-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Apr 2019 15:56:44 -0700
Message-ID: <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

What's the best way forward with this? I'm still not entirely clear on
how it can be implemented purely as an LSM, but if you have ideas on
what sort of implementation you'd prefer I'm happy to work on that.
