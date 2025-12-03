Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9933F8A8
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777318; cv=none; b=fKrz9EdnzBHd60QFSB/xK8XwQXca8252/mYLzpJ9753vMnWz1ZqaG5w9KnvkNN7m+dd2CPGi+KbthkbTxx7mo1Ot/vVuoSRGEN1G/xR1yQNjF1SSS5TI8aIYzS2IC2AfGgKlYziQfzXGnLIkrMsXNbTRKGF3v7Qy+zqPyGubVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777318; c=relaxed/simple;
	bh=u3Dy2G3WRTyFesbvCVKYgejnMDOxq7tkjLs3uSapkfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9Gy33mbND2l75EJQKs1hnue7a5f2QauSaSnfUn9s9KK6ACd4lLoGMoQ4b0K/ba2ru5kQdlANQd9vG7o2nvuTXE8qt+WR4ToBzk5RDIGFFyKKqAkWu9okNPczY0PNd9D+S5SzTX6ED+o9NiFCEZGMYtAeRZKxwYbDnvPR1RNfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MOhshlP2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MOhshlP2"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so470455a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Dec 2025 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764777316; x=1765382116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p/Pi5AWZHYDPsiAr+hwgDoJDjponKbr9dQ4aVc/nMQ=;
        b=MOhshlP2iwKgV6mqQ9uU1z08WtQGIGmY554H3UBMXEUdWqoYheVwV+Cu7HFMW+P6PD
         FPBoR+sDs7FUTlo22RmQut8CEtXCVBf6za6xlFmhAbYjPKZ1qpXixUMfoEnnpKV4LkTe
         H2SniOzX7L04ifLK+PB+p+U61BN5yWxZjQKBALxwpy/8PkpKb6XooXUQILaD8TJhvf96
         GQgsZMrx6WDOEVbiP+4L56uVTVWe4Mq6KaLM6J/x4FB/RvJkDl4icuAn7Fus2cvN+IUP
         MDOb+S5ANpQLb7ptx/wpOJasjusw1dMCx4mkV56a5nRSBgqq4QDiZcIMZheNVorQqZKS
         WvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777316; x=1765382116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/p/Pi5AWZHYDPsiAr+hwgDoJDjponKbr9dQ4aVc/nMQ=;
        b=ld89Iaxotuqfi7d+VdKkqr+vtrObVxezwFGEmAVn8fYHZUwx6K6h2KoHgQl51CBq5/
         ybKuJuhNqFU0Gxx1rqGaMm89DZpQw3JUve563l2ykBg2lDhzlgzPg32+5Bb+qp/KxYk5
         O7cKleFgK4naxX8XzbQHohKxDzxMRXrTDEdskKR5tqIa4XsjAHhenVqg0aIbegdmZQyY
         ee9PKPuLFHxPoI/s96E30vwfY/rwCTb2XDiw5rYMJiJa1MO3PfC3OfT8TT43/HTbgeVx
         UuAaOclFthLvxkkvY3B21zbUIlufdt9UMT8OXQJoc/aU7nFb4Eoh4iKjjyIlyAfoqwn5
         j6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUJUPYeIz0qAa30hKIssFKx4WU+fRM1H0Ng/WA4Tv7TRZa7VsOtps4FI6DmY98SimXm5IwNqmi1972TJYnJeB1Lfm2QAok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWg1NBOKt4WURKGBMAz+gbjpebszarRS0qYzdR9mt9b5dWWfY
	A7YUfvZHqXEzsJ0zA3sxSN1edcjdx/tJaFaIodthN7FKplVXUPQ+DBvHGOj1++gJuvVG4qs0GAx
	RT0LFV8O6XEsCJO+NeqXlj4hCub5cBrZIjNij8E/Z
X-Gm-Gg: ASbGncuBc+tNjoj1S9B9cSqVDVxSx6fIUFfEfRLUH8TThWENA3JcwGNqdyc3121Uwd8
	0qTiPSKpnEPfBeLEvlfCloOCk6wBpaB+D2XzLEUI7lTGJ1dWVV8+lzLPM4Y0U5WFWQg3/8JR4tg
	zFm5QFu6gEKC0L50PAJjujtzklUIWo+MEJBw1MR8mAefIeLlN6Iw31a/iCNSpdzSjbQLn3vRxKF
	wdpwlX7Ic0k2FuEElQSTZcfqZgnhq8rPqnKtPMVF2ctPzePm2MaI6Q480fRyY+ck/MSPHU=
X-Google-Smtp-Source: AGHT+IFqrCGVBw0W6skiqMchfp9P0aCB9lQB6KewuBkAjCizkiC6upTGzicvdWl58VewJl0Dw2tgBc6JaUZoagFsGFM=
X-Received: by 2002:a17:90b:5610:b0:349:162d:ae0c with SMTP id
 98e67ed59e1d1-349162daf89mr2486825a91.4.1764777315815; Wed, 03 Dec 2025
 07:55:15 -0800 (PST)
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
 <CAHC9VhQnR6TKzzzpE9XQqiFivV0ECbVx7GH+1fQmz917-MAhsw@mail.gmail.com> <CAEjxPJ7_7_Uru3dwXzNLSj5GdBTzdPDQr5RwXtdjvDv9GjmVAQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_7_Uru3dwXzNLSj5GdBTzdPDQr5RwXtdjvDv9GjmVAQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Dec 2025 10:55:01 -0500
X-Gm-Features: AWmQ_bmh5eHBqsgQJybJ_-JtI6h64GzWSkh4DPBnzoJo8LXqkNENNTHyNoV6hjI
Message-ID: <CAHC9VhQDHTNkrB4YuNoafM0bhAav=CP5Ux6ZZGY9+WF0+0_9ww@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 10:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jul 23, 2025 at 10:10=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Jun 19, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
> > > <anna.schumaker@oracle.com> wrote:
> > > > On 5/20/25 5:31 PM, Paul Moore wrote:
> > > > > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > > > >> <stephen.smalley.work@gmail.com> wrote:
> > > > >>>
> > > > >>> Update the security_inode_listsecurity() interface to allow
> > > > >>> use of the xattr_list_one() helper and update the hook
> > > > >>> implementations.
> > > > >>>
> > > > >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-ste=
phen.smalley.work@gmail.com/
> > > > >>>
> > > > >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > >>> ---
> > > > >>> This patch is relative to the one linked above, which in theory=
 is on
> > > > >>> vfs.fixes but doesn't appear to have been pushed when I looked.
> > > > >>>
> > > > >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> > > > >>>  fs/xattr.c                    | 19 +++++++------------
> > > > >>>  include/linux/lsm_hook_defs.h |  4 ++--
> > > > >>>  include/linux/security.h      |  5 +++--
> > > > >>>  net/socket.c                  | 17 +++++++----------
> > > > >>>  security/security.c           | 16 ++++++++--------
> > > > >>>  security/selinux/hooks.c      | 10 +++-------
> > > > >>>  security/smack/smack_lsm.c    | 13 ++++---------
> > > > >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> > > > >>
> > > > >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smac=
k
> > > > >> folks I can pull this into the LSM tree.
> > > > >
> > > > > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some =
ACKs
> > > > > on this patch?  It's a little late for the upcoming merge window,=
 but
> > > > > I'd like to merge this via the LSM tree after the merge window cl=
oses.
> > > >
> > > > For the NFS change:
> > > >     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
> > >
> > > Hi Anna,
> > >
> > > Thanks for reviewing the patch.  Unfortunately when merging the patch
> > > today and fixing up some merge conflicts I bumped into an odd case in
> > > the NFS space and I wanted to check with you on how you would like to
> > > resolve it.
> > >
> > > Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> > > security label")[1] adds a direct call to
> > > security_inode_listsecurity() in nfs4_listxattr(), despite the
> > > existing nfs4_listxattr_nfs4_label() call which calls into the same
> > > LSM hook, although that call is conditional on the server supporting
> > > NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the only
> > > caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
> > > wondering if there isn't some room for improvement here.
> > >
> > > I think there are two obvious options, and I'm curious about your
> > > thoughts on which of these you would prefer, or if there is another
> > > third option that you would like to see merged.
> > >
> > > Option #1:
> > > Essentially back out commit 243fea134633, removing the direct LSM cal=
l
> > > in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label() fo=
r
> > > the LSM/SELinux xattrs.  I think we would want to remove the
> > > NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label()
> > > regardless of CONFIG_NFS_V4_SECURITY_LABEL.
> > >
> > > Option #2:
> > > Remove nfs4_listxattr_nfs4_label() entirely and keep the direct LSM
> > > call in nfs4_listxattr(), with the required changes for this patch.
> > >
> > > Thoughts?
> > >
> > > [1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@redha=
t.com/
> >
> > A gentle ping on the question above for the NFS folks.  If I don't
> > hear anything I'll hack up something and send it out for review, but I
> > thought it would nice if we could sort out the proper fix first.
>
> Raising this thread back up again to see if the NFS folks have a
> preference on option #1 or #2 above, or
> something else altogether. Should returning of the security.selinux
> xattr name from listxattr() be dependent on
> NFS_CAP_SECURITY_LABEL being set by the server and should it be
> dependent on CONFIG_NFS_V4_SECURITY_LABEL?

Thanks for bringing this back up Stephen, it would be good to get this reso=
lved.

--=20
paul-moore.com
