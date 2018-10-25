Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDA3ECDE46
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEBB2054F
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xdmr/J/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEBB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeJZFBB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:01:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34374 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeJZFBB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Oct 2018 01:01:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id n26-v6so7830616lfl.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEx6wTAtxpXIkFKcFNoT1Bo/YKcSYnIa2M4hPw7qvVo=;
        b=Xdmr/J/f+oNW1BfFZIdhjVEfgSM9RHek4iqHCMJ+vGXUUFSVs5kDoukBvxFqk87L/C
         sgsp4IkmtRWUBPApwJUPzhfAke8oDOht4pR954691+DpUfDCJdxd5UHhC17344Dm3QEK
         9Rc5F8XFP6uurHQQ9v3Rde3K7CtEXZ/7GVrSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEx6wTAtxpXIkFKcFNoT1Bo/YKcSYnIa2M4hPw7qvVo=;
        b=FAAfjy7ogJqXQ6wTQYmqFcd2QkY3kKzcEkHDJ4uN5y5zZxyExQTgtKMHOstxLXF7Sn
         7SSCUb1tbIjVoLtCyYYNWIDt/mkyDlxUkKZHVbeV15G0U9C/vXimwLFN6apCed1k6RQO
         WEP/mB1XF+DCd2qH+wWtFZFd+s5UnM9PJ1mOyS49nnKSWMqC0qYgLGe13esYrKUltDok
         AqCyjXfpVTzzKtX+6wzT53R/nQsUjNClDaslHT3VfTxgZqOhDuLrJBEk1lfjP07TlESI
         bMPloSqii73VJ68WSnJ63ZySSxb+iRRqECdfVaQEveE0vIbFEqCwB2HuxcNSylKu6PlB
         MIng==
X-Gm-Message-State: AGRZ1gIdCGXIoy57PdBbeDh9PXVpy8VWXfLHz4/rQ2UlQxTnyIRWesx+
        p0Yy8Ij3tLXdJKGFM+5IRpTLl1NaA5kBVQ==
X-Google-Smtp-Source: AJdET5dQWEMh0iImmN5RMV+QgJxzYPq2ow63zEo+4Ct4/Yme6BwDbJhXpBD8nJm5XczMERw7c75l2g==
X-Received: by 2002:a19:17d8:: with SMTP id 85mr421368lfx.5.1540499207295;
        Thu, 25 Oct 2018 13:26:47 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 9-v6sm1264643lju.61.2018.10.25.13.26.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:26:46 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h192so2875050lfg.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:26:46 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr414428lfi.138.1540499205935;
 Thu, 25 Oct 2018 13:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810252032230.30470@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810252032230.30470@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 13:26:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyh8P4jwOoffW-2CHcuQLZuTf2+YZWnudALcxkeBUj=A@mail.gmail.com>
Message-ID: <CAHk-=wgyh8P4jwOoffW-2CHcuQLZuTf2+YZWnudALcxkeBUj=A@mail.gmail.com>
Subject: Re: [GIT PULL] security: TPM updates for v4.20
To:     jmorris@namei.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 25, 2018 at 2:35 AM James Morris <jmorris@namei.org> wrote:
>
> From Jarkko: "These are the updates to v4.20. The only new feature is
> non-blocking operation for /dev/tpm0."

Pulled,

                  Linus
