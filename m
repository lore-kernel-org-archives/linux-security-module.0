Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597726059D
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536892; cv=pass; b=FsM7fmeXMNi2/4B2DpLrAUpTrHw3B4anL/TKqRlHH8v3IiukVFIGK+qpdFUGYauhsQ1LTA+DijMgmVzlse/K5FU3f4AWyYs6bX2i3r2qc/sXbbOxkVkImqDb3pQDaI/s+YWQw0mkF1U4mKkJchMY53HGtComqeJgc0V55NJfASk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536892; c=relaxed/simple;
	bh=HIp2gn9sh7sB0Bb61etjWKhYAyLkUkA04rRyBq8mqLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrM/Y0soNdsZ9nejobqdg9zbgsVqHTNjrO7oIvc61L/PuwGfN21U28H6sNP3AJDGODNOWXmilIsbGe+XxyNvhwmzu2MZ1FfGXzbablL4Eys/y5dDlDiKiKuoy/+eicL4m6rEsFj9Eh8b69we0gvwXaF43Vyjla0LFf0jFU6Exlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa8s5DZH; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa8s5DZH"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8481fb4324aso917347b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 11:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783536890; cv=none;
        d=google.com; s=arc-20260327;
        b=mJEdcIdTHVuaVyPPa6y2UBnDngteOELG4V+Rrxuk5J3jQDAAuWYrNgvk4uZITfuzp1
         AuWeft88x8kJhEPtvJqaeePPG4KBBWcILaR8ETam7iQWGpKB6JcueVW4xbsEclMp+beI
         y5UZJR94B8AyRq4IlL4ANNSLf2IsnWJGcufhyLCCJLJn86qHeMKljQzJHv0884nDF1b2
         g6hQDxL4iutQbzG2ZDtn7Kgrf+mb7PBE5E5dUXF9N977UdjjGhvtV3nF685gPSEFR15+
         Rxf6xmEcGe1O6sIo6lATXKpzLz2oj1jUjig1AL8gXCRTX/LWy/bz6bwXNOFsOxgYHwk8
         4Kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        fh=cMbc2Dn+q6hqkq01HESjkQPCwV2oIvp9a+Z1Bliryrk=;
        b=acim2+LMgDKH+x9phmnU9yJR7yOIydf6BodKdgt7lp7LCzOkrM8dU9xQhghvZJX5RO
         75qEs2jVTHyc59PGLDWvMTG/5AtMGyeUNw6kmD19FhktzaBHxxLR8/5MWT7FM+sGmMS4
         T+aXwCsVKch8zVESsG7vmrBpjkZ7zp/y3keJ5LsNorKE+IuYKGs9fMmN7s0XlOXCChBe
         hvUqYMH0ZC2Ya3gDbHcL/UEhH5WqCaggnlScjMzlwzsIJTYL2pWEa1VEB1bcHVP5Gm8N
         eTy5Fd4KZIlxSMOk0SgLjediISJOmwk4iRfIeOosvRZI6rNTg4UbRd9mSRdiJ20v2eJT
         jr2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783536890; x=1784141690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        b=Sa8s5DZH6SObVhV9JF7GuREEHXd5fbZYLVFJ8WqJnwmPCZ9+YplxU1p2KNE9//wFgp
         LibaQT/mjE67u4DIEVIBNosAXw4A67HSDgtsI7Xwh1+D7x2y6UBL5dcLTIfsGEq1g2WK
         5pwLtEU/xFAgaRLhkD9fLns2J37SYjQndn5RzgoUp3WjNwzYFIGjrj8aveJePf2ECTnl
         FimhM/vM4RvoqmVaGFjLAciFC/HkRkRjQtxbZ9CES+n0CeGcZjshH+FBu2gGwHAf1RgG
         6AOrrF0wYYSYqkPQd0TlvxxbBONV2JW02Hzbyec95kRYulxl1mvRV2bH0jevmZHsT+y7
         vMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783536890; x=1784141690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        b=i/jqbKWSXxIfC+eRkOjJz+wnyZ5YvX+21TfW12E8mvc7k60tTUzhv0W9B6Udj25UaE
         XFinwekrKwDr5VFy7ZSBwM9FrQriL14N4tzeOovhCX5Te6OjGEhGCKjuzWtlbSf2aPFQ
         +cbi6jc4CUEBXg5LrgPnPz85YiG0WWcGnO7rqA7U0kKvJWgE/toHOtz24R8C829lSbXW
         RcIzH4TgQ/RDRmwt6s2sJN8lfHRFTLJ4Z6PlcMxI407TB+DGBV+5xZ4zC8qwwU1UDkUX
         BbFeSXzrkNC5o2QW3azF4XeQqKGzfk4jb0z7dFJQf72pFyeyS9W3GPc235EbBWxF4Oms
         PetQ==
X-Forwarded-Encrypted: i=1; AHgh+RopcCgKfJHWZprnPCec2Qa+m9Bnn6ha1hy+2YWLzKl9/U5RTGmZNIAlPYcRURlBZQq3U1a9bAbk7oB8B88DJrFjnt+e/tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1260J4LEAzCuo7GIPQhuXcD9AokgKY7oNNh0EODQQWML+C8D
	NNq+APuptsC+xV4Lx+VXKEtsnZQXgDkkcqil/hQH2QOYj7FObUhFMAKd99H2ueJloiSzzOW1qVn
	U45oHrcJAsN/c080hDELwtAQ7KFOO37g=
X-Gm-Gg: AfdE7cm1g6ei8IoyhKCVuUS67ex9jYDED+gw78AkJVQJBiWvXhbucu7gkF2v5oUvd/Y
	wAngbBFuSp8x1LsqhqNfUcEBZATmS63QLjihzAcp/TiVsDKaCbGvNSeX9pp5FOoYsFBvIyygOHE
	WOD6v5FVb3thNacb5bkW27CIzwjqDuqYIcsdPjdO3nCZiuvwGs+BM86+4NNJ7bhNVmZAWv/Ed5G
	PqGxaYugFZ8vCsrGsr5Gf3VebTHD//Taiz/6st8PLRwRJJNeieBWNuxturOLFrJWtT1FadI
X-Received: by 2002:a05:6a20:2591:b0:3c0:9c19:6598 with SMTP id
 adf61e73a8af0-3c0bd1b0c2emr4467346637.64.1783536890086; Wed, 08 Jul 2026
 11:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
In-Reply-To: <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Jul 2026 14:54:39 -0400
X-Gm-Features: AVVi8CeDAYkaxOnVyk4GN4AJWFNgHCAUe8gsZ6CyBP4XvVdF15boW7cTak8LeSY
Message-ID: <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Paul Moore <paul@paul-moore.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org> w=
rote:
> > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > <achillesgaikwad@gmail.com> wrote:
> > >>
> > >> A call to listxattr() with a buffer size of 0 returns the actual
> > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > >> mount this triggers the following oops:
> > >>
> > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 0000=
000000000000
> > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > >>   [  399.768722] Call Trace:
> > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > >>   [  399.768736]  listxattr+0x23/0x160
> > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > >>
> > >> security_inode_listsecurity() (via the xattr_list_one() helper) now
> > >> decrements the remaining size even when the buffer pointer is NULL, =
so
> > >> in the size-query case, 'left' underflows to a huge size_t value. As=
 a
> > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real =
one,
> > >> leading to a NULL pointer dereference in _copy_from_pages().
> > >>
> > >> security_inode_listsecurity() does not return the number of bytes
> > >> it added to the list, so the code derived it as
> > >> 'size - error - left'. That is also wrong in the size-query case:
> > >> the generic_listxattr() contribution is only subtracted from 'left'
> > >> when a buffer is present. Thus, the query result comes up short by
> > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> > >> ACL support), and a caller that allocates the returned size gets
> > >> -ERANGE on the subsequent call.
> > >>
> > >> Declare 'left' as ssize_t, use a scratch copy to measure security
> > >> hook consumption, and only decrement 'left' if a buffer is present.
> > >>
> > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_lis=
tsecurity() interface")
> > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > >> ---
> > >> Changes in v2:
> > >>  - Use a scratch variable to track security label size directly,
> > >>    replacing the old formula that undercounted the size-query case.
> > >>  - Drop the now-unneeded NULL-buffer special case for
> > >>    nfs4_listxattr_nfs4_user().
> > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > >>    (the same accounting bug caused both the oops and the undercount)=
.
> > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achilles=
gaikwad@gmail.com/
> > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > [CC'd the LSM and SELinux lists for visibility]
> > >
> > > Unfortunately my testing was unsuccessful due to an NFS problem that
> > > started with the v7.2 merge window that I haven't had the time to
> > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > figure they will want to send it up to Linus via their tree, if not
> > > let me know and I can send this up via the LSM tree.
> >
> > Yeah, we'll send it through the NFS tree.
>
> Thanks Anna.
>
> > I'll be curious to hear
> > what problem you're hitting, and what patch is the culprit once you
> > do that bisect!
>
> Yes, me too :)
>
> I'm still working through a review backlog so it might be a bit before
> I have a chance, but in case anyone wants to test it out, it's easily
> reproduced using the selinux-testsuite and the NFS tests:
>
> https://github.com/SELinuxProject/selinux-testsuite#nfs

They seem to pass for me with and without the patch (they don't
exercise listxattr AFAIK).
This was on the current selinux/dev branch, v7.2-rc1 based.
