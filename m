Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEBC4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Nov 2023 19:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjKFTcZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Nov 2023 14:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjKFTcW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 14:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C06FA
        for <linux-security-module@vger.kernel.org>; Mon,  6 Nov 2023 11:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699299096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=jQOwbUlxghfqWw/UiGWsqDAGv4FLe9KMoHWLWDf7nJ/nsbRvoCV6GfTnNsQ7TZsBLbJkNh
        uMtTRlsqz5P7lxq+LZ9zP02AECrstuUputrZYnE0/eLG9pN0np5Vsc4Ue9QdiNefrQyH9s
        hF6haQmXeGSM+RSivKskxIOua9VVvIU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-GIHc-LG-MseRzlRarzjMgA-1; Mon, 06 Nov 2023 14:31:33 -0500
X-MC-Unique: GIHc-LG-MseRzlRarzjMgA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77a033cbd96so491577285a.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Nov 2023 11:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299093; x=1699903893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=KT2Wdau+DtdZMaN4SiZI1rQaFFdnTqWSnTHQwwzPQvcQJnFD2CyvvCedURn+0v7epa
         gjnTCw8Dob+3BfSE9Ozc8APVHRjVgV2YchkegFE7rfom2Oqk4Z34i7UkFV/r+m93Mq2B
         lnJPQwdmJD83m71dIVPURyMJFjlNNWRjpL1M6KayTHJkq+vIRoBGE1QKDGPgu5dJctsY
         NUjQ3/Lvj8brS5cjNkY0nEQiaTIRl6f9qvic32fw62zjCMj0wpJTPPv+Bxj940POsooE
         ye5QhmhQaJyxgFqU9e2kiOgD+e8Lr8Sb+1IZZY5bF1Awdx2dkwF3xuFBqZ7URgsbxk6/
         2UIQ==
X-Gm-Message-State: AOJu0YyM+CkRxtPfHhWpF8uHFBYjomZhTsJo/sE6BKTVpCe7Ezlx9Bk4
        0Vw9JF5FjV1A6NQI6inf0r6J4NXhjR2+8FES8ZDbcwFvEx0VfgCLwAGZ/jezEuSUT6JMjyBSE+P
        cU/ng0jkwQSbvFG03YDlBt9O6Tnd7n1gpNDYJ
X-Received: by 2002:a05:620a:31a6:b0:773:c4c8:2d58 with SMTP id bi38-20020a05620a31a600b00773c4c82d58mr33054200qkb.59.1699299093007;
        Mon, 06 Nov 2023 11:31:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMC4OZw13o7zojxKDTLQnTVqildfL87qAiPF2IC97OBWWvfcH0eCZKZ8LoCuggfuWN7AoEdg==
X-Received: by 2002:a05:620a:31a6:b0:773:c4c8:2d58 with SMTP id bi38-20020a05620a31a600b00773c4c82d58mr33054171qkb.59.1699299092693;
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id oo12-20020a05620a530c00b007758b25ac3bsm3555862qkn.82.2023.11.06.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:31:30 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] tpm: Detach tpm_buf_reset() from tpm_buf_init()
Message-ID: <xp2tdlw2qjg3pbazb3oye7poeh4r5neeqbsvamgiazdl2bouwa@qnxhvt7vzkpb>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-4-jarkko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231024011531.442587-4-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

