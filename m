Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213098;
	b=lwI0wqHPXI3KsOLFttaD9Pti4+F4P3PmRaMRnel0r8SlDUlTSoYIFXkwjT3geyRltuEm
	 Edumu7K68FP4nfAAwJuZTyGPlPD+rpt4QG18F/jGDkYClQjuJHygqF9CbEhluW1debkKo
	 8xh9jZZgeZka+gJCxOmR9uwSB0Yd2BnFhtd0l2T3Q3NqAywYb6xVHyLRfdZ6D1tKYweFU
	 7XQJWYq78yx6+7tIySr2crJeiVuKyd8+iH7nbtD3JXvHQdjrzCTz3+reuHznLNDyUJNec
	 H7TpfzU2W5FrDUipXNJBmXePLin7e0uQMJrr7IDNWjD4O1lDGe1zZN8wqPX7TJJbRzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=QH8BhOkVwEDMLAd4eMuzUXkRIOCXHprCiQlbx8/819w=;
	b=ULaithAfAZpIVXyMMpWd1zf7YS+jL+pJLdKFT058D2U3p7Y3ob+79+BoCnGkR0hF8PAI
	 ZZSi9L7UVepOFvjx4ezMW7a8eoSxl1a0ATCxZpnATRvi6H0U2f0AMtMHqZgyewvKdW+AU
	 eCay4XaFe6jnWU0Qi8RRWb9Hkq7Cv0OWh4gRixByM+SzSIUUXny02qTLYG/j6Bcibj5R4
	 rkpFSZ9KPQAFAPjrMf1i+/UEX4VAR1fwj+B91HjD2DNsLqYuhs2hAG41m9ICTU20y+ZEw
	 92yUu42XHi9GYEmMvJ5CdIMwUPMrH5ZyrvBOySiPCLpa4YrMW7wQHyWaOGWqZX0Xoag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JQnQHeDH;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25061606A335
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25061606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JQnQHeDH
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso18692696d6.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795213096; x=1795817896; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH8BhOkVwEDMLAd4eMuzUXkRIOCXHprCiQlbx8/819w=;
        b=JQnQHeDHMRzlwLEsWvCQf0SCJrCeUP37QaIZMVHLycFe6odFq2xnQ5Vl7+/rgt3TC1
         Bw7d8hyqt98UxMhqLjHCEWayWzkU47TYw6mMzIe7TaUVQ3GdB0OsoH0luYTV4ZKLyNlF
         cH8uFpA4n+nruOHcvIK7v5N9tHeFr4ZlbZz9JdfBN0Jb6RCqjH4akafgT6qbbAGjWksE
         461vGYDQIh2NgJR58YGFKQYzNUTysPZN9NvL0PuKBbXPAjut6Dq9d+SKwl9zfJv8o450
         pNuJwnlR0nJthz7Az+l1+zx/HfyuleNPWpb70ZU8YbAsGRWZwdhxPh0GlNorPmxCk51H
         nTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213096; x=1795817896;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QH8BhOkVwEDMLAd4eMuzUXkRIOCXHprCiQlbx8/819w=;
        b=1IJAvWHCeAl2qs+rrUi357M00QmB2WhcxuXrNbXfaJNdkn/BmE5YgxaZpH+gDt/wMk
         9JFGtG4CusMRzOCMWhy8UjvTnbmNoZoguLacEj9dxnNcn2NOaMjZjt0rutH+cXbaI6SH
         Y5MXuH5UdDR7u1yBM/1GHwn6kJ+I4jJ62WuEbnfcqSVsjlSbQqbupI3TDiQCk9v1Qs6H
         ZAHOL7Wm2+ijkQ5K2owtCP4bMmabLMz4iH66mn/cauFr7N6CQAi+n632J2lPi4s6eWdY
         pY/j4SVlqWQE3TYk0KDItZub0Oqr3k5GAq4K59V2ZCCbOXnjjwQcEXk/vebCnv4cks7W
         8J6Q==
X-Gm-Message-State: APuU4Z8tUS8zFcFR2IWmuZRrHSqPt8Y2E5M/EnmjhDklpM/1abnpMd+3
	m6jydT4LHWNBjU6OeA9R3nfhpCcPC8F7i+xdnXDldtG7i9swuvKbHFXchsoq4dUOjQ==
X-Gm-Gg: AZFdTZdNlRW7BaNZA2in2jrOQd89AEDECd9WRIsbrU8bKI/h9A1zkUA6/wCAv6+b8PT
	q0Srv77WypU4+d94L4+icYQC59G9vz02QJZaIFShZT4CA/xWyoXwXOvFag8pVddeyZ9MvXLQZgc
	l6RWrxZdQfGcErRflHl4VRuj9vaadrnv71PpxwmsQCwy3vQdyTNOQm8Hl0OM6Vtztc3KkzlI4Ot
	Dcp+eYc0wRSrJx/A+08JgiiRN7Nd/bZip2uy3WkiRKmwgXp3+YGeB0T09mdHvuH33XILfFngeM5
	aVaEPVZgXduNNbKi3Nka3Hthp1qWKDgc+IvW5L4KXtpt/b10FrkavpfDZYJ6agJ5ORQ+8l/BXBo
	VjDAs3uLM+MWjVC3TUDM/U94/ARfYY0h1snL2jecZ2jusY7x69e9G6Z+eMG/mErajFftj2ia1BT
	hM77NiVpL3ZYRjtzLKaWPitWWCX86SIcKahUH4+KnHzSzar65Iwr5AcV6ZJDgAKLpSu/kXrjB+h
	f2NtpOkeQ2W1RWJJHX/IWnRNUqYUOK+2shlj2SzjrBlEdDIYZg9hswUSC23QaPJablK/X8WLol0
	S3oYZoboZAnBXcz9X8gI19teTbWiD7VvZ3fIByKfyXOIaw6TJPfjCmbMGWgP9DUbZpy5eqYUoiG
	6mogX6bzj+zeKm3N4FBOnah7gjpl9Ow==
X-Received: by 2002:a05:6214:21ec:b0:91b:a0ab:824 with SMTP id 6a1803df08f44-92134bb7d97mr78628116d6.56.1795213095965;
        Fri, 20 Nov 2026 14:18:15 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0c33fsm36774016d6.36.2026.11.20.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:18:15 -0800 (PST)
Date: Fri, 20 Nov 2026 17:18:14 -0500
Message-ID: <481c20b898f003247763475ef417c321@paul-moore.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261120_1711/pstg-lib:20261120_1707/pstg-pwork:20261120_1711
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] lsm: don't call d_path() when current->fs is NULL
References: <20261106111016.5783-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20261106111016.5783-1-drifabdelmalekmohamedsaid@gmail.com>

On Nov  6, 2026 sashiko-bot@kernel.org wrote:
> 
> When the last reference to a file is put from exit_task_work(), the task
> has already run exit_fs(), so current->fs is NULL.
> 
> syzbot reported:
> 
> Call trace:
>  get_fs_root_rcu fs/d_path.c:244 [inline]
>  d_path+0x224/0x4dc fs/d_path.c:287
>  audit_log_d_path+0xdc/0x19c kernel/audit.c:2221
>  audit_log_lsm_data+0xe0/0x12d0 security/lsm_audit.c:199
>  dump_common_audit_data security/lsm_audit.c:421 [inline]
> ...
>  security_file_open+0xec/0x258 security/security.c:2739
>  do_dentry_open+0x2a8/0xfbc fs/open.c:973
>  vfs_open+0x44/0x2dc fs/open.c:1101
>  dentry_open+0x74/0xc0 fs/open.c:1124
> ...
>  security_file_release+0x84/0x148 security/security.c:2424
>  __fput+0x2c4/0x74c fs/file_table.c:506
>  ____fput+0x20/0x30 fs/file_table.c:541
>  task_work_run+0x1cc/0x25c kernel/task_work.c:233
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x58c/0x1a74 kernel/exit.c:986
> 
> d_path() renders a path relative to current->fs->root.  After exit_fs()
> there is no such root, and no substitute root is meaningful: the
> record's pid/comm describe a task that can no longer name the file, and
> the file may have been opened by a different task entirely.  Falling
> back to another root would produce a well-formed but misleading path,
> so report the field as path=?
> 
> Handle this in audit_log_lsm_data(), where the meaning of the field is
> known, for LSM_AUDIT_DATA_PATH (Smack file_open), LSM_AUDIT_DATA_FILE
> (SELinux file_open), LSM_AUDIT_DATA_IOCTL_OP and the AF_UNIX path in
> LSM_AUDIT_DATA_NET.
> 
> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
> ---
> v2:
>   - Replaced logging from path=(null) to path=?
>   - Added audit_log_lsm_inode helper
> v1: https://lore.kernel.org/all/20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com/
>  security/lsm_audit.c | 70 ++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)

Thanks for the second revision, one comments below ...

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 955b2e7b2c8e..d92b0823e871 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -169,6 +169,27 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>  		audit_log_format(ab, " %s=%d", name2, ntohs(port));
>  }
>  
> +static void audit_log_lsm_inode(struct audit_buffer *ab, struct inode *inode)
> +{
> +	if (!inode)
> +		return;
> +
> +	audit_log_format(ab, " dev=");
> +	audit_log_untrustedstring(ab, inode->i_sb->s_id);
> +	audit_log_format(ab, " ino=%llu", inode->i_ino);
> +}
> +
> +static void audit_log_lsm_path(struct audit_buffer *ab, struct inode *inode,
> +			       const struct path *path)
> +{
> +	if (current->fs)
> +		audit_log_d_path(ab, " path=", path);
> +	else
> +		audit_log_format(ab, " path=?");
> +
> +	audit_log_lsm_inode(ab, inode);
> +}

As I mentioned in my comments to your v1 patch, we want this function to
look something like the following:

  static void audit_log_lsm_path(ab, inode, path)
  {
    if (current->fs)
      audit_log_d_path(...);
    else if (inode)
      audit_log_lsm_inode(ab, inode)
    else
      audit_log_format(ab, " path=?");
  }

... we only want to log " path=?" if we have no other options.

--
paul-moore.com
