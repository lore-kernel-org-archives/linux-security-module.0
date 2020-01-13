Return-Path: <SRS0=WVaQ=3C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B171FC33CAC
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jan 2020 09:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE542084D
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jan 2020 09:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LONkt8qU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgAMJm0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:42:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAMJmW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jan 2020 04:42:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so7756611wrl.13
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2020 01:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/AnYXrXWYvNhwGCXjTJAreL3RYx7ZKU0okhiknvPq1k=;
        b=LONkt8qUSVzgSpJ3vYRz5tdEdUTiIp7lBSpk8CgEbr+mU66cFuYcwYwY0Gt33ed63d
         Za4k2QokkwkSZrYzZ458SxLbyR6U5j4nYTd1ZGpkw/SI17H4TkFXcEXQ4D3KzgxNTSn+
         bxLdeS1EG1MKd28ac5FKeVtvQ/x1eACkxMXNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/AnYXrXWYvNhwGCXjTJAreL3RYx7ZKU0okhiknvPq1k=;
        b=l5y5lhN/GHx1IT3Uf1m/X6UACOqcLrrPYaBg3veZ3xa77ySyvwc1fSOuLx9KzJEK8M
         eYLm0Wxc0167gq8mtIzZn1j4Y5oKc5CMB4yxFIzhkc7BAGtdgaeGQ7p76RqQXmkv6+ek
         1/OQATi+8ofKryFzsYI5uj9boE4Ay32GMF3xitlFo7jUmk3IzRR1/GJNYOm+3nMUWDfF
         T34QAM/zqPgpay2jRq5YWMVvC+TKiM9g6KkfO//aiUyvUoVl/NqkhW1bn6tY2VYzgx9W
         DlquLs6VVcF3pnMdVKrLKSHD2ER7aYJ4++OH8ch4KY11BZAaCmNYNpOuxwpqQYEchxtm
         SFew==
X-Gm-Message-State: APjAAAXgKgz7FfJGLtV48DEQdudUA1Pmn+NXuz2zCNm5apsVDPdU+tfS
        7jztrrqywI63Vmd5O94nukn7bQ==
X-Google-Smtp-Source: APXvYqxxI6qdgEBxTJuEUk3JhYcPPt1IsOdKJoSHupf9NxOVFJcQPh2xufJhPakK9fflGvmxnk0P3g==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr16362892wrt.136.1578908539527;
        Mon, 13 Jan 2020 01:42:19 -0800 (PST)
Received: from ?IPv6:2a00:79e0:42:204:51d1:d96e:f72e:c8c0? ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id e18sm14474206wrr.95.2020.01.13.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 01:42:19 -0800 (PST)
Message-ID: <a8d344e7d9c4683ad87ec0aaf32eabcbfb0f48fb.camel@chromium.org>
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
From:   Florent Revest <revest@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Mon, 13 Jan 2020 10:42:18 +0100
In-Reply-To: <1578499556.5222.157.camel@linux.ibm.com>
References: <20200106162524.164650-1-revest@chromium.org>
         <1578499556.5222.157.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-01-08 at 11:05 -0500, Mimi Zohar wrote:
> On Mon, 2020-01-06 at 17:25 +0100, Florent Revest wrote:
> > From: Florent Revest <revest@google.com>
> > 
> > This allows other parts of the kernel (perhaps a stacked LSM
> > allowing
> > system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the
> > hash
> > of a given file from IMA if it's present in the iint cache.
> > 
> > It's true that the existence of the hash means that it's also in
> > the
> > audit logs or in
> > /sys/kernel/security/ima/ascii_runtime_measurements,
> > but it can be difficult to pull that information out for every
> > subsequent exec.  This is especially true if a given host has been
> > up
> > for a long time and the file was first measured a long time ago.
> > 
> > This is based on Peter Moody's patch:
> >  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> 
> FYI, but unlike the audit log/IMA measurement list, the iint cache
> entries can be removed.  Refer to security_inode_free().  Perhaps
> mention of this difference should be included, here, in the patch
> description.

Sure, I added a comment about this in a v3.

> > [1] https://lkml.org/lkml/2019/9/10/393
> > 
> > Signed-off-by: Florent Revest <revest@google.com>
> 
> Assuming, with the above difference, you're still interested in
> having this feature upstreamed and addressing the comments above and
> below:
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thank you. Yes we are still interested in this feature!

> > ---
> >  include/linux/ima.h               |  6 ++++
> >  security/integrity/ima/ima_main.c | 46
> > +++++++++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 6d904754d858..d621c65ba9a5 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -23,6 +23,7 @@ extern int ima_read_file(struct file *file, enum
> > kernel_read_file_id id);
> >  extern int ima_post_read_file(struct file *file, void *buf, loff_t
> > size,
> >  			      enum kernel_read_file_id id);
> >  extern void ima_post_path_mknod(struct dentry *dentry);
> > +extern int ima_file_hash(struct file *file, char *buf, size_t
> > buf_size);
> >  extern void ima_kexec_cmdline(const void *buf, int size);
> >  
> >  #ifdef CONFIG_IMA_KEXEC
> > @@ -91,6 +92,11 @@ static inline void ima_post_path_mknod(struct
> > dentry *dentry)
> >  	return;
> >  }
> >  
> > +static inline int ima_file_hash(struct file *file, char *buf,
> > size_t buf_size)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static inline void ima_kexec_cmdline(const void *buf, int size) {}
> >  #endif /* CONFIG_IMA */
> >  
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index d7e987baf127..3799b6c6c3b8 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -445,6 +445,52 @@ int ima_file_check(struct file *file, int
> > mask)
> >  }
> >  EXPORT_SYMBOL_GPL(ima_file_check);
> >  
> > +/**
> > + * ima_file_hash - return the stored measurement if a file has
> > been hashed.
> > + * @file: pointer to the file
> > + * @buf: buffer in which to store the hash
> > + * @buf_size: length of the buffer
> > + *
> > + * On success, return the hash algorithm (as defined in the enum
> > hash_algo).
> > + * If buf is not NULL, this function also outputs the hash into
> > buf.
> 
> As of Linux 5.4.y, IMA support for appended file signatures was
> added. Should we indicate that the file hash returned is based on the
> entire file, including the appended signature?
> 
> Mimi

Of course it never hurts to add a comment. :) I'll send a v3 with this
added.

> 
> > + * If the hash is larger than buf_size, then only buf_size bytes
> > will be copied.
> > + * It generally just makes sense to pass a buffer capable of
> > holding the largest
> > + * possible hash: IMA_MAX_DIGEST_SIZE
> > + *
> > + * If IMA is disabled or if no measurement is available, return
> > -EOPNOTSUPP.
> > + * If the parameters are incorrect, return -EINVAL.
> > + */
> > +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> > +{
> > +	struct inode *inode;
> > +	struct integrity_iint_cache *iint;
> > +	int hash_algo;
> > +
> > +	if (!file)
> > +		return -EINVAL;
> > +
> > +	if (!ima_policy_flag)
> > +		return -EOPNOTSUPP;
> > +
> > +	inode = file_inode(file);
> > +	iint = integrity_iint_find(inode);
> > +	if (!iint)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&iint->mutex);
> > +	if (buf) {
> > +		size_t copied_size;
> > +
> > +		copied_size = min_t(size_t, iint->ima_hash->length,
> > buf_size);
> > +		memcpy(buf, iint->ima_hash->digest, copied_size);
> > +	}
> > +	hash_algo = iint->ima_hash->algo;
> > +	mutex_unlock(&iint->mutex);
> > +
> > +	return hash_algo;
> > +}
> > +EXPORT_SYMBOL_GPL(ima_file_hash);
> > +
> >  /**
> >   * ima_post_create_tmpfile - mark newly created tmpfile as new
> >   * @file : newly created tmpfile

