Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B013815E2
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372501; cv=none; b=Yk4tU3Bfoc7yJmyb75CrPOyG36Jl61e7QZhcnOUX549CaPEg6YQ/+ZGPLRzvZerdM195Y9lSMAouyDh9veI2mp9Z6GE49cr1r65kNgl4Ljmdk7FGnB7SLXxC/40uRmILzK8p5MLS8grQVTLgwuGXG34FEjx9gIR3zpEDX6Fh6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372501; c=relaxed/simple;
	bh=M/J3JHrFSdmetG2sD42/PhVP5jz1OJWcqKv/6D2HPG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrDbGKBt2DHwBzBIz7P8+mP7Kmf9/DlStbfQrew/xmzJ8b+FWEuFY+08ePz7sPzQi0xiNX9byhxUk4I6u2hZTsedx4DX3MxhR0vi/Tw38jK81yI7hmqH0FMLCX4Erbq6GwVBaLRgMYCf+apn/TLq25BxOktj1aqsAZ9ijaPrz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyC3yZYZ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyC3yZYZ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so448812f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790372498; x=1790977298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFi4tcAEojQR1Y7C+MNFuQaV3e5c6j0d2XQ9TkcL7VI=;
        b=eyC3yZYZYSHCBM+fWVHuhOsjHXASN4QsVSDEMDMSD/q/vD38VwkTSjJkZ258EurkK8
         imOa7v7vaf1OJnyBmOt+KPacEJ+Xfo4rPM9BvsylJAX+eIFksyBBUK5r0apkb8E6Rtsk
         qdGL2f7+At6YsuTtZAkIsMxPMAxTWFZPo07TeSOr5iFlLcHzmLrq4re2aBGvAGHiyB3c
         w3nPhhgqgfLlOn4KXJ7RjAdF7hXrTNwrYQKLdrl1aaJ69n0/I7LkhwGXnnjP5Cg6Wkm6
         XspqTy5HA28BjkR6TePOa6x6asYi1DY3hzpIRa4cIW+j3c2BmOvxVN+srMXdnmbOuC6m
         8YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790372498; x=1790977298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFi4tcAEojQR1Y7C+MNFuQaV3e5c6j0d2XQ9TkcL7VI=;
        b=TgU379FPTsEHJZnxJT3kg0oonYO52aggQpzVMTiWlTw8JNEIOWbgxDY0w4+ZLt695T
         VaIdrku2uerbpJMfcqIl2n0LyYdNvrHpOFCpGIkD0xRVOAeiuMOf8Gr1QEgNozBs0FLC
         jax3+tPMzo+CtKUf3c96n6FDAn0yTD9a3ouJJxup6dxyvfD9f9LLOp4ZrBiZxvMD0BYc
         hNex3Y8eTPFBzfYxtoQOM0oFUBSGdfSbxh1pOVv1g8buocoq4Mz6U1Y/IE/9a/wjhUiK
         MvoChvNySuD79FBtrjXy3nCKRg4D/AEEo33qfa3c+XNuUYeT28NS7BSa1bwfrbkvZglc
         cjXg==
X-Forwarded-Encrypted: i=1; AKwUvBzsYxA4U7xlD0BgNFbmX73zep5t9UFgQUA+P5UpjNxjdT2x4Uh5uH68d68mQulw3jfBZgFuZgoB6X6ZaYlbWwdc5iXDYsc=@vger.kernel.org
X-Gm-Message-State: AFuF++nlr/bAMmm1SKu2qYf+HQjj4k+wNYlDyHWiuTTZI/2n1XCyARXs
	t1IPtyixBxehEYasGKiUPs3X1zqBW/BH2lQFOkfiPD5KhZLrjfhsGEmt
X-Gm-Gg: AYBFou0swa32EgBF1Fx44Bpmu4vZXVUKZ1SBL1BjXttDVvzBy/PGsiU8wti9p9q1Wuv
	Eqq8buJFeOIhQmLaJFMlRa+ClHEnJqpTx5VrM2z2XbdNaK9jXUJugXPESo3hWbQ3Jm75wbx5COC
	i37+SdZTTm8OL3EsM+DTc6lNwuHHWZdddx7s3xSQ02ISYQYo4xplE1LLtc2oCMqoEvFUVLslqx+
	pBuMmIWF2igNa1+zYMxc8WHcUQhm1IO1Oa6clvI2pSoJgMebGzlzNi/6jRE6duMLTvNv9/gxYlt
	PqLqM5Kna6DBIJN3ZGCKVTc/rWem42ht2a+EX9UVZ8WB9ciZOE54crWcNP0+a75aONaF9PlTZDj
	u4HQk1ffTbeFgTuJTtDV9uwj+2W+TeCOHIlCG1IknjadbqTQnbpbNPy0pVQQnseoSXUJvDfTKcA
	vIZhgeL8rvCGndfXG6hpfkMFZZWZ0o44rJPWsIbvIRKLNRVrOAoroii1dXkbakWS+pCilDaZTxf
	a7/gm4Q95klBzOC2kXgJnI4NewhbF4KiKaeaT+RGLIjIg==
X-Received: by 2002:a05:6000:2211:b0:485:8ea0:da8c with SMTP id ffacd0b85a97d-488716c6d66mr14287448f8f.16.1790372497585;
        Fri, 25 Sep 2026 14:41:37 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm9799121f8f.36.2026.09.25.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:41:36 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5ED3EDC0ADE; Fri, 25 Sep 2026 23:41:35 +0200 (CEST)
Date: Fri, 25 Sep 2026 23:41:35 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Aurelien Jarno <aurelien@aurel32.net>,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	1145111@bugs.debian.org
Subject: Re: [PATCH] apparmor: fix NULL ctx->peer derefs in unix socket ctx
 updates
Message-ID: <arbqj-wnv_fo3beH@eldamar.lan>
References: <20260824155822.9214-1-maxime.belair@canonical.com>
 <aoy4UAvUp4ZS0gnn@aurel32.net>
 <apXjIw4NK4okChLn@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apXjIw4NK4okChLn@aurel32.net>

Hi Maxime,

On Mon, Aug 31, 2026 at 10:25:07PM +0200, Aurelien Jarno wrote:
> Hi,
> 
> On 2026-08-24 23:32, Aurelien Jarno wrote:
> > Hi Maxime,
> > 
> > On 2026-08-24 17:58, Maxime Bélair wrote:
> > > aa_unix_file_perm lazily refreshes the AppArmor context cached on a unix
> > > socket. Two of the helpers it uses assume ctx->peer has already been set:
> > > 
> > > 	update_peer_ctx ->  l = aa_label_merge(old, label, GFP_ATOMIC);
> > > 	update_sk_ctx   ->  } else if (aa_label_is_subset(plabel, old)) {
> > > 
> > > where @old is ctx->peer. Neither aa_label_merge nor aa_label_is_subset
> > > allows NULL. So both fault on the aa_label->size load.
> > > 
> > >   BUG: kernel NULL pointer dereference, address: 000000000000004c
> > >   RIP: 0010:__aa_label_next_not_in_set+0xb/0xd0
> > >   Call Trace:
> > >    aa_label_is_subset+0x3f/0x70
> > >    aa_unix_file_perm+0x5e8/0x9d0
> > >    aa_file_perm+0x45a/0x550
> > >    apparmor_file_permission+0x44/0xb0
> > >    security_file_permission+0x40/0x100
> > >    rw_verify_area+0x56/0x180
> > >    vfs_write+0x7c/0x480
> > >    ksys_write+0xbf/0xf0
> > > 
> > > ctx->peer is only recorded for stream connections and socket pairs.
> > > unix_dgram_connect sets unix_peer(sk) without going through that path,
> > > so a connected AF_UNIX datagram socket has unix_peer(sk) set while
> > > ctx->peer is still NULL, and the first write that needs revalidation
> > > reaches the helpers above.
> > > 
> > > Both derefs date back to the Fixes: commit, but the update_sk_ctx() one
> > > was dormant until commit 4483efe4f215 ("apparmor: fix shadowing of plabel
> > > that prevents cache from being updated") stopped @plabel being shadowed,
> > > which is why bisecting the oops lands there.
> > > 
> > > A NULL @old just means no peer label has been recorded yet, so install
> > > the label directly instead of merging or comparing against it.
> > > 
> > > Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
> > > Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> > > Closes: https://bugs.debian.org/1145111
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
> > > ---
> > >  security/apparmor/af_unix.c | 20 ++++++++++++--------
> > >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > Thanks a lot for the quick patch. I confirm it fixes the issue I 
> > reported.
> > 
> > Tested-by: Aurelien Jarno <aurelien@aurel32.net>
> 
> Any news about this patch? The kernel oops can be triggered as a simple 
> user, so it would be nice to get it fixed relatively soon.

Any news here? As Aurelien has pointed out this can be relatively easy
triggered, so having a fix landing would be great.

Regards,
Salvatore
