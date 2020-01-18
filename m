Return-Path: <SRS0=9ABi=3H=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23654C32771
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jan 2020 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D1A2176D
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jan 2020 17:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NNLdCDc2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NNLdCDc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgARRza (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:55:30 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50724 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgARRz3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 18 Jan 2020 12:55:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 56C7A8EE2AB;
        Sat, 18 Jan 2020 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579370129;
        bh=V4bj38Jmyfpffwm4ybT9rv/2Gr5czbyWSE4U0HdmjRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NNLdCDc2T/cCtpJyDzPAnpQ/xfjAxsLl7ksZ2EHRjNTkRm7CO2IKVxTzG+KKB8n92
         lVViakNoqglFjc6Ozor7I+Ut98rYhpD5k/PrT+qc+Co3uWA/1JorGmktedxanZ11Py
         1ZibMadZd0C26Xad+qfyOLipDUnYlMkxGzWHgS98=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YHxP8T0xBaqT; Sat, 18 Jan 2020 09:55:29 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B3D9F8EE17D;
        Sat, 18 Jan 2020 09:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579370129;
        bh=V4bj38Jmyfpffwm4ybT9rv/2Gr5czbyWSE4U0HdmjRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NNLdCDc2T/cCtpJyDzPAnpQ/xfjAxsLl7ksZ2EHRjNTkRm7CO2IKVxTzG+KKB8n92
         lVViakNoqglFjc6Ozor7I+Ut98rYhpD5k/PrT+qc+Co3uWA/1JorGmktedxanZ11Py
         1ZibMadZd0C26Xad+qfyOLipDUnYlMkxGzWHgS98=
Message-ID: <1579370126.3421.19.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 2/2] dm-crypt: Use any key type which is registered
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Franck LENORMAND <franck.lenormand@nxp.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     horia.geanta@nxp.com, silvano.dininno@nxp.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com
Date:   Sat, 18 Jan 2020 09:55:26 -0800
In-Reply-To: <1551456599-10603-3-git-send-email-franck.lenormand@nxp.com>
References: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
         <1551456599-10603-3-git-send-email-franck.lenormand@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2019-03-01 at 17:09 +0100, Franck LENORMAND wrote:
> @@ -2025,16 +2027,15 @@ static int crypt_set_keyring_key(struct
> crypt_config *cc, const char *key_string
>  	if (!key_desc || key_desc == key_string || !strlen(key_desc
> + 1))
>  		return -EINVAL;
>  
> -	if (strncmp(key_string, "logon:", key_desc - key_string + 1)
> &&
> -	    strncmp(key_string, "user:", key_desc - key_string + 1))
> -		return -EINVAL;
> +	type = get_key_type(key_string, key_desc - key_string);
> +	if (!type)
> +		return -ENOENT;

You can't do this.  This check ensures that the key responds correctly
to user_key_payload_locked() lower down.  To do that, the payload has
to be in a specific form.  You ensured that yours are, but dm-crypt
will now accept any key type, load the user payload blindly and create
all sorts of mayhem in the kernel because of the structural differences
in payload types.

James

