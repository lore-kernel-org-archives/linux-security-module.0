Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD73E4C96
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553379; cv=none; b=Us3yRtetMFCdqvqXScKNLXwwrnM1U/oVsLtesA/bhMmpXuU1691nTsbgYsE+ky1wMArEYdUnMeyg9GvLzoOHQLNYkhjsJ+49DrlKnWo8QT2QtMnPyWm17eXq2vpT2l+ngR4Q4eR+tk9cemekSeZ8pe0i+uZ+PoSPbrvL+wxC5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553379; c=relaxed/simple;
	bh=Fq9KG8uTcVdTd+UsYhiSxgn7mOXWFWafpBMc5Lbpa64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elRW7LmcSxakDv6QevzBbZNrOWP3ZNwbYVmxBBMVCJgVZUJdLYf7cBlCr+rjbCxFIgSuAbf+i+26x47uTXmL4S50beR7A5FG2TLWmTKdhcj7GV8PtuaT/hs9azTCbGC4aySU6RTfCyRtYUEQQjtCiWQgqN3ZB0ixyGgB9mun7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRsAcduN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRsAcduN"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so7404110a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787553376; x=1788158176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPZO/1T9gBfq+o/FMkeYUT9TJ0VTxgJ6DjM2Lc014mU=;
        b=eRsAcduN1f3oeqENjiwPxmNfEyZgG6NPFKHG2zmv50JNQKWA5FCUiebKcLj6T1ZqY9
         sW8ycnUnWb4omZ5aK+GATeSTPSBxlhVL1IBNH2gGBtfuKIMty4eijtLf0/8e3U128oi5
         l/8MLhbP9iaattCw4B3elrtWYwuuVsVQpxaNd9JJEw/P4ZAj6UbAgbSVbDIYrnddvZxK
         mwrrBgpmV3ETQXPAfQuv2r4Qg19aksfwEoCNjYOfs5p/mZqMMXanFZwOco71nJmSRIl7
         QzwFA8jcRH0+NRIHiTkknXrj2v/H6cx+3fau+FpQtTBY9nT/9iFtF2MQo2iq6KYDuQTs
         1QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553376; x=1788158176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZPZO/1T9gBfq+o/FMkeYUT9TJ0VTxgJ6DjM2Lc014mU=;
        b=tFqfPJ2AWD+WGSO59rBCeRgRtEwlBrIfCEBszn5isrgulQBQAwZ1IXrL4p5PyuNK9A
         VbI2DAXxKvaasLeVm0bF2FNQz3G50wEeMJWseKewtHUg/M5Yhfey1B2v6dE5+yo3ZyE3
         dPInWAPcsEYey9AdSy4tSUAkNDMfOA4ebYlqD4430CVDnot9aFyHIUpokjz61+hvIM9F
         Ie6mz2BtfEXOMzdZVO9d+qYtkHo9+8+gy4d/Ah/xB6o3VFMU1XOUxMu4OD/nuQMPvfnu
         tppXk+0E8Ev7cYh2FQOpEEx1PtbTapDTHkkR6kdKS6eIQNPadg1JGcj/XYzUXmLRlCsn
         b6Eg==
X-Forwarded-Encrypted: i=1; AHgh+RrJdcnAkIzPhMG7HtP6nWfSEJVqfYWVDt2vXv15vLtxekOysPsl5fMvA9LiZPHntM21/pJXntiEfNEKohrnxVh1Z21LhZY=@vger.kernel.org
X-Gm-Message-State: AFuF++l2cnX/sDuhObMlz1SMygO49CWmR9rbq0wzX9r70gjM91HfZWWC
	Kn6/Wk67NmtG1xy/b769oaE343kJor7b8X4gvzJQ6qFd1t8Pg1iHi5spcTv2SIFc
X-Gm-Gg: AR+sD11YPzaOTWU/ibYDdi/bIpwnSZtGViEBRT+gApN+pU7YLklJNqqAuno6Tf7Ie4o
	RtB4BBqcNXfC+FHqYByKpi/9XVcPqeD/aD/4faYcgzSfqPWZVqwHPkN4ulNHnJqrt27zuiR/sj9
	Rcq/xSUtaQrof3YeDjxkLqwkdaKLoIzRAMRItiCbQYw/CaCimMScePzHJZx2HVWasDEd2LplYNN
	/3U0oiNfK9u1/jNTNQm9d7/xW9QXFcfrmSesxBAFed/yV4ScPFGO1416boCWCFgkRlH0tAad+ib
	Dwg7NRqDsKa8/acwsU2lQ4ZWCZgQlf7qXUQytexzpbUEFoa9C8cEPgU+Am9lxMfnf0iv4Nsy/EJ
	Q4AAKQ0DcshClxThB1eF9faSfDXD6iXdaLZwtUMQbMPgb9z8iyD0Za3WuZrEx8gvG64bOAqJwfK
	h65m14WKSswGLWcceabWiLsrp0MJRkqRpzPQIwrEPvUIrzjCrUa0ADBWOsVQeE1Cc2d1XXUDvwI
	w2n2TxbW/9z9Q==
X-Received: by 2002:a17:907:3e89:b0:c21:7c98:d9ec with SMTP id a640c23a62f3a-c244d6349a2mr2907421166b.5.1787553375916;
        Sun, 23 Aug 2026 23:36:15 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1210893166b.46.2026.08.23.23.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 23:36:15 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:36:10 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message
 queues
Message-ID: <20260824.abc934a59c55@gnoack.org>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260822.c9dcabf4999f@gnoack.org>
 <20260822.3340c3dd2a46@gnoack.org>
 <aooS2VVhwWjY7ugo@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aooS2VVhwWjY7ugo@zenbox>

On Sat, Aug 22, 2026 at 05:51:33PM -0400, Justin Suess wrote:
> On Sat, Aug 22, 2026 at 11:13:44PM +0200, Günther Noack wrote:
> > On Sat, Aug 22, 2026 at 07:26:33PM +0200, Günther Noack wrote:
> > > I get the impression that with this scheme it would be possible for a
> > > landlocked process to guess the key of a set of programs which have
> > > not created their message queue yet, so that these would then start
> > > communicating on that message queue which the sandboxed process has
> > > access to.
> > 
> > I realized I did maybe not express that clearly enough: Not only would
> > the landlocked process guess the right key, but it would then also
> > *create* the queue msgget(key, IPC_CREAT|mode).
> > 
> > There apparently is a pattern in real-world software where the program
> > creates the message queue on the fly if it doesn't exist yet, but uses
> > the existing queue if it does.  Such software is then prone to reuse
> > the message queue that was created by the landlocked process.  (You
> > can find such programs using the Debian code search query from the
> > parent mail.)
> > 
> > Step 1: Landlocked program creates message queue.
> >         Because it creates the queue, it has access to it.
> > 
> > Step 2: Program outside of that domain runs, trying to use the message
> >         queue.  It discovers that the queue already exists and starts
> >         using it.
> > 
> > Step 3: Landlocked program can read and write the queue and manipulate
> >         it.
> > 
> I do agree. It's a little harder than unix sockets where we can control
> things at the client/server level (no such construct exists for sysv)
> 
> It's a little bit tricky. I suppose the easiest way to handle it would
> be to deny the ability to squat in a key in the first place. (deny msgget
> except with IPC_PRIVATE).
> 
> This comes with a cost in functionality, but it is easy to implement and
> closes the gap.

Agreed.  I am personally leaning on the side of closing the gap as
well, even if it reduces functionality somewhat.  SystemV Message
Queues are used very seldomly (as can be seen in Debian Code Search)
and it would affect few programs.

Possible Allow-listing variant
------------------------------

Another possibility that occurred to me after writing the last mail:
One option we could also take here might be to *combine* the scoped
approach and a allow-listing approach, as we have also done it for
named Unix sockets.

In this case that could mean that you would be able to allow-list a
*key*, and then for a msgsnd/msgrcv/msgctl queue operation to be
allowed, it would require that either of these two conditions is
fulfilled:

1. The queue was created in the same Landlock scope (only for IPC_PRIVATE), OR
2. The queue is associated with an allow-listed key

Condition 2 is easy to check because the kernel already tracks the
queue<->key association in struct kern_ipc_perm.

Advantages and Disadvantages:

* It would permit to connect outwards of the scope for allow-listed keys,
  but only within the limits of what the sandbox policy permits.

* For keys generated on the fly as with ftok(), these keys are hard to
  predict up front. (Would have to enforce the policy *after*
  calculating ftok().)

---

Given the limited number of programs that use SystemV message queues
at all, I am unsure whether it is needed to implement that.  But maybe
it would be an interesting thing to keep in mind so that we keep such
an option open in the implementation?  It would at least not rule out
the possibility of restricting SysV message queues in a finer-grained
way.

Let me know what you think.

–Günther
