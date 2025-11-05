Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC90344026
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372272; cv=none; b=phKk91uqFTBDlggkSiDbhyFsbVDHHV3ya2rtJ93ZQYkxfT4kzrMbWDoRzPK+LIXUnf7Q0OvycFbAnhTAFsL84Y9yeEIeX7G+2frIj4kli9GIv+6h/NsIJE3N50BkRnu8rGub7XpE4VYJOngkmQ1rViSvYHGEQG0VQO22jFCA86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372272; c=relaxed/simple;
	bh=Pk0Npog8sZ0LZeV37QkwTxusJxsZmgGiGMBvOdfNujQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmiV8wvCsfhgb0Xd5Sh8b2poBdHVP/7Ks7r2QMpTxswsVpUhv+SHsWA88vsCfhpt997mAmdsvf+l6m+yN+KBHs6rAu2q/51XnscwEJ9VmZyfoXZBr1TZBZQhxOqRIHmOyytjkIlpMzs7LZ6jnw8X12Rv9IrirSzAXnAm7/Yiuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leotC6aN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leotC6aN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so246463a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Nov 2025 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372269; x=1762977069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+1+3F9krAd0V9GErIF2j9xx69fWENxgr7H3lgTY8x0=;
        b=leotC6aN6vEloWA7tmbborXez8PnXDaxka3MR1SfiqyvPp+h5RfFY/zfXVq4Sv+3tS
         d5XGKRJ0uVv22z7cRryqGsIxwmel/fscwVPvTpybXOTzCtfYbWZSMidCW+osHutl7Zq1
         IkVFcQXaG1WRp6WRze0v7xLlDCUNHFJPKgUidX/h3wU1PsoZKHS7v8JhcUZ52iRhqHjx
         mGAZbRa+59ULkFyMdRoFOt6Q/689U7+Nm9gGY3X7z03eFpmpsJlx5TwU6jALel+HZh2O
         YnlpUACAoyqNCw1TZastfEdE/Ezh9kaEtGp6zoE6lo6UYL0X3qH8B438orRkHnZydymD
         cYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372269; x=1762977069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+1+3F9krAd0V9GErIF2j9xx69fWENxgr7H3lgTY8x0=;
        b=HQc2O86DqyzIS2aeJL2jmg1b7dv393Y6y1sFg+YIC/P9uJ46fYHNQpjEPu5flUnCVO
         hA/FrMeei2PQ/q4o1h1ctulEJEhD4htJLIeKJ0XWKNclb7/8qzSizGdn6SRMC9TAJ9Ln
         ySG03liP8px4JX0CalC1oWFWn0MllTiqCzoY8oiJMigBIbA5kY5DOFPlyFfwQENE/qev
         jpOZTcPxeyzSyD1xgY7PlpK1pITFzGbVq8zddkuQF/TX3P5jFYisFMvsARjvt+ye9Spe
         NnP+lUUeBpyOcgC2OiILKexsI3TwG5lFo3L8SPBSxgnhsbGRszm/aq8QpguKdlL9f++0
         fgsA==
X-Forwarded-Encrypted: i=1; AJvYcCV+5SZVR42SiIyzr9CASWp8DgEgfs3p14miMsa9Qp+U4vUM7zmCIHWPHuHDKnXUuodH1UC+lfP2DL4C8qhH3Y8gAz+NIH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+wJ6dQBC/aB2gJUm92AMb0unI9Z1Ad1UArh0IjjdMV34EF/D
	OMQKAiQ/GQcl4lZo47rmc1+mDLRjj600j1HTVZhe4rZFBfizAVdy7PC780PWx7RbdDgXdETojFJ
	75A21nZTWsJr6pnGHuLFFX8P9IeiblG8=
X-Gm-Gg: ASbGncvjQxCcqVFNDJ6whwq4IwJvw31g42/Nmw32Fab1LSDxZU8s8r2oU4ICRpNO17N
	K/PWNDhuE50pYm/OBr6pMevn+oM4KWhVoSPcq7m8AIPWjAgmmhKsYul4nbDl7Wjo6rSNLDKDnpS
	CyNDkd8007+C7zhu/Fw0eanPyLDthuyQczV0Top4u76YtKid+aveBGu6bKV4p3Px1TtpJN6Tgtz
	tHxtZH1nMUDlDlX0Su0eNphOc22Cxhi19owiU9DUpo3AxX8IbK56rgE0Ql3b6xs9xrKXuV5Dgnp
	gGy8kB/p0EX+Kio=
X-Google-Smtp-Source: AGHT+IGw6uruJ9ZEI48AgrBdkQ6+Y4KI/t3qaGHgTl6iUqNZaRX9HqUFuxhME6r39mMz7B0UJDlRLhanlWqFyjj6ElI=
X-Received: by 2002:a05:6402:4007:b0:640:f041:c7c6 with SMTP id
 4fb4d7f45d1cf-64105a3ea6emr4012523a12.21.1762372264805; Wed, 05 Nov 2025
 11:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105193800.2340868-1-mic@digikod.net>
In-Reply-To: <20251105193800.2340868-1-mic@digikod.net>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Nov 2025 20:50:52 +0100
X-Gm-Features: AWmQ_bmf-MJjucXoTdZsQJpswia7qMghXA6jxfB57WcztYQemJGt9Ps6MJInHsU
Message-ID: <CAGudoHEvnTCxK-c9yistxN5ZjFjh5x3REoW4XxmiRAXNEDeyPQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Move might_sleep() annotation to iput_final()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Edward Adam Davis <eadavis@qq.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Tingmao Wang <m@maowtm.org>, 
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:38=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> iput() don't directly call any sleepable code but mostly checks flags
> and decrement a reference counter before calling iput_final() and then
> evict().
>
> Some code might call iput() with guarantees that iput_final() will not
> be called.  This is the case for Landlock's hook_sb_delete() where the
> inode counter must de decremented while holding it with another
> reference, see comment above the first iput() call.
>
> Move the new might_sleep() call from iput() to iput_final().  The
> alternative would be to manually decrement the counter without calling
> iput(), but it doesn't seem right.
>

This would mostly defeat the point of the original change.

Instead, if you have a consumer which *guarantees* this is not the
last reference, the vfs layer can provide a helper which acts
accordingly.

Something like this (untested):
diff --git a/fs/inode.c b/fs/inode.c
index 84f539497857..a3ece9b4b6ef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2011,6 +2011,15 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);

+void iput_not_last(struct inode *inode)
+{
+       VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR, inode);
+       VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
+
+       WARN_ON(atomic_sub_return(1, &inode->i_count) =3D=3D 0);
+}
+EXPORT_SYMBOL(iput_not_last);
+
 #ifdef CONFIG_BLOCK
 /**
  *     bmap    - find a block number in a file
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 41c855ef0594..8181a0d0e2ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2909,6 +2909,7 @@ extern int current_umask(void);

 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+void iput_not_last(struct inode *);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
