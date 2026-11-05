Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899046;
	b=Q6m4pSYzmBglLF/YGGhag4jCb9L1Gg5wbhSuxDV1Plv6xqDutzDlDk1peHC/9WwErM3x
	 QAcLaHE+GvKOg5idTPgGqd3W2I2m0lRZ0KiY7Q/8vGI2Q//MwvGZO0EGs5TPBxIhlk6lz
	 7FKPp8WnoCiWSCpvaW55rS4f3pONG35FnQ5WziAiVwdwpJUJiZOAp1A1764KgacBxA3/9
	 yeHNbO+Kmtc83e4r53pd/OKM9zBr1F6jn/GY6RT35y8F65I8YV/FmXj3ZtUj1bmvHVCdt
	 A6RizaQ6vViImXcdcB8zr9IhqFQrO8eu4t1yUiYlZ6YnPrr58VM7KwcPoYgyR/Egpzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=79WDsZ8DQ80lT6IYR2/z2VckZPQOpk+kKeChRc/2aFw=;
	b=pP5MWmMiQggfPv19QpNJ4uQ/acUu3pTn4XjYLRLPpRRGqCNzthyWaazDn2Rx0ekbv8Hq
	 2SadrpAJY60dLfZwINPb+k+x/v/KeM9HsW/HGBx0XMI/OniQ9891bY3brocp1pTj1Fdr7
	 ldLGmPcAz6Wt2ZU3CMiTAhRBf6uNoEGKCxcUIa6F5gYyjGYCmLQwNr76IvJho9+Q9wE+p
	 0skq32+mFBwb3+W0eEpWcrF9DERXDkAwnWp1Z/EPUJPuwYlSj8j8wC4yC+4yJZNpDQ44U
	 wGOvZrJqYNKazZKssbTa1onfgf/glwHAsmZYa+EuPNgu8czuUzBLkA4uUG4Mv3PCo7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cLPc9x7j;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEA606D834
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 17:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAEEA606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cLPc9x7j
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-54d9ac78f2eso4026381cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 09:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793899044; x=1794503844; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79WDsZ8DQ80lT6IYR2/z2VckZPQOpk+kKeChRc/2aFw=;
        b=cLPc9x7jvBRPKGLaUOu54UMqiR1ObkA6UL9OCrhbqPX9g4NmKg/zblt9Wsv9fEA/8N
         bfhofYJpryCIY8PCsp0m9JmH3QBk2vVN3cuBJfzM1rw7DTTyuprQNKtdypqrmOJlfUuo
         tTxnbe7q4HfGNoaaJUKE2t0TJyS3vm2B+JEug42oBGHAwke7ltFDtwph2YYA+wqYqTLv
         RyZNPa/8f3D8FxHj4aqtvHjuSTK77Tf238oy2OeHYo1K9lOLPPri7exnGLz2MjMz4sXQ
         MU/q0kvcG8RzRq2nscsORKyWp8arN8J+MGu74tarc0lrpMVh8MCdGor29qt5yiNqzQba
         dnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899044; x=1794503844;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79WDsZ8DQ80lT6IYR2/z2VckZPQOpk+kKeChRc/2aFw=;
        b=RpdLxWKsGNkaWDM7Vvh8zYAzsel2qnFkZIkNEsGAA6LEC0pzBDWZ946gQf1B361zQh
         wa/KuRXBcQrOQ5XyecuhVy0MTjkie3Xdo2kJPdTDUIki5otfUj64UcR1VBL1kzIc8pgV
         cK3eFCoqp9Ns6LqeVp7ktWX7aqb1w1hlPq+a1T4NY2vBBBI8Y6ID7Q8y1EXiv2v7BihN
         7httoK1OlYDr7l65H6yBSqd7kIY/lbcgIz1i3JI1aulYR9czTm5XPbZOC08mUNWj2baq
         n+yAE3FzRlN26pKHQ50NJVDfgnlCqQNv7nzKtzS7EYdqfhcdrrth4E6K5EI+OIroX1uZ
         oVcg==
X-Forwarded-Encrypted: i=1; AKwUvBw3gIVbo4zgG6iP0YI9G6Fu0N+Vm+sU5X+nNxXGgWLGj4pA2BWFsF4urfd/aBpgNUuCbjdOdQITWJdz54DQopm4ig8fbxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ucY3UmerHR49kKsV7OfZK1hvMPY35bTi/7et1avfk94rADNM2
	lJbaJXogS7C7JJEXcDgmhfwl88ZtiQGtIb0nPPTpAGV9PghCbKtbPsTQ/rKOTWoDPg==
X-Gm-Gg: AYBFou2hxSof9DYWxecGr59JxCSuxRvzUFQz51U2mrYoA1zR1K7pd5AE8r8YJNdkOIk
	zSxEoYtYrgE8Qk71DO2BE/XpllZo+yaFMH2YWpW2jws9jzNy5MfzSkkR21/YdxuGnFqY2atu3VV
	l5Ow9dDOLStWJhVxafbXDsUZu+0FPTxqADtTaOhnLHWMRl4NSN7eqM0njKC4KuZW26BHOBKlOr8
	5ApeS7i4DZxMtAP911WLyKh+Ad92cUHS7lEZZSO40z7vViQcrh7w8Q37RtR0vK5VhH0bKKxAEhu
	+7m9dW/cUnO2k0XWSMrrnJ4dfpDecgsU3i+IdvijLcdn2oPzu0MhRrfHQAz7poz7R+SXoesCPkG
	ZtD2bVSnxL0p9694NR4gM4iTFjowsWCgoNHrIBZJM7U0vgpeJL/FM+1A/uad1Ts459K6A7e/2I0
	4YP2k/yyyJjJfV/wy9DG1zRFSd79mfdTlPt6QiblFNqRRz4479F8a3pNBUD+Nj+ItyOGI71x9i6
	mehYv5vnDZvZH31oDx+AbpsjehZz9RoojGcHYwC+owbOAVmN4+fupw6d1EzzI3l+ZIZRaisYTrX
	7HOHVkutBnQWIxIaZPaCwfUg75Gx4Qd/DEUiE0nr3WsUGWMOvtdEgiW1Wksc1lTGcVUb2JIBfZ3
	FiK6miUc2D5Dy7c7JI7CLb9XeEV9MJA==
X-Received: by 2002:a05:622a:4896:b0:536:70cf:a87 with SMTP id d75a77b69052e-54e0feec2f3mr3881cf.2.1793899043450;
        Thu, 05 Nov 2026 09:17:23 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b0d171102sm56001281cf.1.2026.11.05.09.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:17:22 -0800 (PST)
Date: Thu, 05 Nov 2026 12:17:21 -0500
Message-ID: <22ec774debd36b4f8edd85395349602d@paul-moore.com>
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
X-Mailer: pstg-pwork:20261105_1157/pstg-lib:20261104_2058/pstg-pwork:20261105_1157
From: Paul Moore <paul@paul-moore.com>
To: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>, jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: jack@suse.cz, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com, neganhat@gmail.com
Subject: Re: [PATCH] lsm: don't call d_path() when current->fs is NULL
References: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com>

On Oct 19, 2026 DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com> wrote:
> 
> When the last reference to a file is put from exit_task_work(), the task
> has already run exit_fs(), so current->fs is NULL.
> 
> syzbot reported:
> 
> Unable to handle kernel paging request at virtual address dfff800000000002
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> 
> Call trace:
>  kasan_mem_to_shadow include/linux/kasan.h:65 [inline] (P)
>  kasan_byte_accessible+0xc/0x1c mm/kasan/generic.c:210 (P)
>  kasan_check_byte include/linux/kasan.h:402 [inline]
>  lock_acquire+0xa4/0x320 kernel/locking/lockdep.c:5916
>  seqcount_lockdep_reader_access include/linux/seqlock.h:73 [inline]
>  read_seqbegin+0x6c/0x144 include/linux/seqlock.h:838
>  get_fs_root_rcu fs/d_path.c:244 [inline]
>  d_path+0x224/0x4dc fs/d_path.c:287
>  audit_log_d_path+0xdc/0x19c kernel/audit.c:2221
>  audit_log_lsm_data+0xe0/0x12d0 security/lsm_audit.c:199

...

> d_path() renders a path relative to current->fs->root.  After exit_fs()
> there is no such root, and no substitute root is meaningful: the
> record's pid/comm describe a task that can no longer name the file, and
> the file may have been opened by a different task entirely.  Falling
> back to another root would produce a well-formed but misleading path,
> so report the field as unknown instead, as exe=(null) and name=(null)
> already do.
> 
> Handle this in audit_log_lsm_data(), where the meaning of the field is
> known, for LSM_AUDIT_DATA_PATH (Smack file_open), LSM_AUDIT_DATA_FILE
> (SELinux file_open), LSM_AUDIT_DATA_IOCTL_OP and the AF_UNIX path in
> LSM_AUDIT_DATA_NET.
> 
> Alternative: omit " path=" as it is done for inode in audit_log_lsm_data.

Once again, thanks for reporting this and providing a fix!

More on this below, but I think the idea that in the !current->fs case we
can follow the LSM_AUDIT_DATA_INODE example and log something useful, at
least more useful than "path=(null)" is a good one.

> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
> ---
>  security/lsm_audit.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 955b2e7b2c8e..5ed505d781bb 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -169,6 +169,15 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>  		audit_log_format(ab, " %s=%d", name2, ntohs(port));
>  }
>  
> +static inline void audit_log_lsm_path(struct audit_buffer *ab,
> +									const struct path *path)

The horizontal spacing above looks ... odd.  Can you please fix this so
follows the established kernel style by aligning it with the parameter
list in the line above?

> +{
> +	if (current->fs)
> +		audit_log_d_path(ab, " path=", path);
> +	else
> +		audit_log_format(ab, " path=(null)");

What if we were to extract the LSM_AUDIT_DATA_INODE logging into a
helper function, similar to what you've done here, and call it when
current->fs is NULL?  What do you think?

I would also suggest we use "path=?" in the case when we can't resolve
the path or do any other meaningful logging; this is more consistent
with existing audit approaches than "path=(null)".

  static void audit_log_lsm_inode(ab, inode)
  {
    ...
  }

  static void audit_log_lsm_path(ab, inode, path)
  {
    if (current->fs)
      audit_log_d_path(...);
    else if (inode)
      audit_log_lsm_inode(ab, inode)
    else
      audit_log_format(ab, " path=?");
  }

> +}
> +
>  /**
>   * audit_log_lsm_data - helper to log common LSM audit data
>   * @ab : the audit buffer
> @@ -196,7 +205,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  	case LSM_AUDIT_DATA_PATH: {
>  		struct inode *inode;
>  
> -		audit_log_d_path(ab, " path=", &a->u.path);
> +		audit_log_lsm_path(ab, &a->u.path);
>  
>  		inode = d_backing_inode(a->u.path.dentry);

We would need to move the call down to here, but that should be okay:

  audit_log_lsm_path(ab, inode, &a->u.path);

>  		if (inode) {
> @@ -209,7 +218,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  	case LSM_AUDIT_DATA_FILE: {
>  		struct inode *inode;
>  
> -		audit_log_d_path(ab, " path=", &a->u.file->f_path);
> +		audit_log_lsm_path(ab, &a->u.file->f_path);
>  
>  		inode = file_inode(a->u.file);

Similar to the above:

  audit_log_lsm_path(ab, inode, &a->u.file->f_path);

>  		if (inode) {
> @@ -222,7 +231,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  	case LSM_AUDIT_DATA_IOCTL_OP: {
>  		struct inode *inode;
>  
> -		audit_log_d_path(ab, " path=", &a->u.op->path);
> +		audit_log_lsm_path(ab, &a->u.op->path);
>  
>  		inode = a->u.op->path.dentry->d_inode;

... and here:

  audit_log_lsm_path(ab, inode, &a->u.op->path);

>  		if (inode) {
> @@ -321,7 +330,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  				if (!addr)
>  					break;
>  				if (u->path.dentry) {
> -					audit_log_d_path(ab, " path=", &u->path);
> +					audit_log_lsm_path(ab, &u->path);

It's probably not very useful to have the inode info for a AF_UNIX
socket, so we can probably just do this:

  audit_log_lsm_path(ab, NULL, &u->path);

>  					break;
>  				}
>  				len = addr->len-sizeof(short);
> -- 
> 2.43.0

--
paul-moore.com
