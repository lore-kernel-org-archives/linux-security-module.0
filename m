Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5542C433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Nov 2022 13:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiKDNWC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiKDNWB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Nov 2022 09:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706032D1CE
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667568060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=4z+uaTyHS1euo8ITS5ujuXPAETlqQ178964oXSUna1g=;
        b=jUlEdvbzYxc6ueCohRe6/d6XwBHK/ISFTtcB0A5QBFib8LzyWYSHvFfGz1KFR1+C8QLety
        iARyMnL9qQIv7/YQWQaai3ZmQVA0TyLrAxI1teOOLmISz1qgGvx3spsb99s/QBJS+xAg4s
        W1rCo5qjzVOVKmWuthOW/xIidT+WS7o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-K57gnwKwMGmIWrPuMUCxHQ-1; Fri, 04 Nov 2022 09:20:57 -0400
X-MC-Unique: K57gnwKwMGmIWrPuMUCxHQ-1
Received: by mail-pl1-f199.google.com with SMTP id p5-20020a170902e74500b001884ba979f8so3588501plf.17
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z+uaTyHS1euo8ITS5ujuXPAETlqQ178964oXSUna1g=;
        b=UlBBrBUWY8cewA1nYRZYZkl7MunVGMTkFFG4mxp1KABb0Jt/VyaaCkiENN3BhswbOs
         p4JnYyhp7lvJp8yrW/hznPmGrwITfNc8hRWvy6awQ3HLJ8n1P9r9BDJWOf/cjNOsvmUn
         iNTDBqZQ4Vxusd6kqoW1UjlQPyuUAuiXO05MELVsW8OYaPZVT/P6qXFQio2LjQouORJH
         B4mEv3AMAguoCshUVJ60k5pGdGqyHrBLuOTcD0ng5jdvQqKhA5fu7XYJ6s1u44+kmYvo
         cwLTEvA3dpITSYiSMPXi4NA0bl2Z8OunIwEQyXs4sifrcXrwdPzMTXPLK24MrltC21nM
         xIKQ==
X-Gm-Message-State: ACrzQf2VgnPfoq8brcuATB4107FgCDNy777wo4veJITCriZFLjhU+xJq
        oTFPXKFNzpWXtVUUGImLJ+8zVxzsj6LyJztKcbltuGMj/n3nUs2+2CsSfIVT2ZstBzyhoykUB4j
        ylZ4/0fb7p4he8LfKd/L1SXsWozuydpCbHDEX
X-Received: by 2002:a17:902:e8d4:b0:177:e4c7:e8b7 with SMTP id v20-20020a170902e8d400b00177e4c7e8b7mr329602plg.118.1667568056599;
        Fri, 04 Nov 2022 06:20:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XbTeqtZliMwzZ7MGO3ejsjE4fdEnYbMsIkDBmckaWvRU+DhCnC80HUipTcPjnE/pSnZOacw==
X-Received: by 2002:a17:902:e8d4:b0:177:e4c7:e8b7 with SMTP id v20-20020a170902e8d400b00177e4c7e8b7mr329594plg.118.1667568056353;
        Fri, 04 Nov 2022 06:20:56 -0700 (PDT)
Received: from localhost ([240e:479:210:84fd:b8ac:1631:3300:5ef])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001780e4e6b65sm2597596plb.114.2022.11.04.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:20:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 21:20:35 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     eric.snowberg@oracle.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        dmitry.kasatkin@gmail.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nramas@linux.microsoft.com,
        pvorel@suse.cz, roberto.sassu@huawei.com, serge@hallyn.com,
        tiwai@suse.de, zohar@linux.ibm.com
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Message-ID: <20221104132035.rmavewmeo6ceyjou@Rk>
MIME-Version: 1.0
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Eric,

I wonder if there is any update on this work? I would be glad to do
anything that may be helpful including testing a new version of code.

-- 
Best regards,
Coiby

