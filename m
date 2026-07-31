Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921E4499B9
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514192; cv=pass; b=qWwQpb4qdjSBpY7x3/mjRvKtABX/f+2lmBO3PQtDSeN3MYF88rktyRsm9StmCN8uryWQhuB9l+yyDMTtT1rlaQs3Bfy88124Q0OISxMdnwtgGkw1tbMhh1mTPm7mL9zM2TEmCRpm8pMrVPN7UvUsWD47MO8EmtjuJSIv0Sda3oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514192; c=relaxed/simple;
	bh=E2RVSRIXeuAo+5wfQpBk4zmpUN/FQ1MtmGDwrYQP8YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3kaNiXQg/AQ/3u3Y2XQ88N2SMNL9dQksI7AJ7t6VZd/iwrtJC/Vdz+cSKuSYJwNODfO5CD+ed22c8wkfjeHKeSqt4liqvvXM7uCxp3sy3TGk5gcuNk7Frw12CwJdGEhDWX5dUCDCqCTS7cCsk4dGagT/GEeLhj6tXrAowstaFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cqM73njM; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cqM73njM"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1073033a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 09:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785514190; cv=none;
        d=google.com; s=arc-20260327;
        b=gviD/32fB39mq3XPdg3YsfIrO84U5vWv3Bj6Xghf2myrOlBkRwRchzPz7IrildMGh9
         r63EeI6c7U9tEfm942kqsAuTGd1EhPswpPCCopZKSrtndztIdrOOcXQoQgSCfwyhtLqf
         HOcSLvDa/RwsbiTNiY2A0RfMnj4ggAsVuWyIVfB140Z9agcklI8f99pAKqeKkLIiU6pd
         DYkmZ+tkPYt/99HJYkLBlcobzzXurZY+QOhpvLrtWkwh8LeZLsC9QgoRAu85BCuCS7c6
         7TXNaeLFPPA6J5fyUbXJOPriVdl61r3DCTQOY1RwVQsf4HWn/FxMo8nlmBh71zOAsRqw
         UcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MLQBHce5Rf/yizV53vOxCocZN1WkAdEkQ9OKlG+s1GA=;
        fh=qE+aDFGrkCj72ZC48j6brpc1FNG8/Q7Plyh06PknPGE=;
        b=bs0MVPWcycI6bHITaZOoPA4zZwCwt2hXa/bFgP+NIhObuxsOu+y4SGuvbgM74Rhc1R
         gQ5PIkwgmGPDq81AuOelk7TTVz1LXZuDm1d2XDI34Nfp7FBPwFQ/1D8lQJVye11VkWAn
         EmaCfeMK+DTBWwvtJE509lbqq15HHvRIeBjbbna94dsJ+PZ4LSFnxLlB+uTSBHjAhW/s
         5cPOwHnJuJGOl2bYcnwzr96SiYIpz8t2vhLaNtNaqzZ+tYDRhWcKhvIK33kigP7VzlUV
         0YAOnfz1971DfBsqVesEt//As3ZM7Tj3W+7rlasVl4OyJHCb0gLxWLPUjNy8Nw+gCGTy
         oN/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785514190; x=1786118990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MLQBHce5Rf/yizV53vOxCocZN1WkAdEkQ9OKlG+s1GA=;
        b=cqM73njMXUadFgHefsHny48QLdlchgsJq03UlTMklOD16QGYAl29Px8XNxCgk+687Z
         I5uPB1A0WfenSXZAc02HEiRyVfr87keZ4Oa5kylnaceiSp/Fq7sKpWwBscc4c88j4Qdk
         pPsyTXxzX8O4jtPYCi6jMH9zEmTU+N0iad7WQR0o+Oatq2Fh2LALVyXENkRdLTJ9nyWz
         AgLi+nRgEtzRD15QvrrUQub3uV2OqAtJFL5e89/i5pdLpKTFiMoZqfzDqbLxid9HthTu
         tTW8ibqpUEsxWidbIJJrHuCXlKCzAwSdtj73g6yzSh8AW6YC9sEuHwtV3H3kadvkPVkH
         miEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514190; x=1786118990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLQBHce5Rf/yizV53vOxCocZN1WkAdEkQ9OKlG+s1GA=;
        b=n+iMpaQ/OQY6z+UZ1FFWpUOn6FcBiBuO1uc7L5jqsR3p+K6wfguYnBMIKhZG76rZWA
         J6vOO/8q25KaKPnwnVgWWLc1kvjWz3bwCoToXbWQF/YUCRUA6JOe0xX1zg5ik29tsoJE
         FJdyiZvhxzM2D/ckejxEDMAZFdO8CA3ZeW1TU6QSJxmUJTyyQ++ekX/qXOeMgPGSPueb
         6ttqJ94p3W0Hs5B+9+CF85IN8RXbKwr4RFISanmKzWTKQzptYSOyDf0/JbaHEH1Mf8/z
         r7CB+uDNsfGs/2IS687+07abc7WfUD9syKZ65yUZ4TzvGOzaUvDH286J2ECJDbdZ9GL9
         e9mg==
X-Forwarded-Encrypted: i=1; AHgh+RqhUQHnjdE22919EXC70ZzAf7D42AKkpFJD5IqjXUv3MFpMLaC+HnA+274WUucA3fnZVB+sFAJCzVkYCRSXx3icEuOuHB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQnV73StKh3ZpEwbU3NZa0dBatEEimhfvHHmJEsZX+1SoMzwb
	rDfXmowVA5KKtnV+5JcQLnOaBUNf7hoxNtZPeBA0CZD1chk06LtDkdNkYSnKXKJFJGm+FGwNgMN
	M658z8ITi1P6shRX97dJwK24zX3bkiq2iOIfGxJQH
X-Gm-Gg: AR+sD12VZBAcnFhq/a7Oh0G8MT6L+B4iKjARFBfrs3xSuyBH9+qxgGzoCnfNff9T/Ve
	iXJCbpQl65ceHFe+SBPDr7doR+Jh2F/moRWg2mhmc9Hm1qt4VnNfWDZpob+QMGDINPl1e1VT7xV
	NSE60I7xPYF8p2FtX/2svGb+/nMXCVT9fNoVtDqShgHyYHT0y5K+fD/K1b++8qqUrQLPjYVSLHE
	BUExy3l8d3RwwJ67ve0tAt92XwoMwxUbiWknHb40Yw8Vn6CBvIlIEcqJCu6OTejgri27G/I3G2T
	s7Is0MrHL53Xhu2j/YSzMz0iZlq0yBQlQbslwgKdeih8
X-Received: by 2002:a17:90b:4c42:b0:37f:9cdf:f0ac with SMTP id
 98e67ed59e1d1-38fbc4cf1b2mr463861a91.27.1785514189775; Fri, 31 Jul 2026
 09:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260725200958.4471-1-cel@kernel.org> <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
In-Reply-To: <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 12:09:36 -0400
X-Gm-Features: AUfX_mzgQGB2mMZ1ML9jDaE9s_9fzccqwz-sP-5nGT2rz4DpCr8cGB7c5pnPRjI
Message-ID: <CAHC9VhS6B1yW+8G9Biqit5CAmcg4CwCaWbq1B+Qpo2n6a=yqnw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Chuck Lever <cel@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, jlayton@kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 11:03=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Sat, Jul 25, 2026 at 4:14=E2=80=AFPM Chuck Lever <cel@kernel.org> wrot=
e:
> >
> > On Mon, Apr 28, 2025 at 03:50:19PM -0400, Stephen Smalley wrote:
> > > Update the security_inode_listsecurity() interface to allow
> > > use of the xattr_list_one() helper and update the hook
> > > implementations.
> >
> > This commit wedges an NFSv4.2 client running fstests.
> >
> > A kdevops fstests run against nfsd-next hangs at generic/086.  The
> > client stops making progress and never recovers:
> >
> >   watchdog: BUG: soft lockup - CPU#3 stuck for 250s! [086:60396]
> >   Comm: 086 Tainted: G  D  L  7.2.0-rc4
> >     __pv_queued_spin_lock_slowpath
> >     _raw_spin_lock
> >     nfs4_xattr_set_listcache [nfsv4]
> >     nfs4_xattr_discard_cache [nfsv4]
> >     nfs4_xattr_cache_scan [nfsv4]
> >     do_shrink_slab
> >     drop_caches_sysctl_handler
> >
> > The D taint says something died earlier.  It did: by the time the
> > lockup fires, the client has already taken two dozen NULL pointer
> > dereferences, all of them in the same place:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   RIP: _copy_from_pages+0x44/0xd0 [sunrpc]
> >     nfs4_xattr_cache_list [nfsv4]
> >     nfs4_listxattr [nfsv4]
> >     vfs_listxattr
> >     __x64_sys_listxattr
> >
> > The two stages are connected.  nfs4_listxattr() declares its
> > remaining-size accumulator as an unsigned size_t.  On a size query,
> > where listxattr(2) passes a NULL buffer and a length of zero,
> > xattr_list_one() decrements that accumulator for the SELinux label
> > without regard to the NULL buffer, so it wraps to a very large
> > value.  nfs4_xattr_cache_list() then sees a NULL buffer paired with
> > a buffer length large enough to pass its own bounds check, and
> > copies into it.  The fault happens while the xattr listcache
> > spinlock is held.  Task exit does not release spinlocks, so the
> > lock is orphaned, and the next shrinker pass spins on it until the
> > watchdog fires.
> >
> > The reproducer is a plain getfattr on a file on an NFSv4.2 mount
> > with SELinux enforcing, which is what fstests generic/086 arrives
> > at by way of a drop_caches write.  No fstests machinery is needed
> > to see the oops.
> >
> > An audit of the listxattr path pointed here, so I built nfsd-next
> > with this commit reverted and reran the full fstests nfs_v42
> > section on the same pair of guests.  745 tests, no soft lockup, no
> > oops, and generic/086 passes.  The two failures that remain,
> > generic/033 and generic/258, are unrelated to xattrs.
> >
> > I am not proposing the revert as the fix.  Achilles Gaikwad has
> > already posted a targeted patch for the accounting itself:
> >
> >   https://lore.kernel.org/linux-nfs/20260707152305.15324-1-achillesgaik=
wad@gmail.com/
> >
> > Whether the right answer is that patch, a change to
> > xattr_list_one() so it leaves the remaining size alone when the
> > buffer is NULL, or hardening nfs4_xattr_cache_list() against a NULL
> > buffer, is for the three of you to settle.  I am reporting the
> > severity, because the accounting bug is not confined to a short
> > size query: on a filesystem that caches xattrs behind a lock, it
> > takes the whole machine down.
> >
> > I can test whatever you settle on against the same setup.
>
> I reviewed Achilles's patch back in early July and it looked okay to
> me (see my tag in my email in that thread from July 7th).  I had
> figured that the NFS folks would have wanted to pull that via the NFS
> tree since it only touches NFS code.  If they would prefer I send it
> up to Linus via the LSM tree I can do that, but I would appreciate an
> ACK and Tested-by from someone on the NFS side.
>
> While I don't suspect it will be very interesting, I just started
> building a test kernel with Achilles's patch that I'll run through the
> normal selinux-testsuite automated testing.

Chuck, Anna, Trond, Jeff - can someone ACK Achilles's patch below or
suggest what changes might be necessary?  There is a known regression
(see the existing mails) and we need to fix this before v7.2 ships.
I'm happy to send this up to Linus if you would prefer, but I would
*really* like to see an ACK from someone on the NFS side.  If I don't
see any comments be early next week I'll send this up to Linus via the
LSM tree.

https://lore.kernel.org/linux-nfs/20260707152305.15324-1-achillesgaikwad@gm=
ail.com/

--=20
paul-moore.com
