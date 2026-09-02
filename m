Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020436212D
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372277; cv=none; b=SGoxQCkqJYItX3ktcadJY9whScVUGzLqF3xy6Kr6sZ+cK7UfjpZyT7TrYcBTrbPepu6t72ysR4+ffkcKjuM011o4p4LTDm8u8XY0j8Tym1IBMtFz+6cfabsVjpM3iNcpjlGgJZtnNu/+5yAhHsCckeqL1ChceoVSPjSBHiohvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372277; c=relaxed/simple;
	bh=CfTWnNxSJggP9yjaDpB3r0Rkf7dLaPcJdZaM28btY4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AESPnr7Frgqi3h7npgdeG7PYhjvl0in2d6Jvhjsr+g9+qRg5aciofA4ABbVXzfaw5sBmq4hWtiZpOufpfNG3NPBNX6d7/CgooHhK4Q93GolKp8m/EvYYIAf2ToCAiKCE4KE0NEIOAcjtreJbis4gCcUSaPHs0IkJSKZ/6h/EDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3L78KG+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3L78KG+"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a20367cf82so12768691fa.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788372274; x=1788977074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3eSWRBHdZ/8X2dHJRKHsprBiq+T7ne+lI7EooU3WQuw=;
        b=B3L78KG+10VwKobhvdswaiLwCwXYb1ntz6RluckkKfwFVp9wu2M4NJFZLnZsjkAkZ8
         iMOQP1jfXfFTSVJHI7/hxaa96UO/DUC4PthgKaVBOJvGE+a00GiyNPaHAdTNG6nU02ud
         wMs1YLtd7zK7JYZ7odwsOvkhJ3ErLaDuWcMn2g3I057J0d7C/+20Rdjm7vvFyPjDtnMy
         20AOyN6oTM2o+a3eqnQGL2CrFJSO4YATyuCcgaKWFKydhhH/xe9rPEbFC271rZrpQsFu
         WAjnyE3o9nn+un25yCjap4A27VpoJ2WPCk3JNIHFa47g6EavPSkJLGhHzigjguKLKJmJ
         io+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788372274; x=1788977074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3eSWRBHdZ/8X2dHJRKHsprBiq+T7ne+lI7EooU3WQuw=;
        b=av+qZCts1mSTVaNmvyRx/rSdXmsSeIxZbsS9xgUZFTq/N9RQVeBzBDorL9Bc5vIUcm
         swYdIQm5D5sYNcmwVr+3tgswKN64p4/WkAOmTsUxlomaXQnJsWSvk+sevf+mgVUeR64E
         E3Rx46xV1QQqbHgAHdA3a0WmWVcNeK1DMXy+ba4YJX9BQak2BuAtpIy43uoiFYl2Bni2
         2L8irbJ6SHah5Qp+RpRR4uhxSc+1S02V4s96CJEh2EOuwqi+h4oUJFsoFzwAgyG9Xcgf
         6K1u2Us+i/C1f4vXKx2VVXqIm86xJf48a5lr1IoS8B2hOER+kfYLeBxkkDUcFvglyFvu
         hisw==
X-Forwarded-Encrypted: i=1; AKwUvBycc54oyPUuAvHADuyVP49JpiPUlX66/G6pFUk+lbHKrsa7AEMRZ8sfeyB+ZCxOBOTGr1HzsnepRHVIj/0HJJv1RMEZi0c=@vger.kernel.org
X-Gm-Message-State: AFuF++krBikT/MFUjTz3hCs1yBm8UxgCNYgjgeIPraiZeCiNa4rgf99C
	VptfI4ixN2IoYqLStQXPBpYfe8r2bRARF8C0o4IUTIT6GYzZ5NS0yeZ+
X-Gm-Gg: AYBFou0Q+RtcD37sjH4z0cs3dERAoyo7m1nPCEPzIStvX7tAjlQupGivI8QdbhIe/t2
	QVK8ADGKpI+VHX4UTpjVFTOQLRVU6PGn6MQk0K1erhGytNG8P+18pgj8oEBkffIMVUzazek/4ad
	31q57+AXhd/3qzanvpxcn91FqyTJqlga79QV3HXrlNMS3C5kHQ9/p3PA56HPK6vLbGq4zVi6KIw
	RH6H6NbPGpJjaCSWhZ0HpSVZEr+L4EQMsgjFJOBMYonrY16PKXRRASGZ0ABchQ6UzbNGOJOatW6
	/iP7wzCv+rRrWl/unbZHK+jXtu/JZoxggkWG9EFxPZO/y9jMiwQmH0eKzyRdC/DU1pkjc0CuBe/
	8Oj3WDv4/R6GLQU3drcLn62AlAPQtVOcsgH7MNhsMVgTrk1ODerawwnMz0V8zNaMGgwWMjlZQEg
	AC/IyPAPHiUBFSKLSA/shcT/ODdG6+DhiKod59ULpP9iS+8qw2gyI3vAe3xBqNZuu3vNaUz0Yr9
	fSDUUqAz6+NnhO5HL0osdVgBXDIyQqn0mBd45vwlglIxWY0h/tmpPYZpxzgUze38qilDEQrcohH
	ZzRRu/Kl2qVvgnS56s9dVfhBosKwWgMWGgj2Ud8pkOkzHjgyd/6wwcqJV7OdZbssa0jzghIT4xy
	kNkwarJgkmQ==
X-Received: by 2002:a05:651c:a209:10b0:3a1:f671:b2ee with SMTP id 38308e7fff4ca-3a34fd283b7mr11486751fa.8.1788372273337;
        Wed, 02 Sep 2026 11:04:33 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a1c2-c401-11b2-c123-0d12-6c0f.310.pool.telefonica.de. [2a02:3100:a1c2:c401:11b2:c123:d12:6c0f])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a34ad2699bsm8235851fa.35.2026.09.02.11.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:04:32 -0700 (PDT)
Date: Wed, 2 Sep 2026 20:04:30 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] keys: finalize persistent keyring timeout after link
 attempt
Message-ID: <aphkt2PpqUFcTvun@gmail.com>
References: <20260901191743.39210-1-kmehltretter@gmail.com>
 <apdZKMddhZoASXmL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apdZKMddhZoASXmL@kernel.org>

On Wed, Sep 02, 2026 at 02:00:56AM +0100, Jarkko Sakkinen wrote:
> > +		*persistent_ref = find_key_to_update(reg_ref, index_key);
> > +		if (*persistent_ref)
> > +			return 1;
> 
> I'd return -ENOENT here instead and not make return value tristate.
> 

I don't think using an error to mean "found" is safe. keyring_alloc()
can return -ENOENT through security_key_alloc(). A BPF LSM key_alloc
hook can return any errno.

I checked this in QEMU with a BPF LSM hook returning -ENOENT.
keyring_alloc(".persistent_register") returned -ENOENT and
KEYCTL_GET_PERSISTENT failed with ENOENT.

So -ENOENT would be ambiguous. I also considered +EEXIST instead of 1,
but that seems a bit too clever. I'd rather keep 0/1/<0.

Thanks,
Karl
