Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005E19CC02
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323011; cv=none; b=mue9TVjCqWbmk3V1Qtd3er7i8gGRon7rURSaYfEubFHghMmYjzJd0GmtlGxx4jMS9g12vd3pmatsUei2Z9aVBLyYf3DvQrMQGN5Gf/91khvXou1avGKzMylmZ09hnLkJUrmP7CmLk0ucxrA4Bt1yAIk4hb7n4R4M3FA+zgyoVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323011; c=relaxed/simple;
	bh=ffvh4rw69doyRsmJ7u3cRO1OWqVlFCUnRhvVhvHpZTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYfW2umYm/4B/G86UfVOmMFCwF2Ei3WnGUFeX4B1k4GLZZmmjTb7y6dGUFXsFZkCRekdqIZKRemAf4hVwW5BNhM6xW10iTZx3FPf7w1XgmFEKkNb0ZE4EOOwbPdrms81aGhItj8LO4ZSpzX/LNLJWGGHfz1KNH4qKyTSvR++9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JTcDKuI/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JTcDKuI/"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8bbb02b887so342773276.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jul 2025 19:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753323008; x=1753927808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezOsh3Rw02sTHRTVL0D2zAjlIafvsBxPOvx6XqZve/E=;
        b=JTcDKuI/5CUQCswz04ZlBKuJ9nt1HfEgvhgr0nGsG9qp4BfN+m+hvEEEj2n1KSB5t5
         Hxia7vyFpvdiDnvE2X9hHOj8zKmSDAdrbDLE8CmWjesvRLDha7n4X9vXlfjpu6i1lIf5
         s5YmjwyTrKz7KDqG9G6wjRcjlDiB3ySIBdQCj4Hqgp7gwybEXQ+EFIBWRTkS+JUKxC3Z
         HE3YVrql5NXTPsdBwztgQAj6ZHafhnWx7Y1aZAd8pUBm+jAxolMA9D12Coe2nmSmnqrW
         a/b1qZmN1v9C/VqBmE7cu88zdzjd2+GScqCoLSusEJMLpxas41Qu/5Vr8kdEsDllqlXI
         JsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753323008; x=1753927808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezOsh3Rw02sTHRTVL0D2zAjlIafvsBxPOvx6XqZve/E=;
        b=DRqb/YTqYWjRd+K+O365bLfy70+87k31XbrFtCBHETVGhSFb5OnFNmaSyAzk/kmMar
         JG3rqaMiLU+lGFmIX4Xb9Wb7zi3N9uGKURzw1xbfR8Nk8uug8NJAm5/7iruuz1SLhKym
         0etBAOZsDFL3hT05kb7d5UjqELhseSO/2P8pRzOm+o2im0PDDUwMUuUQgrI8IRYUrwxb
         Ld462yPE41nnEZPcguBUmjEx+5mceuJc4Jx/U4n3q4p2auqjvUXQlJTtAMRl5HMM+HKX
         HQ9bNQ5HS5L6HFFIQ1kySoOi5IVXnlROejVW8TLOeMKjqv5jvUVU4/eWffoGEiO1UK9H
         wP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+1vvatwBBL65cWwpr2aY5N2Ip0MlZNmMtbZk2NbPt99+Kv961uk9a1Stla9XDDGgiHMU0cql1uYNb5lUx+ZLm1PVZ9es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH92GpG4Vkk4/lt+vwFgBjmDDzVgFyq0/VLxhYTpDuvTfMfavr
	uBlEDGuyq3ceFjjaQe2ES/YDUJRxcVW2+bqtKVFoM5KLpw37IprhPbexjSPYHEojVr57Gdh8R3s
	gJ7+Qy3sDcY9VBivBy+36R6nDLmXU1vPHeBT+tA7B
X-Gm-Gg: ASbGncsvlH3SE2iVSPtpz22hYJVYSn+ik2eyU5Iga0+dgUEgy0uRabFeEjAYsgWsm8w
	urYXs3FIzLRov7oENJygkUu/TilB5onYn09ARBSsyz+bfsNCFT3Qg2t/3eXaJjI35l12NJOrGED
	UBCrjs5Jm+l9w8IUJ3VXv07uMrvBJFFRAQYz1QSv7oPookAuH6tEm9ErSn6e9Y8rb/N9W3KzCuK
	Btwf0k=
X-Google-Smtp-Source: AGHT+IEjtM0YH/uIkH5EC6RHdxIYSOEo9s7z9JMeuLNs93fJxU9BkwVAtv1fRHAPFv5MIBRtQfg1omYHVhyQIQh0vnM=
X-Received: by 2002:a05:6902:1288:b0:e82:17a1:5c15 with SMTP id
 3f1490d57ef6-e8dc57e75dcmr6464733276.10.1753323006953; Wed, 23 Jul 2025
 19:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
 <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com> <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
In-Reply-To: <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Jul 2025 22:09:56 -0400
X-Gm-Features: Ac12FXzwcvMXRcY-HOujXriwLTi0J58g3gNTBeLJ4hgKLEq2xrVmA3w4Jght3uY
Message-ID: <CAHC9VhQnR6TKzzzpE9XQqiFivV0ECbVx7GH+1fQmz917-MAhsw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
> <anna.schumaker@oracle.com> wrote:
> > On 5/20/25 5:31 PM, Paul Moore wrote:
> > > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > >> <stephen.smalley.work@gmail.com> wrote:
> > >>>
> > >>> Update the security_inode_listsecurity() interface to allow
> > >>> use of the xattr_list_one() helper and update the hook
> > >>> implementations.
> > >>>
> > >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen=
.smalley.work@gmail.com/
> > >>>
> > >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >>> ---
> > >>> This patch is relative to the one linked above, which in theory is =
on
> > >>> vfs.fixes but doesn't appear to have been pushed when I looked.
> > >>>
> > >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> > >>>  fs/xattr.c                    | 19 +++++++------------
> > >>>  include/linux/lsm_hook_defs.h |  4 ++--
> > >>>  include/linux/security.h      |  5 +++--
> > >>>  net/socket.c                  | 17 +++++++----------
> > >>>  security/security.c           | 16 ++++++++--------
> > >>>  security/selinux/hooks.c      | 10 +++-------
> > >>>  security/smack/smack_lsm.c    | 13 ++++---------
> > >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> > >>
> > >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> > >> folks I can pull this into the LSM tree.
> > >
> > > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
> > > on this patch?  It's a little late for the upcoming merge window, but
> > > I'd like to merge this via the LSM tree after the merge window closes=
.
> >
> > For the NFS change:
> >     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
>
> Hi Anna,
>
> Thanks for reviewing the patch.  Unfortunately when merging the patch
> today and fixing up some merge conflicts I bumped into an odd case in
> the NFS space and I wanted to check with you on how you would like to
> resolve it.
>
> Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> security label")[1] adds a direct call to
> security_inode_listsecurity() in nfs4_listxattr(), despite the
> existing nfs4_listxattr_nfs4_label() call which calls into the same
> LSM hook, although that call is conditional on the server supporting
> NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the only
> caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
> wondering if there isn't some room for improvement here.
>
> I think there are two obvious options, and I'm curious about your
> thoughts on which of these you would prefer, or if there is another
> third option that you would like to see merged.
>
> Option #1:
> Essentially back out commit 243fea134633, removing the direct LSM call
> in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label() for
> the LSM/SELinux xattrs.  I think we would want to remove the
> NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label()
> regardless of CONFIG_NFS_V4_SECURITY_LABEL.
>
> Option #2:
> Remove nfs4_listxattr_nfs4_label() entirely and keep the direct LSM
> call in nfs4_listxattr(), with the required changes for this patch.
>
> Thoughts?
>
> [1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@redhat.co=
m/

A gentle ping on the question above for the NFS folks.  If I don't
hear anything I'll hack up something and send it out for review, but I
thought it would nice if we could sort out the proper fix first.

--=20
paul-moore.com
