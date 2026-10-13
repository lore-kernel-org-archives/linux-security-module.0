Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D53D52FE41
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914411; cv=none; b=l61wJAMRMt276zTgUA2GKgES2sO6fLHvePywd1521YvwxisMqxbtS641kiWGz2p+8uPrZ+5DMwIEW6EontOOZTU0OMvR71H2d+dYhl6qOme8dWD86CqkqGvaXxOpszZobfaCiMuIEG0U/QyVTPOkH3P5UloERFytDHmGanC/T6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914411; c=relaxed/simple;
	bh=nbgDcnVzZy5v+9x+VotHTcVXQOcWBOh+8O66h1RlO+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDNOuqCqrM5ug2SIu3hmmd6erbdZ8V/ncSkCexWnsVrpn/UpDoIjon3q+BUpBS/ORybeN7g4AeAh86eCjfXL0mJ6xUBPUbgNYTlToE1Owz4lX+2YSjTGme8ZKtdxNE1t8PYT9g9B3YHz6EXIgSeewSAHLiipb03o0hNh/nsnp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcPYw60J; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcPYw60J"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6711f05fb14so2720527d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791914409; x=1792519209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h9AuHP9q1EYZ5Uls4Fabp/S6p+sv4isxWlypix7WhUQ=;
        b=TcPYw60Jtk6AN25tEvsZ3pxax7kG6kayqFOCcgmW+fG656FYBqGsAt8GO1ZZn+y+Ad
         7MYlKwl7FM9Xe8tG9FcchXmRRHUrePQa9w1eflYjm6DDgZoch2R782GPkvR7CuHgogjx
         C2lekm4YQBoujenBwsIwuUKj9g7EVRuvbNG845IhNB0u3S1hadoUmCtaUZ92EbA2tshj
         w7ujfd/pEPgEhNkHv8nuDtov24LQPBDCemzBsbDizZy+doMq8iyzG/4AtBBdAtpNrKtA
         GDkAioCy/j7duh9tOEE5yojPpAHiLewzNacRqtZxDLDWR5FM8FrJV9gD3+05oSG4TLes
         MxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914409; x=1792519209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h9AuHP9q1EYZ5Uls4Fabp/S6p+sv4isxWlypix7WhUQ=;
        b=r4WUl20feb6H8jYCegPFU0ZLkWuAc3tMvY2UXSmB9Tc4hrn1DKhfogET9gR+9LDzOa
         I2cDfFahyPIf7WashCpf6g4dM6DX3o+plTRaq1dSvxlDMTN8Q8dYw2qi0iWXIXFaNKxI
         GhtkJ92/hS+MfHrkaZacFW3OrppA8uhrIG0uEHvPu/FkHS6FHVkTxP7arne1QKgSs4R4
         k/jfx2SZ8YVz2juLx3/rt+Uz3Kb5bfwrcWHnVdShYP8aioXpn7FWAYHcxGmez4zn4W2v
         QGj+t9TDVaUnG743I+zTEmXHumZhlJIlOR12zXiC192cwsix7jHp/L8NQmW9dKQmcwRO
         3iSw==
X-Forwarded-Encrypted: i=1; AKwUvBxtgW4keIpuf/7jYzPwxzPcUrS3/a6JR2n6uReV+b2p9EnLxtDMwLH4AN4/qI14wkgHoPsz4SJGMaojVkwoyLnjCB4Db2g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJefupzSaExdVGkIMzCs+xF7Je4hyk+AMGKDA4jbDs7/KHdvu/4
	HdIyWKFBnnjbd0y3P7Aq/NbWpo+Q7cyHIcXLOckImRN5/VMXg5jejhOrg7VR0g==
X-Gm-Gg: AYBFou3cc0mF88OqeOKy5cSMSslWxLL63ZKJPaavOUnWV4RdGoSSJ3Ua2cjOC2Hbxq0
	kYZ5Mh/T6CR+h59avFsT2nezxmlXzWD/eqMydwlQbSCS7j2BhWwW1HOWAkkA+XfGFAnOarvmAeY
	X3/TK/7/GDKrXiVhm1BMLnOf2LhtkqMUFUoGEkvh9EcLkob0XWDGRgQvDJ9b/9B1QFDID1FJzsW
	0xUhhOiJ/YdjpFw5JSly6XiKfN/uasfYMfyo9GjgE7TqWSj5b6xW9q3oD27PdDwTwiG0cFe3w3W
	BXMqMjLd45BMmvioi+t3LQkryKo6G1aZlatFPhcTDgbn8Coi4r0CFkXv1avSKz3xqlkL/O18B6D
	1vhZmHbz4uTul7KKIDqknRZJRHTzRcOFtDeBq2YNA43VFvn4jnVlC2EUr9CPKAww7yn9GDCUhx5
	lGx1Ij29Dnb1NZp6QCDlTTAK91WrwgaPe/k/u5KKZjSmeKlxmPTlGThRQ6QV2k/Tb2vSmCh1g=
X-Received: by 2002:a05:690e:1183:b0:672:ede8:d1f4 with SMTP id 956f58d0204a3-67936062f7cmr4971148d50.62.1791914409230;
        Tue, 13 Oct 2026 11:00:09 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a15c13sm145635d50.7.2026.10.13.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:00:08 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:00:07 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 05/11] bpf: add a path ancestor iterator
Message-ID: <as5w8lY-3Z6sVlxe@zenbox>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-6-utilityemal77@gmail.com>
 <sashiko-outbox-170194@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170194@kernel.org>

On Tue, Oct 13, 2026 at 05:11:54PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: deadlock in bpf_iter_path_ancestors_next due to GFP_KERNEL under VFS locks
> --
> 
> commit 0d24b2f0561971ff2a9d89456692d9ec1ea13279
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> bpf: add a path ancestor iterator
> 
> This commit introduces a sleepable BPF iterator for evaluating a path's
> ancestry using the stepwise vfs_walk_ancestors() engine. It adds kfuncs
> to manage the iterator and hands each position to the program as an
> acquired reference by allocating a copy of the path structure.
> 
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 08f0847c49708..02398f5a46d5a 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> [ ... ]
> > +__bpf_kfunc struct path *
> > +bpf_iter_path_ancestors_next(struct bpf_iter_path_ancestors *it)
> > +{
> > +	struct bpf_path_ancestors_kern *kit = (void *)it;
> > +	struct path *pos = bpf_path_ancestors_step(kit);
> > +	struct path *held;
> > +
> > +	if (!pos)
> > +		return NULL;
> > +	/*
> > +	 * The position must outlive the walk's own view of it, so it gets a
> > +	 * reference and a struct path of its own to live in: struct path is
> > +	 * a value type, with nothing a BPF reference could be taken on
> > +	 * otherwise.  Sleepable, so no atomic allocation.
> > +	 */
> > +	held = kmalloc_obj(*held);
> 
> [Severity: High]
> Can this allocation cause a deadlock if the iterator is used from a sleepable
> LSM hook?
> 
> If a sleepable BPF LSM program is attached to a hook like
> security_inode_setattr or security_inode_unlink, it is called by the VFS
> with the inode's i_rwsem held. 
> 
> The kmalloc_obj() macro appears to default to GFP_KERNEL allocations, which
> includes the __GFP_FS flag. Under memory pressure, this could trigger direct
> memory reclaim.
> 
> If reclaim attempts to write back dirty pages or shrink the dcache/icache,
> it might try to acquire the same i_rwsem, resulting in a deadlock.
>
Direct reclaim never takes i_rwsem. So this is incorrect.

(Also if that were the case, the mkdir selftest would splat with lockdep)

Justin
> > +	if (!held) {
> > +		kit->step = -ENOMEM;
> > +		return NULL;
> > +	}
> > +	*held = *pos;
> > +	path_get(held);
> > +	return held;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261013164800.2906577-1-utilityemal77@gmail.com?part=5
