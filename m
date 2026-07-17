Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EE35B632
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280198; cv=none; b=qss2JCLIXzCb+3acHM480CXlEzusq4qU/jMursTB1ruZTSqWN7aV93jNFR1NgHyVYN775D5eVqMoNYpEPCaUIrAqWTzfE9a3ofc1ewVPUTymyUDX8uQhzP2zCbOUbZMJgUoMtGONS8gbYTimPU15CjooyF+gNMkKcirT2KTf7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280198; c=relaxed/simple;
	bh=TUUPiRn3X9u5woFwug+FcOaJs3Zk+ocC28NbF1PfP0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYGqXuiVwEtoJILz+tUm/X5GjeRSuVahwESxPnGhUzp1NFL18unXGrTkrqjX+iif/SjG7kVvcFbBHdsrXJQtagCOKVnVLkhsNDbfF+W7PAntsPdTaCithS+E+Wq/CyZmzgGr0c6WBk396gvUaoddhcL1BgkeQAAaCCF7YS//Elo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YIOK0wcr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIOK0wcr"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495441b72ecso7918605e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784280195; x=1784884995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=skQjxKq8+RG5NBs9hYNfDsGmix96/nRQ0Aoe6mGrzsg=;
        b=YIOK0wcrupqTejcjmyaJY0ulvBAM6KsAIZCcGNAmFfu4ZQLPg0IUdevZpbcF4Sq7ly
         f6OxtTdztn1YTHB16ZVcuJf0MyHY3JgfhhQ1LkeSWh3TGd79wrScsvpdIKXzJWhx7IPp
         C3Fxv5iS3yL81thekLcnoXx4HoZTklDGjVm7uwiT8Xn5/gqsMxDhxiTjE6ATrohLD9Nf
         b+j7MwH2rH1Hc24VcckZAXlzth32lZz/WY7ny7F76ScZhzPtDpLg0jWsh/JtPX/psm4x
         bf8NsE5BXsoVSQs5RloeU2KGegL/MkFTj0LsxRPTjh6kKzd50Rk95iO0MjeiIiarVURL
         EyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784280195; x=1784884995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=skQjxKq8+RG5NBs9hYNfDsGmix96/nRQ0Aoe6mGrzsg=;
        b=AKq/mhb5GbQ05Z0/bm2+FxYd7FqeRERuguT+A1PNw1Ogft7ry3zXAeqV+xq7K61YZd
         zVnYUKsaboAGjr71dB4ufRZU47nU89liRnzzIlajGr7GSR48dy2HaBoqOPTUlfSqbXIL
         cYcuhY/I5KPhgFi/qeVM6Ablhii5FEzHtHivDUO7yJ2J7Fw7GYRzKB7zgiswaCs+tgm3
         F7Js4WKqaEgU+aFt3HLwEw91GVMe5P9FuS2/rrc1W1QBLKi2xF1HcDFAlhOuwtxX8d+G
         5/lS8ERcQkqEmqxxex2MJL+dCZdL9cxrO3En7dCZcz1d3bbpNdT14Uo/XLAFYF4+fq0Y
         HizA==
X-Forwarded-Encrypted: i=1; AHgh+RoQzWilE0IiBwh3ptgdHBinYK/LZVkdJJtAM0140D2ZaFWV6NG3DCeXCeSkSanUQIpi9CMBQNeXhnFQ19IqPx5A9x3DGnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslFRrpYbc26Q595zsYnwt8vBsOeWCPnuzsuGh/+TjOiFHUf5u
	0aDf6kG2tYofCEEoFNfHZbTfiln17hrQKdezRyaP2gGP3IL5r8NVqwd+aoLznRufmBFSWer1IgB
	5VvLt4aEi
X-Gm-Gg: AfdE7cl4E+SyHoW12c9dArhCNoHUDchSTGOI2ETWhUh3jczFXyVkCYpd8REDMMR8x6L
	R9rDLZwykpdAe6baupGnaRW4vSCv14xjzf1NEU0mVn3qe06d6C81dt9+ygAYz1/78UTu4Kqk/oC
	Vei/EBONLk6riSR6fuuJMvPZ1n8E1mlNf8ngSVdMMgFoJ2sQZY2yTn2PhBcxjh/5cdOIlyoIOC/
	O0toCvArM8p464Il1xWlLYavK0DJ1Z/eKc1FPW3KV1pGqw1sHewpZiFM70+/5e0Z3g6Fj4o856H
	4+0Ce5aKMSMzYEhUg3NnuphtAA7SGU7bTtLXd+fCb9HsPq/nlkoXAeXhm9/yDF/JFumvlxnTQC/
	ecKAyIHfirPeoy+/g0/gPABmuBOVt6Oew1YH8aBEeUV9EsbS8nVxoIwATxGpnYMCbhbgY8RwU9R
	8SYztywTEUK+HxUNZB5kOfpHb+/TZStv+EdNVfTTVjzaQ=
X-Received: by 2002:a7b:ce8c:0:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-4954a402f1emr15762205e9.25.1784280194231;
        Fri, 17 Jul 2026 02:23:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:a7ff:85a8:cc40:9943])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954c841a0dsm7324105e9.5.2026.07.17.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:23:13 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:23:08 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/3] landlock: Require
 LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
Message-ID: <aln0fPINrjf8vXkO@google.com>
References: <20260610092318.3868884-1-gnoack@google.com>
 <20260610092318.3868884-2-gnoack@google.com>
 <20260610.uoMee2quoo9k@digikod.net>
 <aivEo6bV_phFFJg5@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aivEo6bV_phFFJg5@google.com>

On Fri, Jun 12, 2026 at 10:34:43AM +0200, Günther Noack wrote:
> On Wed, Jun 10, 2026 at 03:38:56PM +0200, Mickaël Salaün wrote:
> > Making MAKE_CHAR not covering MAKE_WHITEOUT is not addressed (see
> > previous discussion).  MAKE_CHAR should not restrict whiteout creation
> > *if* MAKE_WHITEOUT is handled.
> 
> (This is option (3) from your reply to V1 [1].)
>         
> I am skeptical of this approach, because it complicates how userspace
> needs to deal with this access right.  Consider the following
> scenario: A program wants to install the policy:
> 
>  * DENY  MAKE_WHITEOUT, MAKE_CHAR
>  * ALLOW MAKE_WHITEOUT             in /foo  (path_beneath rule)
> 
> Then, if the kernel ABI predates make-whiteout, with the usual
> best-effort fallback (clearing out the unsupported bits), this ruleset
> becomes:
> 
>  * DENY  MAKE_CHAR
>  * (no ALLOW rule)
> 
> But this ruleset is incorrect, because it denies mknod("/foo/x",
> S_IFCHR | mode, makedev(0, 0)) in /foo, which was explicitly allowed
> in the earlier ruleset.
> 
> So in order to implement the best-effort fallback, I guess userspace
> libraries would now have to take into account whether there are any
> rules where MAKE_WHITEOUT is specifically allowed, and if so, they
> can't restrict MAKE_CHAR either?  I find this a bit complicated and I
> think it's foreseeable that library implementers will predominantly
> get this wrong.
> 
> 
> Let me circle back to the other options you mentioned in [1], quoting
> them here for reference:
> > I see four options:
> > 
> > 1. Consider whiteouts as regular files and make them handled by
> >    LANDLOCK_ACCESS_FS_MAKE_REG.  This would require an erratum and would
> >    make sense for direct mknod calls, but it would be weird for
> >    renameat2 calls than move a file and should only require
> >    LANDLOCK_ACCESS_FS_REMOVE_FILE from the user point of view.
> 
> It would be weird for renameat2 calls to require MAKE_REG in the
> source directory, but the weirdness would only affect
> fuse-overlayfs-style programs and could be documented explicitly for
> them for the case that they start using Landlock.
> 
> Normal programs that just call rename() on an existing FUSE-Overlayfs
> filesystem would *not* require the MAKE_REG right, because the FUSE
> process would do that on their behalf with the FUSE processes'
> credentials.
> 
> > 
> > 2. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right to handle whitout
> >    creation (direct and indirect?) and keep LANDLOCK_ACCESS_FS_MAKE_CHAR
> >    handle direct whiteout creation (and don't backport anything).  It
> >    looks inconsistent from an access control point of view.
> 
> MAKE_WHITEOUT to handle rename(RENAME_WHITEOUT) and MAKE_CHAR to
> handle mknod(chardev (0, 0)) -- This is a bit inconsistent, but it
> does not make a difference for any programs other than the ones
> calling rename(RENAME_WHITEOUT) (i.e., overlayfs-fuse), and it could
> be documented for that one use case.
> 
> I find this a pragmatic balance, and it does not require special logic
> for the best-effort fallback either.  Could you be persuaded to go
> this route instead?
> 
> > 3. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and, when handled,
> >    make LANDLOCK_ACCESS_FS_MAKE_CHAR not handle whiteout.  This would be
> >    a bit weird from a kernel point of view but it should work well for
> >    users while still forbidding direct whiteout creation.
> 
> Except for the best-effort fallback, which is IMHO prone to
> implementation bugs. (see above)
> 
> On the side, the implementation of this is also non-trivial: In order
> to check for mknod(..., makedev(0, 0)), we need to check
> layer-by-layer whether the layer handles MAKE_WHITEOUT and then either
> check for MAKE_CHAR or MAKE_WHITEOUT.
> 
> 
> > 4. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and make
> >    LANDLOCK_ACCESS_FS_MAKE_CHAR never handle whiteout (and backport
> >    MAKE_CHAR fix with an errata).  This would be consistent but backport
> >    a way to directly create whiteouts (e.g. with mknod).
> 
> It's mostly theoretical, but lifting the mknod(chardev (0,0))
> restriction for normal mknod() calls and calling it an erratum seems
> surprising as well, because it would relax security guarantees for
> existing programs.
> 
> I also pondered the alternative of creating an erratum but
> intentionally *not* backporting it, but even in that case, that
> surprising erratum still affects older programs which are deployed on
> newer kernels.
> 
> 
> Revisiting this discussion, I'd lean towards option 1 or 2 -- could
> you be persuaded towards one of these?

Friendly ping, Mickaël; I would like to have some feedback on this approach
before sending v4.  Could you please have a look?

Thanks,
—Günther


> I have a slight preference for option 1 (using MAKE_REG) because it
> would be a narrow fix that could be backported to older kernels as
> well and would not require a new access right.  Given that the use
> case for RENAME_WHITEOUT is really only for FUSE-OverlayFS and given
> that FUSE-OverlayFS anyway needs MAKE_REG permissions there, I have
> trouble imagining a scenario where a separate access right for
> MAKE_WHITEOUT is needed in a policy.  It seems like a pragmatic
> choice.
> 
> 
> > Specific tests should check that all
> > these cases are proprely handled.
> >
> > There is no documentation update related to the new feature.  A note
> > should also explain what exactly is a whiteout and why it is not
> > considered a character device (see previous discussions).
> > 
> > The sandboxer is not updated.
> > 
> > There is no audit tests.
> 
> Acknowledged, these were missing.
> 
> (I was initially hoping that this bug report wouldn't expand into a
> full-fledged feature with its own access right constant, but it is
> correct that this is all required in that case... :-/)
> 
> Will add this for the next patch set revision if it is still needed.
> 
> —Günther
> 
> [1] https://lore.kernel.org/all/20260414.Lae5ida1eeGh@digikod.net/

