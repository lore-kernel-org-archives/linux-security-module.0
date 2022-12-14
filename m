Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C361C001B2
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 04:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiLNEGM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 23:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiLNEGE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 23:06:04 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE72793D
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 20:06:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so2098965plj.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 20:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hY72Xdn9gifxeOGEwVJkBQTRe/qRttufPM4JxryG5Nc=;
        b=hnCosuXWj3Jm58xhJLkRcC5izYjig4vTm02LRuRwp6CoaTOJQpVkcib9G5j62bvFnq
         g4rA9VG3DFCAnFqe5+vCxZLB3OHOS3bdOx2XhMC9v/9IwaZ70tClrq9nswKgAypnvCXT
         3v0zHJ23hplGxu6biI/61NqWEvdnvec963RhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY72Xdn9gifxeOGEwVJkBQTRe/qRttufPM4JxryG5Nc=;
        b=SiSRb2C/2hOqoQS/3x9AjEwdF90H1eMyxl9laADYoJZWMwaXXGHDDcoN4wBXR9APiJ
         YAJgxEwO5Lv7EmxE6MR+ciRZQzRQwXTMnREIixqtsn1dcbjzeyW9kl3h60VuvpE2WCLf
         sLvkTsVupEBjLX3y5bkFnHepVfTUcku8FImQzxzqqBFEGTBejEd9IFn+Ddj8SteU7sE8
         35sGyaWNDeRtl56hulYoLze9l7j1Nyx2OuWrDDCULZ9+fiUlJ1MnV3Zcodiiclqrkp0h
         Ml6MxrDb0XeZCk6qel+G8nqZ6lHj1P4Ou+hDqKmt5jLEZkb2NHzjXGdyEeZi0uOB3sds
         7ihw==
X-Gm-Message-State: ANoB5pnGWUE6hZXXErvNB6MRTYZIsN/8P4t/oFPz1DX7QtvVDPd53LBg
        Om2JGzUsmZ+toj1cmP6EwDc+Xg==
X-Google-Smtp-Source: AA0mqf412usYjXpIYB2lo1hM5Q9K9gGmOT6n2BVm1WR+TraRXD0nwK0Cygldd5STdDCw7wQ9D5dybg==
X-Received: by 2002:a05:6a21:9103:b0:a3:9aa3:c060 with SMTP id tn3-20020a056a21910300b000a39aa3c060mr30005858pzb.53.1670990761987;
        Tue, 13 Dec 2022 20:06:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l7-20020a635707000000b004788780dd8esm7424665pgb.63.2022.12.13.20.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 20:06:01 -0800 (PST)
Date:   Tue, 13 Dec 2022 20:06:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Paul Moore <paul@paul-moore.com>, gregkh@linuxfoundation.org,
        jmorris@namei.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        zohar@linux.ibm.com
Subject: Re: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
Message-ID: <202212132005.A3A0B43D@keescook>
References: <20221209195453.never.494-kees@kernel.org>
 <20221209195453.never.494-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209195453.never.494-kees@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 14, 2022 at 11:51:15AM +0800, Ping-Ke Shih wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> > LoadPin only enforces the read-only origin of kernel file reads. Whether
> > or not it was a partial read isn't important. Remove the overly
> > conservative checks so that things like partial firmware reads will
> > succeed (i.e. reading a firmware header).
> > 
> > Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Tested-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for testing!

-Kees

> 
> > ---
> >  security/loadpin/loadpin.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> > index de41621f4998..110a5ab2b46b 100644
> > --- a/security/loadpin/loadpin.c
> > +++ b/security/loadpin/loadpin.c
> > @@ -122,21 +122,11 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
> >  	}
> >  }
> >  
> > -static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> > -			     bool contents)
> > +static int loadpin_check(struct file *file, enum kernel_read_file_id id)
> >  {
> >  	struct super_block *load_root;
> >  	const char *origin = kernel_read_file_id_str(id);
> >  
> > -	/*
> > -	 * If we will not know that we'll be seeing the full contents
> > -	 * then we cannot trust a load will be complete and unchanged
> > -	 * off disk. Treat all contents=false hooks as if there were
> > -	 * no associated file struct.
> > -	 */
> > -	if (!contents)
> > -		file = NULL;
> > -
> >  	/* If the file id is excluded, ignore the pinning. */
> >  	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
> >  	    ignore_read_file_id[id]) {
> > @@ -192,9 +182,25 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> >  	return 0;
> >  }
> >  
> > +static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> > +			     bool contents)
> > +{
> > +	/*
> > +	 * LoadPin only cares about the _origin_ of a file, not its
> > +	 * contents, so we can ignore the "are full contents available"
> > +	 * argument here.
> > +	 */
> > +	return loadpin_check(file, id);
> > +}
> > +
> >  static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
> >  {
> > -	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
> > +	/*
> > +	 * LoadPin only cares about the _origin_ of a file, not its
> > +	 * contents, so a NULL file is passed, and we can ignore the
> > +	 * state of "contents".
> > +	 */
> > +	return loadpin_check(NULL, (enum kernel_read_file_id) id);
> >  }
> >  
> >  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
> > -- 
> > 2.34.1
> 
> 

-- 
Kees Cook
