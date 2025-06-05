Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3D276051
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147871; cv=none; b=U4AAa6D9OBEs7ih8BYyqqYWgAOvFew5KmZcKasdvixWYbvOhClAwudXVTKrNbyhTp5pqtTqnOveJA3bcEG2E4rNH+1P0I28rtmR4m+9FtBte81pa2hsk8dRelr1LkrsBIviWT+IoSwPBVjxnRP2JBoCeCK6h0z/BaUhC3h2NNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147871; c=relaxed/simple;
	bh=tGKIDGZtqQueasd3JtRGIJZMx5ylZw1zITKz99GjUn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsII6E6oUflvzFC1stMFtbuLAiCyypdd1B3eaYT3lnpxb1g9y3JmlZoXIei8hchgii/JzY1hJz4XqKxr0Wk2eO0zHCag1hwCVHfecLikQa14Ks+K6GpmCULEJXIFGcCprVmQ5ogsbPer9a9hsikPLrwJCHCJd8M/st4ZTd0T7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U2KQRF9g; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U2KQRF9g"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70df67e1b17so13047607b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Jun 2025 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749147869; x=1749752669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loafhdCi9dc6Ve3gPnUX+aj3YHhuwxH1+gMF2DvUoxU=;
        b=U2KQRF9gMVWpoiDT+DpknCR4fAngrfwzYAU10s8OXIJ10Nvu2yyS/0lOfm63hfEre0
         GWe25EIo+Qn/LRHB5MpXAXmy7BImT394yzujhQk+2EpNC3tnOaY9h3XlkFd/zwJa3WJ/
         snSTTq6kS9RAGYK0+ZByv4GDlwdvqaJjreRowTJaZarRKllMYY9Xh0PdOv3OiaSUR03A
         F9JUrXfu1YLjn6e5sjBFJWQl3FGh15KIgQVCRaN1nAuIiak103wqNrqz+qNk6/QBK+uK
         Y8T/DLEHqxuDHd48q8UVPF1p6kgB1BUe5hgJXAhDvfDTKp0nCsuZ6A3X3eRheCz9X7LN
         XIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147869; x=1749752669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loafhdCi9dc6Ve3gPnUX+aj3YHhuwxH1+gMF2DvUoxU=;
        b=jkf37RVqX8+sETv3Hzbe5FHtmNTtYTsI8ivLo2a/WBqzfRWlaUQT5UZKmwj888PEF7
         +G5goLd1twFek1DFRwXknIINjBnhn26wSZarmBqUD+IjAUHr4v3FRX5PCeG8G7/1oQue
         kMEuLrepnL4LZbRTInaFftW/3GO7zBpZPLj6T0JyGUVDZUzw3Jn+nRsbwFADq/T76vrS
         oYoH8YJD5gH3AuYjqiyu/SbCg643PmpSk+Iqfo4SHq7VODDTQliywX09BRhBulaU49IC
         RX/QfrGQcv4c9E04ygZV45zs6R6+j6rqTYtlymMR6sR5fcqydMLpqBT0BkPtHPVJOtHN
         9ZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5R17FkwYyuSV9QyHm11xfC53PRLEX+BaYRj24/0ni3ZtuvCrYr2ahE+N76fFwOT2GRGhTB9VXLTl8RQxCDgCoVTSjfks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXA1IJrcnlezSqHdABSs4HBmxPPoZ5+PO6SlqNOzfyNYXPjp8
	O3LiHqRzEL8n2klMEVMWA6YmNHgcRCBqBnL7/PfXzNGuZGmNsqbbK8wbN/ClJi2wPv1QonEh0nd
	m7wNSKaQM1VaNZrvO77zTTdHbWpne+wPFK/pxK80r
X-Gm-Gg: ASbGncu9YpLJ2M7VcJWpHrjVFQSpVNGBd3mkJIQ46O05EP/LUdg1JrbHBERmmQ3trhi
	XoRdkx2y2NTU6XJ9Q7O3oCDHNrLiHNwJMnsoD5JeL2HH0M/QXPxllOm2EeHW/P7Jgl4/ty2xY6q
	0j+kXftosx37O9NsOIPKXZKQa4BVkz5ZWkeT0zgtSEvgk=
X-Google-Smtp-Source: AGHT+IGxHcLyr5CUfj8Adk1qnJ7rv9uM6qFjbiSCZGbhPb0Z0+PCihp8dprkPhkh0xIW808Di0xugMW90I47iMKtMCg=
X-Received: by 2002:a05:690c:6405:b0:70e:18c0:daba with SMTP id
 00721157ae682-710f7702170mr6558677b3.25.1749147869072; Thu, 05 Jun 2025
 11:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com> <CAEjxPJ5CSUEsXGT5e9KKXvdWpetm=v8iWc9jKvUMFub30w9KqA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5CSUEsXGT5e9KKXvdWpetm=v8iWc9jKvUMFub30w9KqA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Jun 2025 14:24:18 -0400
X-Gm-Features: AX0GCFsZ19Ez_LuqMFg5B8ZMjt620X-7zdb1BXMpiC6FnE_cwm04AN2nSkRV4iM
Message-ID: <CAHC9VhQ=oDeMnzrp5oERzKi8Q_o70bfTqO=LA4nuv_UV+5ApoQ@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 2:09=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Apr 29, 2025 at 7:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Update the security_inode_listsecurity() interface to allow
> > > use of the xattr_list_one() helper and update the hook
> > > implementations.
> > >
> > > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.s=
malley.work@gmail.com/
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > This patch is relative to the one linked above, which in theory is on
> > > vfs.fixes but doesn't appear to have been pushed when I looked.
> > >
> > >  fs/nfs/nfs4proc.c             | 10 ++++++----
> > >  fs/xattr.c                    | 19 +++++++------------
> > >  include/linux/lsm_hook_defs.h |  4 ++--
> > >  include/linux/security.h      |  5 +++--
> > >  net/socket.c                  | 17 +++++++----------
> > >  security/security.c           | 16 ++++++++--------
> > >  security/selinux/hooks.c      | 10 +++-------
> > >  security/smack/smack_lsm.c    | 13 ++++---------
> > >  8 files changed, 40 insertions(+), 54 deletions(-)
> >
> > Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> > folks I can pull this into the LSM tree.
>
> Note that this will need to have a conflict resolved with:
> https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.wor=
k@gmail.com/
>
> Fortunately it should be straightforward - just delete the line added
> by that patch since this patch fixes the security_inode_listsecurity()
> hook interface to return 0 or -errno itself.

Yep, I'm pretty much just waiting on -rc1 right now.

--=20
paul-moore.com
