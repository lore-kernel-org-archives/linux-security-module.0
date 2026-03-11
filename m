Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D1192B90
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204419; cv=pass; b=g/h4KF+qMInjx21BVbNuIrAMJGUK+N2Mz3IsSZjd+E6u1OEQcLeD8ZoC1XawV5pKMOAFeq3bbrwJwpcnHu6Y6PLArZPf+6Ekmmwm0niRXLwS6qSTXsgxrYBpt+7WjFifoEkM65hD0GmPRWAXfDLjDAty+EkbQ4GV6tfG8qvAEDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204419; c=relaxed/simple;
	bh=7VDnx/WexNP6fJ6Aw0EUTWYVLU8ZmBqFSXK6BHZewe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luD0tAKtZqCODSocG9mhCW2yWpacSzYkfdHdQmq60qsxGzw4lzvaeNU20VnneEojmIm3XdT9gA6D6janieguu4GcsW3pTNrRXOlmtHzZFKa8QA33IGLvrGJDHXYzy8+GnEbDLD+kfjK5b7exI8Hr+xB9lCJiw5ofnbPDOBYtv0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcGVj0u1; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcGVj0u1"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128b9b7e3edso516428c88.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 21:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773204417; cv=none;
        d=google.com; s=arc-20240605;
        b=M99wD1h+/tYjpkMW6sCqgQCQmeuZriQ4h7U45TwrNcQC29aQgjKHHDVP/BzusS/y+D
         1q6ZiyCGK3Yzor+us2vCA44RY0tFsHf4CGO0GoXTXev8QQKSH9MN7u8Tis7RXpqT8rfN
         4RYKjOWxCyrP/8rTnWNsH2ab/z3xOumY0teCuKk8hSGzbU5VG9uvVVC006wrn2h7/qVQ
         SO/zUviv1zgvRyRWzuFTX7vwaMeqYyc3A0le/POnbU+UnMHlDpZDJs7dNjPmR+QpqVpu
         HEEZb6dR8DpMoAShZl/E9mDBIbbPoXAYKmeYEQAjasaRIM2ejLuygXjipXpoBaXqitVg
         uAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dsL2L18lB/J5/AG+sLmmu1z+slL5mui1OlzCn6xCPbY=;
        fh=2BfC/rTVY94uEALED27CciJuTEGFMrg29oYGI1bPAGo=;
        b=IYycYhyxz1ph4cI8uA5V7y1dGFMrSrARofqMPndXpoLSAepL3qsSl5oXtscBgn0MTe
         m2bxlQCV6q0r1X5SCrEHRZPyJLwygCiQ/gtip11GU15qzlx5LbH3kI6RgU9Nq4qcOLK1
         lMsq2/hzv1TYXlSBQjpD+GRoax64POIk0HK+dMBCDwBnQL1FsjVBxniHxQrCauH4VewI
         Vdy+vTJSWuxsAhTEW/hNdHuhKTR6sayQdpwJelttIS0lFGcOuYWOh4BLBzJg28NGUomF
         bu7uc3ppMInJ3vSNskhMXwg1/TssarQj7/AYg9vzOdvbJX8UtV9sFqdAW8dqaIjPwzeL
         rrdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773204417; x=1773809217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsL2L18lB/J5/AG+sLmmu1z+slL5mui1OlzCn6xCPbY=;
        b=mcGVj0u1LmMzQrI84xWNRnXGrR63VILwXBXahPWPXRIIFGPaHgkMRMIYUrt1YS/f/0
         DO3+y/GWS/hgg5Qe3fifNhQFvZNt0iG0FV+Onyl9DQO5ep6w79N+iGciRj98M9C9wxHf
         w0MYRmEOKujk/XJim8wdwpESn4KD454+ifu8eyDbYEgw5YScU6CtTBaZNlr6U1mr99M6
         ap8v/SiRZnyUm1QMboKJu4He9CpbPN37ge4z61k9AuZ3Ra+QpHGa1zcpIMt1ay/OsD96
         3uakbLpmVFH5c5L0LtVF7q1YOzk648ZTMDPcOC45SSWZrKGBwxGXCCii/I3OgFGpRsyC
         ZkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773204417; x=1773809217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsL2L18lB/J5/AG+sLmmu1z+slL5mui1OlzCn6xCPbY=;
        b=NQuw3OTvlEk8yH/9V5l24/8fdborIPQ6F2moZSHtKRj0VKPcjJWRKUAWbpcrohOEBn
         B+Cd6uiROaKKXbP122MwGP3lD+0fyQhDzgBRfpYI+v1KSbHklwZYK+Xd8NpqjorPX0hk
         ONxExmaloiTzHrSQxfUD8WO0S20Q3nRrh8YxTj7agQPisxc7m9ErIszd/935E/RxiG2Y
         eErfQ/FEfrN8TePEtmNUALIDxrF6T6NG1AUT+/L6mTK2rc4NnF5ncvWaCQmzojE4keiL
         NxBqZkc3DuZoe3DjS/vG3KCSUQkMF58XoPxQl6XH38dc8gekoxtulXxUF6XSETPGG5ly
         Deyg==
X-Forwarded-Encrypted: i=1; AJvYcCUvJ6m/NH3nsikbRLPYWCA/zgFWPwxefxx0liLB2S5J0u2jgywDQ3h67B3lmhKzdcXu6Gh5T1mN/eHsBtxnWADQkeqW+CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCz2lVIr/RqCUsy7MnaaDfLnd2rw2wiqiBCRGQ8JskPLUJu5tl
	/k709Qc28Rgn63/o+ebywBeehguxokyVx2A656GIixyAQx8hreHzz6x+2V8oJr55V9TMQYDp1PO
	tW3ddTb7z2rfLlQ4Oh6Gf4sH+szXwX5W7s8JuRe2t
X-Gm-Gg: ATEYQzwSWwN49zzLRSATk81xbf+TkjL1jlU07Qvv/MttYebWG4xC0OF6Sn+BN1xswTB
	gytckuHxI1NtWCpjRas9a5sJhKB/v4v2XWAYbXUSLa0h0zl1W7a8bGkLTuimHdhOw+9pENKEo0M
	pV7sBbSc0KspFudxKGlO7d8tI02MVPYhCSFUM1FvmYKHHGHYzwo9jVM7Rrm4Y5V68Zsb6r0Ihn2
	lvkNggRhBB2dmCT4CTtOZCUFroQKSDIfRWAmyRERbR9Nvzt5oJT/pGA0mEMZb4X2/VSup/J32Bb
	16fsVgsokT29t+ZgBVUNfNxBlBnYAc9VfUvmHtYy13c8sgqi43JCT7bY+MMWdHoYSf1ZTJs=
X-Received: by 2002:a05:7022:fa0:b0:128:d24a:a5c1 with SMTP id
 a92af1059eb24-128e781fea0mr616135c88.28.1773204416488; Tue, 10 Mar 2026
 21:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215105158.28132-1-gnoack3000@gmail.com> <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260217.lievaS8eeng8@digikod.net> <20260220.82a8adda6f95@gnoack.org> <20260308.AiYoh5KooBei@digikod.net>
In-Reply-To: <20260308.AiYoh5KooBei@digikod.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:46:45 -0700
X-Gm-Features: AaiRm51QaGMCzQFoMPOfJpnqS1rl3er9hSArWJhuhbDdVHzJhovMzOmLqZZ9_gA
Message-ID: <CAAVpQUC95mSjX1vRK===pubHofcYqbkNE7goYKiu6vha5GYAFw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket
 resolution by path
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Jason Xing <kerneljasonxing@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 1:18=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Fri, Feb 20, 2026 at 03:33:28PM +0100, G=C3=BCnther Noack wrote:
> > +netdev, we could use some advice on the locking approach in af_unix (s=
ee below)
> >
> > On Wed, Feb 18, 2026 at 10:37:14AM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On Sun, Feb 15, 2026 at 11:51:50AM +0100, G=C3=BCnther Noack wrote:
> > > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/lan=
dlock.h
> > > > index f88fa1f68b77..3a8fc3af0d64 100644
> > > > --- a/include/uapi/linux/landlock.h
> > > > +++ b/include/uapi/linux/landlock.h
> > > > @@ -248,6 +248,15 @@ struct landlock_net_port_attr {
> > > >   *
> > > >   *   This access right is available since the fifth version of the=
 Landlock
> > > >   *   ABI.
> > > > + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domai=
n sockets
> > > > + *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts=
 both calls to
> > > > + *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2=
)` with an
> > > > + *   explicit recipient address.
> > > > + *
> > > > + *   This access right only applies to connections to UNIX server =
sockets which
> > > > + *   were created outside of the newly created Landlock domain (e.=
g. from within
> > > > + *   a parent domain or from an unrestricted process).  Newly crea=
ted UNIX
> > > > + *   servers within the same Landlock domain continue to be access=
ible.
> > >
> > > It might help to add a reference to the explicit scope mechanism.
> > >
> > > Please squash patch 9/9 into this one and also add a reference here t=
o
> > > the rationale described in security/landlock.rst
> >
> > Sounds good, will do.
> >
> >
> > > > +static void unmask_scoped_access(const struct landlock_ruleset *co=
nst client,
> > > > +                          const struct landlock_ruleset *const ser=
ver,
> > > > +                          struct layer_access_masks *const masks,
> > > > +                          const access_mask_t access)
> > >
> > > This helper should be moved to task.c and factored out with
> > > domain_is_scoped().  This should be a dedicated patch.
> >
> > (already discussed in another follow-up mail)
> >
> >
> > > > +static int hook_unix_find(const struct path *const path, struct so=
ck *other,
> > > > +                   int flags)
> > > > +{
> > > > + const struct landlock_ruleset *dom_other;
> > > > + const struct landlock_cred_security *subject;
> > > > + struct layer_access_masks layer_masks;
> > > > + struct landlock_request request =3D {};
> > > > + static const struct access_masks fs_resolve_unix =3D {
> > > > +         .fs =3D LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> > > > + };
> > > > +
> > > > + /* Lookup for the purpose of saving coredumps is OK. */
> > > > + if (unlikely(flags & SOCK_COREDUMP))
> > > > +         return 0;
> > > > +
> > > > + /* Access to the same (or a lower) domain is always allowed. */
> > > > + subject =3D landlock_get_applicable_subject(current_cred(),
> > > > +                                           fs_resolve_unix, NULL);
> > > > +
> > > > + if (!subject)
> > > > +         return 0;
> > > > +
> > > > + if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.f=
s,
> > > > +                                &layer_masks, LANDLOCK_KEY_INODE))
> > > > +         return 0;
> > > > +
> > > > + /* Checks the layers in which we are connecting within the same d=
omain. */
> > > > + dom_other =3D landlock_cred(other->sk_socket->file->f_cred)->doma=
in;
> > >
> > > We need to call unix_state_lock(other) before reading it, and check f=
or
> > > SOCK_DEAD, and check sk_socket before dereferencing it.  Indeed,
> > > the socket can be make orphan (see unix_dgram_sendmsg and
> > > unix_stream_connect).  I *think* a socket cannot be "resurrected" or
> > > recycled once dead, so we may assume there is no race condition wrt
> > > dom_other, but please double check.  This lockless call should be mad=
e
> > > clear in the LSM hook.  It's OK to not lock the socket before
> > > security_unix_find() (1) because no LSM might implement and (2) they
> > > might not need to lock the socket (e.g. if the caller is not sandboxe=
d).
> > >
> > > The updated code should look something like this:
> > >
> > > unix_state_unlock(other);
>
> unix_state_lock(other) of course...
>
> > > if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket)) {
> > >     unix_state_unlock(other);
> > >     return 0;
> > > }
> > >
> > > dom_other =3D landlock_cred(other->sk_socket->file->f_cred)->domain;
> > > unix_state_unlock(other);
> >
> > Thank you for spotting the locking concern!
> >
> > @anyone from netdev, could you please advise on the correct locking
> > approach here?
> >
> > * Do we need ot check SOCK_DEAD?

It depends ?  But I don't see your full patch and have no
idea how it will be used.


> >
> >   You are saying that we need to do that, but it's not clear to me
> >   why.
> >
> >   If you look at the places where unix_find_other() is called in
> >   af_unix.c, then you'll find that all of them check for SOCK_DEAD and
> >   then restart from unix_find_other() if they do actually discover
> >   that the socket is dead.

Note all callers of unix_find_other() later locks the other
and double check SOCK_DEAD.

The same check in unix_find_other() is to avoid unnecessary
locking in case the socket is dying.


> >  I think that this is catching this race
> >   condition scenario:
> >
> >   * a server socket exists and is alive
> >   * A client connects: af_unix.c's unix_stream_connect() calls
> >     unix_find_other() and finds the server socket...
> >   * (Concurrently): The server closes the socket and enters
> >     unix_release_sock().  This function:
> >     1. disassociates the server sock from the named socket inode
> >        number in the hash table (=3D> future unix_find_other() calls
> >        will fail).
> >     2. calls sock_orphan(), which sets SOCK_DEAD.
> >   * ...(client connection resuming): unix_stream_connect() continues,
> >     grabs the unix_state_lock(), which apparently protects everything
> >     here, checks that the socket is not dead - and discovers that it
> >     IS suddenly dead.  This was not supposed to happen.  The code
> >     recovers from that by retrying everything starting with the
> >     unix_find_other() call.  From unix_release_sock(), we know that
> >     the inode is not associated with the sock any more -- so the
> >     unix_find_socket_by_inode() call should be failing on the next
> >     attempt.
> >
> >   (This works with unix_dgram_connect() and unix_dgram_sendmsg() as
> >   well.)
> >
> >   The comments next to the SOCK_DEAD checks are also suggesting this.
> >
> > * What lock to use
> >
> >   I am having trouble reasoning about what lock is used for what in
> >   this code.
>
> It's not clear to me neither, and it looks like it's not consistent
> across protocols.
>
> >
> >   Is it possible that the lock protecting ->sk_socket is the
> >   ->sk_callback_lock, not the unix_state_lock()?

Yes, but unix_state_lock() is better.

BPF SOCKMAP is the major user of sk_callback_lock.


> > The only callers to
> >   sk_set_socket are either sock_orphan/sock_graft (both grabbing
> >   sk_callback_lock), or they are creating new struct sock objects that
> >   they own exclusively, and don't need locks yet.
> >
> >   Admittedly, in af_unix.c, sock_orphan() and sock_graft() only get
> >   called in contexts where the unix_state_lock() is held, so it would
> >   probably work as well to lock that, but it is maybe a more
> >   fine-grained approach to use sk_callback_lock?
> >
> >
> > So... how about a scheme where we only check for ->sk_socket not being
> > NULL:
> >
> > read_lock_bh(&other->sk_callback_lock);
> > struct sock *other_sk =3D other->sk_socket;
> > if (!other_sk) {
> >       read_unlock_bh(&other->sk_callback_lock);
> >       return 0;
> > }
> > /* XXX double check whether we need a lock here too */
> > struct file *file =3D other_sk->file;
> > if (!other_file) {
> >       read_unlock_bh(&other->sk_callback_lock);
> >       return 0;
> > }
> > read_unlock_bh(&other->sk_callback_lock);
> >
> > If this fails, that would in my understanding also be because the
> > socket has died after the path lookup.  We'd then return 0 (success),
> > because we know that the surrounding SOCK_DEAD logic will repeat
> > everything starting from the path lookup operation (this time likely
> > failing with ECONNREFUSED, but maybe also with a success, if another
> > server process was quick enough).
> >
> > Does this sound reasonable?
>
> Actually, since commit 983512f3a87f ("net: Drop the lock in
> skb_may_tx_timestamp()"), we can just use RCU + READ_ONCE(sk_socket) +
> READ_ONCE(file).  The socket and file should only be freed after the RCU
> grace periode.  As a safeguard, this commit should be a Depends-on.

Note this commit is for the networking fast path (interrupt context),
where we want to avoid unnecessary locking as much as possible.

AF_UNIX works in the process context only and does not
need to follow the pattern.


>
> However, it is safer to return -ECONNREFULED when sk_socket or file are
> NULL.
>
> I would be good to hear from netdev folks though.
>
> TIL, there is an LSM hook for sock_graft().
>
> > =E2=80=93G=C3=BCnther
> >
