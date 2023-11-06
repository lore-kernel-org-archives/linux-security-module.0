Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE96C4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Nov 2023 19:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjKFT1l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Nov 2023 14:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFT1k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 14:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8EFA
        for <linux-security-module@vger.kernel.org>; Mon,  6 Nov 2023 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699298813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C/WjxiCVsJz9f1oEP2Y4XakhqVX5j64dRCa7+qXYyE=;
        b=hqKzvSPDj2j3nBxuFmkXuNVbKviSYy4lYQJMnseMRcM1yc2kSPAIn/7taFCPe0kOMoVfJp
        s0mNEbD+UR4xk3P/fI8exPD5R1x4k1J5LijLoq/kpYUzmkdpDCbh9yE56ccApraPjMZPqf
        q5OucSFqHKuYcoQoDjyyP43t0lXYK4g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-eUjdf2ckOIi5VFUlhHQ0sQ-1; Mon, 06 Nov 2023 14:26:49 -0500
X-MC-Unique: eUjdf2ckOIi5VFUlhHQ0sQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-778a2e84830so533706285a.3
        for <linux-security-module@vger.kernel.org>; Mon, 06 Nov 2023 11:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298809; x=1699903609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C/WjxiCVsJz9f1oEP2Y4XakhqVX5j64dRCa7+qXYyE=;
        b=lUEo8B5vMlB3zj06aVabuqC958nEgB4z+NXI8L0fing1k9UIZ54+RKGU6qE6EOUyRn
         Qcao6tBu4AV1RwVaM8h33AQ+HrXnX0WbmO7EUjK2hVDhRy4ShyXponfYJ7bwbubMTKbQ
         Wq22abcvKhRaBEXl4kpz6C08DW4yUtHQpfcYWUjc7NMBY45qIWEMuEsa5WqHjvrkW/1i
         lZgms83fbY/Hs+vSegcD7gSCQEUkCNC3utFFx50Zm52oONpNQcQyf6FZl48PMHAYPjRQ
         +gd2FFDC94r9F/IJLvw2IoMhNYVoId0rEVQQirPabCEL9GFEXylukOPfM4gItPi9h1xk
         Wo0Q==
X-Gm-Message-State: AOJu0YwlUP6LOHAAAqCg2/EGsTq9PQebZDNAPCnEl2+PqJr74fnHF43s
        m9IODmFhk47IBw9BCm9q0Ic7Kle8jvnVE9BNA0Jl4ZCUgY6Wjh2vdnGbwHe3YHUo1NAf1Uvf3EU
        7a7I6wglEikdbgY5ouICDU0/noaifKaxGq71C
X-Received: by 2002:a05:620a:444b:b0:778:9542:a765 with SMTP id w11-20020a05620a444b00b007789542a765mr40268971qkp.64.1699298809015;
        Mon, 06 Nov 2023 11:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4J4SaJitD2GuvTLmTEH/lixSVaiP4mCjrPIimN2+kmtJXKyqkH9XwjIiR80Gp98vcOrUInw==
X-Received: by 2002:a05:620a:444b:b0:778:9542:a765 with SMTP id w11-20020a05620a444b00b007789542a765mr40268946qkp.64.1699298808800;
        Mon, 06 Nov 2023 11:26:48 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9f808000000b007756e75b91bsm3554551qkh.78.2023.11.06.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:26:48 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:26:46 -0700
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
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
Message-ID: <lifu6orgfo57usei3szyfrmr6ofl37477gji5xh5bwkhftswxg@cjwwa5okjshi>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231024011531.442587-3-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

