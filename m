Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793737101;
	b=AR0I1HkpoSzzvUevhooJBl7louj5mvhsDQuSSYVYZfHxkNstN5WavaHdSPaq2c71c42k
	 3mnFLhDowCTC+v3RnzjTkl33d4nIGrqehUzc8f150b9c5Ji3wzDKtgkWCxYUOfkN94fT9
	 nLJD8elaMZrurZUoYi6BymH3q1pp2I18W81RQH5lXp5RqCGBzlXUe15pdkL7nTjxzLKch
	 eG+i/dIkOomcPN+muvUrwuc/+U1oVuzOgupJ/tSvhQuaB9Ys8vgSF2vF1mND8SL1rEZrt
	 NZMWN0fOioVGkmdEM8myUjQT1exqDZvowlKf7JziqVGyfls+tWGbYYUD6N3BAiitb6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kkHd2eqDN6g9r6mKgVJdjw4ebv001gReOK3lLkRcsJQ=;
	b=2bIngsp6S6twb4fWYX/gZLVi5Aa/eTMMDGb6js7XyPXSm4D8Jdsxw+V/8JXVyanOaErS
	 oScnNQysImaM3crf0bGw9tSHf1SOe543rKsYeY4shERmyL3CFbb8MVZZ22h1xBcRZ7Mwg
	 EEsDbrtzFUPJ1F2+gO0vE7um23pvLmQZGoXP6sOBY+3rUwOd9AJbZKppw/1pnFBhL2jVy
	 7zWatznjb1yUP1Z7hWLyNCFujqkUtjMKgW+fbC95vp/WSyEo4/XSem3gxKnIm+8kgPM8F
	 aolD4OF3QUvK73GgGWuCNANRkyKC8k4F8f4SgaeIKBlUb06GhCBIaq8CKHTmBMoWT7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYQEHHEz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89A606A31B
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 20:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA89A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYQEHHEz
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c40e30c26a4so210266366b.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 12:18:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793737098; cv=none;
        d=google.com; s=arc-20260327;
        b=EOYk5CEPOcOVALJ3k5LLio97eHvPlJ5UT3282ISE6YEI4q0Pc5YHi+QobVGFMSxGV5
         lpEA1SVqtfdiGDCvBXBdozUjWuvx46gBWxz3jDcUwjWgeST5dS5GPif2Gryzymeb0kxc
         djL5iMGCeFrIUSufyt8MMYctUcO6dXmmYCPQ7xtlxAYv7dhYhsXzFCD0d1DvuhOnHf+l
         3gjZ5HINaHKZbbgUbcukP37Dhle8BriRvT4uOHtyQ7Wz5rFbXtD4lY9QQoDHFLTrgytV
         MJl97HYRxjY9DkRqHoc5Y+j3UqZH9B48nSUq7B+0mgp+gFhWn7ETPonfL84IPYouGQI1
         mSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kkHd2eqDN6g9r6mKgVJdjw4ebv001gReOK3lLkRcsJQ=;
        fh=ezEZLXBdfvmfDLU2eH65X5wUqFIcKLS+QrS5vz2oDic=;
        b=rS/OL4+7fB49ajJ1U5niXznZ8oyS88uL0obIppQJ58oI1MZxaJc7bD4St/YYeWka/B
         eiqemfbo+amPPYjmdw2ChOjty8IZVKnyuPgUJ8Afjx/EF5i6X2R5xLKrWPY1HTO+2BCv
         RTJNUz1NS4NINuJXinuYCzRbHPAckhxGhjpeUe+Af+96G/p16eY1ICtPs9LP9Hpy81ru
         04vQQdB90azCMENpdUsGEVwEdKmyv9U67YFcJtVw+INcZtluHqpUb20BmHj+jfCOjgws
         93ESt1ksoj3jQv+FuE/pASD4iYBRdagkVUOWQzX3wUU93IbTuBFHXIVTbBmZbEekPzrS
         cvCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737098; x=1794341898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kkHd2eqDN6g9r6mKgVJdjw4ebv001gReOK3lLkRcsJQ=;
        b=jYQEHHEzPR85viHaxy80rXbEWVIbdt6b6puPPSPn9+EE6hdtzc2GP3uStvSQQmutfC
         DnDgl5eAG24ujCmOF1JgLe9UISXq02MxzYI+CgLdKk3GMoVItIuRjAmGYWnk8P6Lloww
         DX0AExm7aLuzW5KejMRQT46i9AGhNXUOd+2ayq4gnCXa041aSm/9O4v/O/2ZE4j3iNc9
         x/lxuw8hfO18qqSWap1jYCt5ietKXgrpWh4g+qUvCz8Wvcn/v5T224jbfxwTiGv1+BpI
         wMN+4wNtJIeZhgLtt9Xf8HiwF8k575xamYW0P5xlkDVyZOjESzrinoHDpixFVr2iRvrq
         +uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737098; x=1794341898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkHd2eqDN6g9r6mKgVJdjw4ebv001gReOK3lLkRcsJQ=;
        b=PGSnsBw932/S3MY8v3gb/vm2fB18zQsxFde9S3fB9jXMS2osmuPkunrsDwRv4xgcO6
         uYqGca7jgE75H9qWhQ2qpZBXzkZMFnKzQDbpSGyTf7sQnedluIkKrmFUBIeI474FX+LR
         kAvcvRL8VfzV9bFRMg4XjtOyup+K3mCgarqy/NpIjw6wC9h/d2aGGFmkEfXnAn5bgxKR
         3YOOK42OgUnm1o7fLvkGCO3nvZjJxaawdV+ujzeMppB5QqXhc3RlI0wsVh9LMQiRL4Up
         yFpQ7L0rFSqQQX9QDi04yzbHeJ6jJxXyA5axd1QRwcOBAqrnDXUWhZeOzNOQSeHgjyXD
         kmdw==
X-Forwarded-Encrypted: i=1; AKwUvByQDKYGNsN5SlwXO8WEG06ElXb1dDMwcysJD1DmfxC7yK9uAAedLlm6hQqxtgke9gWHWVmBj0pKT6ZTCGMBtPRr/bEf01M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Rkmz6JAz3tbqIkXVECoJZZi3nSb37UVbeVBdiurh89TyVW92o
	SAU9lrqhfzxJ7eZKOpYHtScM0gCKVLuJEUfhYwd77MpFrhjcbtZW1lqC3LZhT95FEsz5SmZ63Lx
	2Si/oNd6GTBDL4ABAlQq62a0N5+5puf4=
X-Gm-Gg: AYBFou198SYI6B9Qhwwpauv94sqCr4hCECnFYUkQgwG2lDMWQ0KLI/G+cTsRhFbS6KN
	8w5H65q2NtkYU9pRhjp8rsFYMMX1+C3rVQnbZvAAzShugDWaIn1NgwTLwn3dBxk5GG4JW9u1AxQ
	Vli4KsaWKO3itex3NLlaBCKRrpcepgt+83QuSomQol6imMpcjTmyoezQT1z42JvoI1/mSzVkpWe
	JkxwffYZJr3awQuEthS+xIyxK/+673CIEm5mQlF8j5mS7SXwCThxur1hy3DiJmR6UTKeHreHu49
	jdeXJm9il0WWVhjAZqpXBM/gYci0PsBKpDkydpG4hCTt5q4e0pM2rD0C4DGQqpJ7khvvIBdN5vp
	tEQMGfhJ6Wo5fvT8KUhO4MCwNHK3dFStDEglD
X-Received: by 2002:a17:907:7f9e:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c49d1285bb1mr1572706066b.6.1793737097942; Tue, 03 Nov 2026
 12:18:17 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com>
In-Reply-To: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Tue, 3 Nov 2026 21:18:06 +0100
X-Gm-Features: AclHuK-B3KHOmhLm8nxGZsAI0SElT7ZlUOKjLlskY-PolsjxdKCIQLffMl5plIQ
Message-ID: <CA+xk8n--qQfYro+xsGu+z7nuCrAJgwzOOyrc+iXuBeSsPOWjhw@mail.gmail.com>
Subject: Re: [PATCH] lsm: don't call d_path() when current->fs is NULL
To: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: jack@suse.cz, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com, neganhat@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Just following up on this patch to see if anyone has had a chance to
review it or if any changes are needed since we're at 7.4-rc1.
Thanks,
Drif Abdelmalek Mohamed Said

On Mon, Oct 19, 2026 at 11:29=E2=80=AFPM Drif Abdelmalek Mohamed Said
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> When the last reference to a file is put from exit_task_work(), the task
> has already run exit_fs(), so current->fs is NULL.
>
> syzbot reported:
>
> Unable to handle kernel paging request at virtual address dfff80000000000=
2
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
>  dump_common_audit_data security/lsm_audit.c:421 [inline]
>  common_lsm_audit+0x1d0/0x290 security/lsm_audit.c:451
>  smack_log+0x1f4/0x264 security/smack/smack_access.c:400
>  smk_tskacc+0x210/0x2ac security/smack/smack_access.c:255
>  smack_file_open+0x1d0/0x230 security/smack/smack_lsm.c:2078
>  security_file_open+0xec/0x258 security/security.c:2739
>  do_dentry_open+0x2a8/0xfbc fs/open.c:973
>  vfs_open+0x44/0x2dc fs/open.c:1101
>  dentry_open+0x74/0xc0 fs/open.c:1124
>  ima_calc_file_hash+0x120/0x5cc security/integrity/ima/ima_crypto.c:269
>  ima_collect_measurement+0x420/0x874 security/integrity/ima/ima_api.c:300
>  ima_update_xattr+0x160/0x230 security/integrity/ima/ima_appraise.c:617
>  ima_check_last_writer security/integrity/ima/ima_main.c:227 [inline]
>  ima_file_free+0x40c/0x528 security/integrity/ima/ima_main.c:251
>  security_file_release+0x84/0x148 security/security.c:2424
>  __fput+0x2c4/0x74c fs/file_table.c:506
>  ____fput+0x20/0x30 fs/file_table.c:541
>  task_work_run+0x1cc/0x25c kernel/task_work.c:233
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x58c/0x1a74 kernel/exit.c:986
>  do_group_exit+0x198/0x238 kernel/exit.c:1129
>  __do_sys_exit_group kernel/exit.c:1140 [inline]
>  __se_sys_exit_group kernel/exit.c:1138 [inline]
>  pid_child_should_wake+0x0/0x104 kernel/exit.c:1138
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
>  do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
>  el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:796
>  el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:815
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
>
> d_path() renders a path relative to current->fs->root.  After exit_fs()
> there is no such root, and no substitute root is meaningful: the
> record's pid/comm describe a task that can no longer name the file, and
> the file may have been opened by a different task entirely.  Falling
> back to another root would produce a well-formed but misleading path,
> so report the field as unknown instead, as exe=3D(null) and name=3D(null)
> already do.
>
> Handle this in audit_log_lsm_data(), where the meaning of the field is
> known, for LSM_AUDIT_DATA_PATH (Smack file_open), LSM_AUDIT_DATA_FILE
> (SELinux file_open), LSM_AUDIT_DATA_IOCTL_OP and the AF_UNIX path in
> LSM_AUDIT_DATA_NET.
>
> Alternative: omit " path=3D" as it is done for inode in audit_log_lsm_dat=
a.
>
> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D975ace299d6ba2eb1cea
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>
> ---
>  security/lsm_audit.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 955b2e7b2c8e..5ed505d781bb 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -169,6 +169,15 @@ static inline void print_ipv4_addr(struct audit_buff=
er *ab, __be32 addr,
>                 audit_log_format(ab, " %s=3D%d", name2, ntohs(port));
>  }
>
> +static inline void audit_log_lsm_path(struct audit_buffer *ab,
> +                                                                       c=
onst struct path *path)
> +{
> +       if (current->fs)
> +               audit_log_d_path(ab, " path=3D", path);
> +       else
> +               audit_log_format(ab, " path=3D(null)");
> +}
> +
>  /**
>   * audit_log_lsm_data - helper to log common LSM audit data
>   * @ab : the audit buffer
> @@ -196,7 +205,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>         case LSM_AUDIT_DATA_PATH: {
>                 struct inode *inode;
>
> -               audit_log_d_path(ab, " path=3D", &a->u.path);
> +               audit_log_lsm_path(ab, &a->u.path);
>
>                 inode =3D d_backing_inode(a->u.path.dentry);
>                 if (inode) {
> @@ -209,7 +218,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>         case LSM_AUDIT_DATA_FILE: {
>                 struct inode *inode;
>
> -               audit_log_d_path(ab, " path=3D", &a->u.file->f_path);
> +               audit_log_lsm_path(ab, &a->u.file->f_path);
>
>                 inode =3D file_inode(a->u.file);
>                 if (inode) {
> @@ -222,7 +231,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>         case LSM_AUDIT_DATA_IOCTL_OP: {
>                 struct inode *inode;
>
> -               audit_log_d_path(ab, " path=3D", &a->u.op->path);
> +               audit_log_lsm_path(ab, &a->u.op->path);
>
>                 inode =3D a->u.op->path.dentry->d_inode;
>                 if (inode) {
> @@ -321,7 +330,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>                                 if (!addr)
>                                         break;
>                                 if (u->path.dentry) {
> -                                       audit_log_d_path(ab, " path=3D", =
&u->path);
> +                                       audit_log_lsm_path(ab, &u->path);
>                                         break;
>                                 }
>                                 len =3D addr->len-sizeof(short);
> --
> 2.43.0
>
