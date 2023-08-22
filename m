Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27F3EE49A3
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Aug 2023 01:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjHWBjQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Aug 2023 21:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBjQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Aug 2023 21:39:16 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:39:14 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79981E46
        for <linux-security-module@vger.kernel.org>; Tue, 22 Aug 2023 18:39:14 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-35-64e54ad38729
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 9F.CA.10987.3DA45E46; Wed, 23 Aug 2023 04:54:59 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=UYcdebJtwrn4zCM2qj60cDtsgKvT6Fik+QUGbfZdDFzv1KWZqKaEsbcmvTujZR2Gn
          bz9ggIYr056VFlHaAEv9rrSyguAWJF5Ba33NFXDH8NPZBqtm54ZVtSDhZyi695i5w
          ceFYhbIaA06f6z6r8JkbC/73fV7vHQYC+PzRDnYhc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=j+qtB2Aqe0ADgVemYDfZu1fnqgksLUgegox4LXbhSerW1T5qiy4Hy21S5LDvp/WH9
          YUdGa92rlbEYxX8d4cBejCP3Cd3yat2Gvo5SDXHT9/9vYaefusnK9FRg2V3qiV0zS
          wT+xHR2lG8Wn058MQ5JLy6hAMwc5afriHDUmB7Q1w=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:07 +0500
Message-ID: <9F.CA.10987.3DA45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-security-module@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:21 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW/ey19MUg8n7lC0+9Dxic2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCReHqyg7WLkYtDSGAP
        k8TqeRuYQBwWgdXMEndX/2CHcB4yS+z48Y4dpEVIoJlR4tARTRCbV8Ba4vGaX2CjmAX0JG5M
        ncIGEReUODnzCQtEXFti2cLXzF2MHEC2msTXrhKQsLCAmMSnacvARooIaEocm74erJVNQF9i
        xddmRhCbRUBVYsbSSVBrpSQ2XlnPNoGRfxaSbbOQbJuFZNsshG0LGFlWMUoUV+YmAkMt2UQv
        OT+3OLGkWC8vtUSvIHsTIzAMT9doyu1gXHop8RCjAAejEg/vz3VPUoRYE8uAug4xSnAwK4nw
        Sn9/mCLEm5JYWZValB9fVJqTWnyIUZqDRUmc11boWbKQQHpiSWp2ampBahFMlomDU6qBca6Z
        b3z3kfQFR5LndMRuq5bvuqzTar7iV+OEjyoTL3DyPy+/Gfua9fEN8V0818++k2l9X+b47u6S
        mz4fNKv97k2veptV47P5ZPy/SianC7K7e0JDJ6wID3sbduFwY7n3vyczPk2dfTlJsf9dp69i
        00rZG29UV2yM11my81Wra13FtLN7pbRu5ymxFGckGmoxFxUnAgDcXAX7PwIAAA==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

