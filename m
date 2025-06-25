Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A819F40A
	for <linux-security-module@vger.kernel.org>; Wed, 25 Jun 2025 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817282; cv=none; b=e1L4uALliNJVgcol8S5nbDAPGwnJ7Op6+5zaxPlF1IZGqhCXrVEAPj+0QfoEP9lMu2fcHq7kEFvdHeI2IIsv02whg3fpl8A6eusMVWgWKCKiNRWpQOI9RwoLOY4cAMtVmKqVf6dtbVMt9aFsS4ZCITN/wDakTVoPYUhNHVA/4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817282; c=relaxed/simple;
	bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4Us2o/fiSF6KYfR4T1925DAugqnXaW13ve/gbkb7Ii8RqnSwUDKes/LR8U0U1l7LYaL8+vYZZ5egaOUUTGmhkkHkjIqF21K87pzuskw9M4khqhfhdZ7LVh/J/R9wVUo0mbGPDlnDdA9xV/wMhwcz36kjU5z07IZgpyn108Cqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aCu1mQrG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aCu1mQrG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70f147b5a52so46145157b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 19:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750817279; x=1751422079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
        b=aCu1mQrGTrvIeygS6AxuH3K2HUUERSjtj4eyshr4PdYU6DEjweIS7AdEeHfW1Rcfel
         NzeRw2llw+41r9aAyX6jQRlJpPuhGc9sX4bkMJN3PSq2wfUCwbs9/Sfy9QKgaT12ha03
         6eVU3bguO6Oll/5C8Zc3gWxSDRWuxI81r/P0rJIf8bzeIDoD7RRNonjonehOKpNxZIWb
         TLwJ3TCmVAq0byBuFhWj6bmtN21IdogFWjn8bFYiKQrK4LKfulmn0VjJan/YV4SXESDz
         WLJkmX+lcN767Pf7KkeamVsL8jo5j0UVsCVOCDita6KOGOnQEVG6qgNkEROglhWh6vwp
         CpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750817279; x=1751422079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
        b=C8deyHUFooMjafTunByOBmy8t3J49EPnJsT3aJLcty/TXve956RccbIjFScs09rcKp
         04y+ETIOc8BFnewg6lLWw+D4CM5ymU3XSNtABYbpZEmXI4+/SYxIJapW9x/JOluZQsVa
         zle+1yWAUR1Cn/hJIeeQHBQ5zcTW2CxBJ9k/KwblhVb9cZVeCxExGIfs1b+JNbVuJt6d
         ftVRypLolAdxaaogUXb129e+D2vMNkPLojHMAFKsxkUfG8rUq9YDNRp+VSpZWMXk30CB
         Vn5fvq123RSzucWKe1LJoOWjuUmxpr29EhsPG5gJQ2mZoPwOQI3PqkzrtVCUU7PkMHSf
         Fr6w==
X-Gm-Message-State: AOJu0YxP47BVFIm3viNMnSlgkJ1XGQCJReuTypWupFZt8lQx9dnj0dkp
	gWBJxpooxFQuzh763fcvO4VDx2NkspRvCRlxZiiEqcb4X0r/ZBMXp+2PAznUUjKlkgtjyaCsTDU
	dbxuiBR35G1SXdmSMgTBojX3S7zrxAnqa1zYuANKt
X-Gm-Gg: ASbGnctw28//h6FlqYdzBUk62G3XOhVGSeqNunEDVUjVcYDpd0yp5FWj7LQpmrxJA3M
	m0F8ondiNBCqwgspCklU6k+yamtjMNLMf2NW2D08hmQDv4ZwpGqrhJorfmzdT9qCXzwGC9LoEb2
	bYAuubyYCKIHBw/ob/YsW6bghYE+qeFJkn4SiA4cTzAdk=
X-Google-Smtp-Source: AGHT+IGlJ3+t50Dx73mM8Air5bfcWg1IIPvwg/Vg5HkXBBKOKiLaOFTVUfjQ8shi4PBm0CiACEhKPb3fm1gsyHDeyKc=
X-Received: by 2002:a05:690c:3693:b0:70c:90af:154 with SMTP id
 00721157ae682-71406dd05f1mr17609477b3.20.1750817279444; Tue, 24 Jun 2025
 19:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612030951.GC1647736@ZenIV> <20250625014709.GQ1880847@ZenIV>
In-Reply-To: <20250625014709.GQ1880847@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Jun 2025 22:07:48 -0400
X-Gm-Features: Ac12FXxDWMVHh8x3oQC-oksHsfE97o8MSwUkJxZcBW8YhsT9RmghUSqQlA1JLeI
Message-ID: <CAHC9VhSTzc-KZyd1RSOaFDMjmiXCQBscLE=d1wGvc=DWnfz6gQ@mail.gmail.com>
Subject: Re: [PATCHES][CFR][CFT] securityfs cleanups and fixes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:47=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Thu, Jun 12, 2025 at 04:09:51AM +0100, Al Viro wrote:
>
> > Branch (6.16-rc1-based) lives in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.securi=
tyfs
> > Individual patches in followups.
> >
> > Help with testing and review would be very welcome.
>
> Seeing that no complaints have materialized, into -next it goes (with
> Acked-by/Tested-by attached)...

Thanks Al, I appreciate the help cleaning this up.

--=20
paul-moore.com
