Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D725A33F
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598020; cv=none; b=Tk5XbaZV66HVJU+ShFGUrh/3xPi6li8wuXozEvdKkY9Xia7GI8eNhDgbJoIwNdOAkYxduih/HxtGtt29V0QqbVRHxWqVbOmHr9mc5L0XDwzGVw2TW5Fthf+Hkkk/DffA8j1KFzOnEK4kQTYT6vEQIT2LgpHkzOkOWKwvVs9+44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598020; c=relaxed/simple;
	bh=rVkz6sHF986z0XZQ2cKvKo2YWx6T/si/8ZuZ+swxx24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdulX2oCrptkB3oWKEp2/oSrqQWQ/QufhRVTho8mFDj8aNAeWHtchYuAIA5w4oSAv8gb6/s8DpTDTR1dVfEyzTXJUs4UickTz6xrKPPjVeTueQx/oybaFxnyajohMr1236GhgOiRlujHfTdGwTMCm2YSZd2VWiOmRueZE+TMh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvSvNZOO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvSvNZOO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48378136adcso13155525e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 06:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771598018; x=1772202818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3wmaobUkN/MnYDLdxdhgiqD5NjcLC5gKmAWth3AX4Y=;
        b=TvSvNZOO0ONDhgEBK+tNDp2ogv3l/XyhZXSYiDuNKDdI3bdF6skAl5upU8jmhoGnEg
         ax3pbwoMGS1wVqing9AfGifY2OwlzdFqv4b1YmSpYNpJ53r8UMYI7mxgIBkNnymCFehW
         nHfKMN6XA1BUsksWEgyE2aKx5onNrnNHp7WJFfWYKxY5qvP+HxE28Ewu+GpAxsWrXZEZ
         xOmBTqc7mshYNy56DFfsQdTXBA1kMnc9C6NmKAoHE/x4cl/dZZUOtWO3cz31NacbWvm5
         30CxxjxT7T4yfZ3ZwUYx0ofRObzoF3UPtcGbIEqbXKt9PGhhkExVjUCwypcHF5/t8v2X
         X88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771598018; x=1772202818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3wmaobUkN/MnYDLdxdhgiqD5NjcLC5gKmAWth3AX4Y=;
        b=FhYKfLnsZKqoO5Z9J3MhWRje+nNAADiCoQmwSeaZSllGHSmIxFhk3B8W8+VANIMG3H
         Qr2GTR7y3FVAjASooAQ2JRXTVQNWqeKKmWvD+u6GqMbW84h+9pmRZ6ud0q8Xz6VTVUS3
         2eK8O20Lm0eRfYHsNpdHnSbFBPBFYJonk4GIRDWCsByb2aDCBGKUErrxCsCrRWU0X1Fx
         078GH/wSAiZEQJk1bWdEydMXGd4T+wHbpkfJFvmmUngOpc3mMRKb/9y8DeylKnRqBskv
         Kp+AHkFmoFC+vfqJCDdpKfMsyzpCQUv80rgP5g9v3eUBDVE6GIO6xRUkoH7QZWGOjBQK
         31yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzY/1UQxrit4T1W4KNxHsLoISx2wHDiJ7R1ZvNbk/oGswj2H0jazGQD6+EFYdtIANLnsWygMw6LFh9iF2NlrOj+G23dQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyjz9WS9S5ohm2tJRiwPPAgl1MumtpdpI4vplkApUcteXuaVDL
	Fbn2zKi3pqTonKkZcAb2xC5gWHpNITFB4WoNtyo/Bkdkrf1AR+zFXR/u
X-Gm-Gg: AZuq6aL0GeXC3Ran2HR8yjoi05Mi/kCqnMsKl5oftmntxCb3XGHsF6m1Cn20WfInDy8
	SlmaEQODdsvPKNWeFKZcXZB6RP6BDsQDgENqN98BuaXv1kLPADAfksb9Gm9oGpfPwbkyE75APUz
	N3hTGRCTutvsU83iFaqcXwWgkIZgpjiG4Mb9mcpk6C6rQfMLqaJoD3T0QnuZ+EfK5FkSaP1qtpD
	ALlEvLrIT9khmlNLbgCig48rYKfxrtrOJOIBg0moAZHneEekCINkPiKuFJJLYk4Q/JK7a/MkpPF
	N+FEHnQ5JoBhJkjCf1YMN5CaAHHocFvCZFvSfUo72s1dgXrBj6uQjSzN5cgvAWy7NSsX/A1LhRV
	uCIv1h8rfqhdXqD8G3x0BnqaowjQnrWpTwNnGF1rNvchmThmmHFp6oanRr1byi0+VUyy4+GqolK
	+eGz72ORV29wVdPXMThshxqEDg5uAwXBbsPPqLLex427qHj8AxyNy64ORaPCA=
X-Received: by 2002:a05:600c:1c07:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-48379bac86bmr428396225e9.5.1771598017198;
        Fri, 20 Feb 2026 06:33:37 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad009bsm54786919f8f.39.2026.02.20.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:33:36 -0800 (PST)
Date: Fri, 20 Feb 2026 15:33:28 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260220.82a8adda6f95@gnoack.org>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260217.lievaS8eeng8@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217.lievaS8eeng8@digikod.net>

+netdev, we could use some advice on the locking approach in af_unix (see below)

On Wed, Feb 18, 2026 at 10:37:14AM +0100, Mickaël Salaün wrote:
> On Sun, Feb 15, 2026 at 11:51:50AM +0100, Günther Noack wrote:
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index f88fa1f68b77..3a8fc3af0d64 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -248,6 +248,15 @@ struct landlock_net_port_attr {
> >   *
> >   *   This access right is available since the fifth version of the Landlock
> >   *   ABI.
> > + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domain sockets
> > + *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts both calls to
> > + *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
> > + *   explicit recipient address.
> > + *
> > + *   This access right only applies to connections to UNIX server sockets which
> > + *   were created outside of the newly created Landlock domain (e.g. from within
> > + *   a parent domain or from an unrestricted process).  Newly created UNIX
> > + *   servers within the same Landlock domain continue to be accessible.
> 
> It might help to add a reference to the explicit scope mechanism.
> 
> Please squash patch 9/9 into this one and also add a reference here to
> the rationale described in security/landlock.rst

Sounds good, will do.


> > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > +				 const struct landlock_ruleset *const server,
> > +				 struct layer_access_masks *const masks,
> > +				 const access_mask_t access)
> 
> This helper should be moved to task.c and factored out with
> domain_is_scoped().  This should be a dedicated patch.

(already discussed in another follow-up mail)


> > +static int hook_unix_find(const struct path *const path, struct sock *other,
> > +			  int flags)
> > +{
> > +	const struct landlock_ruleset *dom_other;
> > +	const struct landlock_cred_security *subject;
> > +	struct layer_access_masks layer_masks;
> > +	struct landlock_request request = {};
> > +	static const struct access_masks fs_resolve_unix = {
> > +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> > +	};
> > +
> > +	/* Lookup for the purpose of saving coredumps is OK. */
> > +	if (unlikely(flags & SOCK_COREDUMP))
> > +		return 0;
> > +
> > +	/* Access to the same (or a lower) domain is always allowed. */
> > +	subject = landlock_get_applicable_subject(current_cred(),
> > +						  fs_resolve_unix, NULL);
> > +
> > +	if (!subject)
> > +		return 0;
> > +
> > +	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
> > +				       &layer_masks, LANDLOCK_KEY_INODE))
> > +		return 0;
> > +
> > +	/* Checks the layers in which we are connecting within the same domain. */
> > +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> 
> We need to call unix_state_lock(other) before reading it, and check for
> SOCK_DEAD, and check sk_socket before dereferencing it.  Indeed,
> the socket can be make orphan (see unix_dgram_sendmsg and
> unix_stream_connect).  I *think* a socket cannot be "resurrected" or
> recycled once dead, so we may assume there is no race condition wrt
> dom_other, but please double check.  This lockless call should be made
> clear in the LSM hook.  It's OK to not lock the socket before
> security_unix_find() (1) because no LSM might implement and (2) they
> might not need to lock the socket (e.g. if the caller is not sandboxed).
> 
> The updated code should look something like this:
> 
> unix_state_unlock(other);
> if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket)) {
> 	unix_state_unlock(other);
> 	return 0;
> }
> 
> dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> unix_state_unlock(other);

Thank you for spotting the locking concern!

@anyone from netdev, could you please advise on the correct locking
approach here?

* Do we need ot check SOCK_DEAD?

  You are saying that we need to do that, but it's not clear to me
  why.

  If you look at the places where unix_find_other() is called in
  af_unix.c, then you'll find that all of them check for SOCK_DEAD and
  then restart from unix_find_other() if they do actually discover
  that the socket is dead.  I think that this is catching this race
  condition scenario:

  * a server socket exists and is alive
  * A client connects: af_unix.c's unix_stream_connect() calls
    unix_find_other() and finds the server socket...
  * (Concurrently): The server closes the socket and enters
    unix_release_sock().  This function:
    1. disassociates the server sock from the named socket inode
       number in the hash table (=> future unix_find_other() calls
       will fail).
    2. calls sock_orphan(), which sets SOCK_DEAD.
  * ...(client connection resuming): unix_stream_connect() continues,
    grabs the unix_state_lock(), which apparently protects everything
    here, checks that the socket is not dead - and discovers that it
    IS suddenly dead.  This was not supposed to happen.  The code
    recovers from that by retrying everything starting with the
    unix_find_other() call.  From unix_release_sock(), we know that
    the inode is not associated with the sock any more -- so the
    unix_find_socket_by_inode() call should be failing on the next
    attempt.

  (This works with unix_dgram_connect() and unix_dgram_sendmsg() as
  well.)

  The comments next to the SOCK_DEAD checks are also suggesting this.

* What lock to use

  I am having trouble reasoning about what lock is used for what in
  this code.
  
  Is it possible that the lock protecting ->sk_socket is the
  ->sk_callback_lock, not the unix_state_lock()?  The only callers to
  sk_set_socket are either sock_orphan/sock_graft (both grabbing
  sk_callback_lock), or they are creating new struct sock objects that
  they own exclusively, and don't need locks yet.

  Admittedly, in af_unix.c, sock_orphan() and sock_graft() only get
  called in contexts where the unix_state_lock() is held, so it would
  probably work as well to lock that, but it is maybe a more
  fine-grained approach to use sk_callback_lock?


So... how about a scheme where we only check for ->sk_socket not being
NULL:

read_lock_bh(&other->sk_callback_lock);
struct sock *other_sk = other->sk_socket;
if (!other_sk) {
	read_unlock_bh(&other->sk_callback_lock);
	return 0;
}
/* XXX double check whether we need a lock here too */
struct file *file = other_sk->file;
if (!other_file) {
	read_unlock_bh(&other->sk_callback_lock);
	return 0;
}
read_unlock_bh(&other->sk_callback_lock);

If this fails, that would in my understanding also be because the
socket has died after the path lookup.  We'd then return 0 (success),
because we know that the surrounding SOCK_DEAD logic will repeat
everything starting from the path lookup operation (this time likely
failing with ECONNREFUSED, but maybe also with a success, if another
server process was quick enough).

Does this sound reasonable?
–Günther
