Return-Path: <SRS0=LWcd=NX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9D3C43441
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835262241E
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTFoal3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835262241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeKMCgj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:36:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40931 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeKMCgj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Nov 2018 21:36:39 -0500
Received: by mail-oi1-f195.google.com with SMTP id u130-v6so7689987oie.7;
        Mon, 12 Nov 2018 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AnDlZE0AKB0pOzBT5/2FN299AZW3aw7Y9ogqu86XOoc=;
        b=uTFoal3gZAbXv4sfP4wgPwjuJ7wVgxfusp7xWLtM1W3Q0h6U2gqHKuP2vo6RoFgW1F
         WF/+XWv2p+1I5zLCfYI9mIE34w4lsDqtTkSHAO/wTynkfLDPpKmhzvtokTyEELpcQyQT
         z1MoNpmsZz9XyBHkAzN/ycuSMjZHrWQSku3f+PzfjWQ6ldsl51eW8/YjOO+yWEcArB0/
         87cSwkm7k4Jgqe+VaMg9/ZGZIFxmeOLS4IL+p3LQf5efXJPx8XmBpK0PZMdQLwDz7Bcg
         jiesRix4R2DFOHMYzTKIRIEBnShMftazAZCdCL8FYhQ5NAIC4n99ECZxLnz9VGp+540V
         SQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AnDlZE0AKB0pOzBT5/2FN299AZW3aw7Y9ogqu86XOoc=;
        b=rpLZvtr3ZqMusCe9gd2gorzlfinwJpO/LohliDBU+bJOtECUJ3yWUJlhGxUPg0pQCp
         cOHVdM7UN8U1eKELMQ47yrWs7WluDgKbSLFg1Gs4hs/uYZapfaiejIqlC09StBIBmDIT
         vzXmMz+Yb0gbSi760nZbVVQW9ToApPdaY4I/B+vSP51MYhrcVBcZ4dLJLGdRnMU32LaS
         y+n3ZLs/00ZMKHWHp3RyGHzNuTA2aoOm6E0fKQ/Ok4JZt6RGYXsMYb0SzoZ/bvdfryKj
         yG2vCKcyIPzvf1HK24vrv9WexIntA3N/CIY7qjXF4F1uoT9YsZ4x4UqB5tGEv6/vq0LY
         MS6g==
X-Gm-Message-State: AGRZ1gLwfVGqmJJr3jyrs4pJOvUplNuxI/woTOAY6faU1O/RcgNAw7/G
        3l9VTCrQ1rR5Xs5RYXcr4FvG+DMe
X-Google-Smtp-Source: AJdET5cAkHQj1Jr8b7p68BJBTf9++UDX/GzzZN7QSELD6u1/pnU7wroLsrQH5iq3PMovpL9JBNr3PQ==
X-Received: by 2002:aca:4202:: with SMTP id p2-v6mr888762oia.41.1542040957436;
        Mon, 12 Nov 2018 08:42:37 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k132-v6sm5742304oia.46.2018.11.12.08.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:42:36 -0800 (PST)
Subject: Re: [PATCH] integrity: support new struct public_key_signature
 encoding field
To:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <1541946593-4812-1-git-send-email-zohar@linux.ibm.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <ddcdddf8-bdfd-4bf8-463b-84f7d3ed7623@gmail.com>
Date:   Mon, 12 Nov 2018 10:42:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1541946593-4812-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mimi,

On 11/11/2018 08:29 AM, Mimi Zohar wrote:
> On systems with IMA-appraisal enabled with a policy requiring file
> signatures, the "good" signature values are stored on the filesystem as
> extended attributes (security.ima).  Signature verification failure
> would normally be limited to just a particular file (eg. executable),
> but during boot signature verification failure could result in a system
> hang.
> 
> Defining and requiring a new public_key_signature field requires all
> callers of asymmetric signature verification to be updated to reflect
> the change.  This patch updates the integrity asymmetric_verify()
> caller.
> 
> Fixes: 82f94f24475c ("KEYS: Provide software public key query function [ver #2]")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Denis Kenzior <denkenz@gmail.com>
> ---
>   security/integrity/digsig_asymmetric.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Acked/Reviewed by: Denis Kenzior <denkenz@gmail.com>

Regards,
-Denis
