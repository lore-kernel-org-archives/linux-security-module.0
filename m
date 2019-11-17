Return-Path: <SRS0=K/4e=ZJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB62C432C3
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Nov 2019 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521DD2084C
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Nov 2019 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaLBobCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfKQSIz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 17 Nov 2019 13:08:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbfKQSIz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Nov 2019 13:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574014134;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSxCHgdI3j2NAMCC1olhatH3DrTY9N/2Xvc86ib3ruI=;
        b=IaLBobCiEG+ukMbaGJ80Zv9LrZBxQhqtwPpnBjBJi6TUI3enH8Xc0ncrFOlzocZyIvv/nz
        dctUAFqAcVKyJJ28iQb1xGdyP06sw85cS8EGkic1ovyTY+PX2eCh3hst17dnHxa1BuupvB
        kOWJGml8zlnldFx8vLF2yxldd/l3aEc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-sDg9o_nVOkaw0YNuMnJJlg-1; Sun, 17 Nov 2019 13:08:51 -0500
Received: by mail-pg1-f200.google.com with SMTP id w9so11519617pgl.1
        for <linux-security-module@vger.kernel.org>; Sun, 17 Nov 2019 10:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=nhPTTch4TLiEOOJDKHZfBwdD5XFDvnafgmAjZS61rz8=;
        b=JJ05qRRo4KpoVrDFo99xVjbYlgss74EptElnhLPPAVVtXirqDunLcnZCmpg7IoVZ+T
         Ts930dkvMM1oxjMFaTwnAQUfcEzK9WICUD12eHFUD0AD0ZhQusHwQ1Yzim6IJ5T369yB
         aFF/ZXh2okfKXrnhhVdwyfL1L2i5/5sOBuZu7xWkWicXWDc4hQ6at36eICYtqaaaZpSC
         5yKyTc3chfOJ68OVgQxJkrEk8opSk580+nA2zKnItbgoC/5YdVcZNUaSqW/yhcDjVW9f
         M5sudwCJ8JyDDt2RLrknRjp4pmD7VEZ8YDB5l3MJDx4pEB3U1I5Qf4a/BSvJojB3JmyJ
         Ck1w==
X-Gm-Message-State: APjAAAX/f1rSBcGUSLChdCNW/Wt/byggcH2T//l8BSwC+dGa1Ueug12t
        l6rLPiwdubE/eKh1PdUw7F337a+z+g4tQ33gzQ59yR9qPZ+gwW7Po7eZNsPMOVg/XFRT6p9bPfi
        ZXLnsVbOiupJyWdRcGONLKInXrti+ODJGyizr
X-Received: by 2002:a63:cc56:: with SMTP id q22mr10365503pgi.439.1574014130314;
        Sun, 17 Nov 2019 10:08:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxg590xxVEGOOIe1dNaEgjxSEw82NPd5dgH3ztF+eBVj9rHMhiez57C0XKIHEcdFsYXYYKOBA==
X-Received: by 2002:a63:cc56:: with SMTP id q22mr10365473pgi.439.1574014130039;
        Sun, 17 Nov 2019 10:08:50 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j186sm17803718pfg.161.2019.11.17.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 10:08:48 -0800 (PST)
Date:   Sun, 17 Nov 2019 11:08:47 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191117180847.322467cqngpbpael@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
 <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
X-MC-Unique: sDg9o_nVOkaw0YNuMnJJlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat Nov 16 19, Stefan Berger wrote:
>On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
>>On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
>>>On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
>>>>From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>>Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
>>>>tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
>>>>This move handles error conditions better that may arise if anything
>>>>before fails in tpm_tis_probe_irq_single.
>>>>
>>>>Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>What about just changing the condition?
>>Also cannot take this since it is not a bug (no fixes tag).
>
>I'll repost but will wait until Jerry has tested it on that machine.
>
>=A0=A0 Stefan
>

Sorry, I'm still waiting to hear back from the reporter, and logistics
for some reason has been silent on my request so far.

>
>>
>>/Jarkko
>
>

