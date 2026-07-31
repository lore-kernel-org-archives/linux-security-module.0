Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A13446C3
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529460; cv=pass; b=A7OvIS369K7dMI44kU11ImkvWj1tZnoSyjp0wYdrK3ywweEh9MCbUdGQKY0raWrPsBLdrMHVOALUjVB6oAJ119eYFzz2SwY5Kr0QYDavYCFtDVF31Nz7IzHgFa61nDWlpm49XlSjVOoXr2RQTre2BuAR+USg3eWMcbfK3nzCgy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529460; c=relaxed/simple;
	bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5is7ekNPIlHJRtRKGVETaBtXYvnEUpQftwv8/mErsSW1gF7yXXbZbqS4SEZ9NYTnp3IuXkE485JesqLIpwkZpjoCkFy1TE4AH8R4yFpUZSLIl86sqL2LAERswytmEPUYeXAwoIOtkdiZOV1sKekFB1xqSpFGf9CHO/khol7aas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bcmjXypw; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bcmjXypw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1030229a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785529459; cv=none;
        d=google.com; s=arc-20260327;
        b=D7qlfrLxCu8lyl07Ia72V3D/iF7h7ibdgLJ7fNIvBqcDbzNnV5jqqZslA9+TI0NH9F
         wCXebMu+EQN/MHVtYN4f2fE3ITyK+apIRjaBSF5Bjd0Nu35t+Vq/Mfu5DHMfjqOwyX4I
         4WqoeAPkleJJXL3OYtzyJ9hJksw5wC0eD5XuhN3W6tMxbuag2rZBSTbaMlkInALOSuHF
         pR+fni+47e8ESBYx5CmPvk9GvGv37dupKT30LkQtHHKD2FzmkFWc8ebOCRSPEBKQqgXD
         2sVWNxEuUgRzaqUaUFULTv3DcYfJx1IdDbmkqtYqb8w8zitOuijs4rXObJhO9xT5aTBC
         75/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
        fh=2CYBB+UBHzs9uXstgJ4nCs5tD/J8jbMXz3jVWzrVpLw=;
        b=IkfMcluLjmdG6xD+SudsF8vRJJpe0x5O3ff9nwYYPFEkuTa0yl/vHQkUi+5FtLMmvK
         cfHkPFhRDPns6QmIgV70IXrhEm/7G+IIDqmLiUw1zgQFECI6Vw+tSRBr/fQopjKY75Kr
         DfY1HkItmwdy+QfnrLRygU9Ui8L6T1mOUXvfHcplMNH97SKE8HDO5XaxRUEr86FWh2pC
         JwXrWWq5ENVM0RNlA7m0mTyKKDFwdpV0iN8OcNpFp99tU/bl+VedEhDsMRP5/YGstWFQ
         bB1orfgH9UoFfISJH2cCeHEOlLEq9KUUq7NEVSY/9zWXCEiDe9CvcQANinx/5rw6a0Jt
         C+zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785529459; x=1786134259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
        b=bcmjXypwzyHOE/x+M5GCdL+anwsAcYTJ1KUWko2Jf4ZRIuy0HHGn3X1uxM8+7n7FyU
         rlKUZSP8HC26gEXMdrwMPgbFHO22aGCv5NXsKt+ZIRGpGvSnf7UXMM1lwXiBcANJlAoh
         LU8hKTF6/s5lFum3U0n+csUmQKsO/5y40z/ixr5GKTUMLAoyj3v7herhmK1G5S7EL/2F
         CbHz9v3cj0bQKY40TRfjJ0zUbDtUm0bzvhGfn/tHGUU1zbEKE34eeQqAWUwNS9qVMLWv
         V6ysu58Bw6M4zZsQJCJUqSIX3dVMnpfbiT8SqKiUTFRBjAAKWerz1FrAvxLHqq4AFCwT
         0+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785529459; x=1786134259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rk7oo7lnkRtvOGIsTANDyDqMivFVxyPzc8I194ixEdo=;
        b=Yj57lRDN1MMDXKPa6ZGlY9ZrrziQZQ/DWBn6Kfjr06SAFqnyCyxQmzJ3X43cl6Ijko
         0vn1MFKlFRsxUQuVwItXR/LfSrB700X2fRPdbNJc44i2+S8au+XV4bd4EbpdIlu56gLX
         OP8eFU0JtQbrNyW6Pfum3CPjed3m8s2+jFSlMoYVQlj6b6///PErWLVs0rq+JwQXV71f
         bGr8x4vqt3lBZVrLY3u/fGbXDyP1Ox0p0Ejq2aFFgNHu/IPh+sNlettYlKCyp/9qKuOe
         w/D7j+WhBx2JmC9cyVvJYPYM6oeD5JnOMG1rwqYRXvUNDxXy1DH7WNKHmwXp5NB99BcT
         fOHg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3cpquFKuzJ7O53q2RRFvJKLn1++BXnlRQhFConeNLWpWqYUz8U+YFkNlfU6cpYO+6wkgqlDXizD/kRDlUAvrkffTM2z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9NKIbPPu0ZtaYpyz6NsXFzCm2JvWvgivPyFqkixMBbI9yvWx
	RIk1YdeiYMKPU0r+ZvUZQyYkaGnXX/1do1vVf8cRPHr9RV7S7EANAxVxIYZrH/n3TZfLhoqqdi4
	2mcJGErctI9dGlGDUhP2rOy7p9MaqoRlisqSC8edq
X-Gm-Gg: AR+sD10N2lQpTvfIKb/WNSn/Ojo46g/dAYU4SGhghKfmEmYWQNt1vC8x/A0SXGQ7Ttt
	WHwu79o0/DoP0QLmKB1WIb703X5bHfSN59XmBgmuRcM+4H/g5JGhsbbopGWKLzgE2/FIm/KPlfN
	elseEoIBBorq4xY56ytKzXUczMJwLs1uYkQBPcA/Y9z6kF8JLPyvo5RjiOjMneZA2McVlOqcNl6
	8qY3BZtg8MlUBpNDCMy2kwEs3l78FanoReC2LmFs1nJIJO4eLaaFukMayz2iclTVQ6XwBQ0M9cJ
	FZd8ULEzyVrgxloFkiW4emqEauQwH4sS1FS/s3uZXW+wqdmVT1DoaT0=
X-Received: by 2002:a17:90b:2248:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-38fbc40941bmr912838a91.6.1785529458966; Fri, 31 Jul 2026
 13:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260725200958.4471-1-cel@kernel.org> <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
 <CAHC9VhS6B1yW+8G9Biqit5CAmcg4CwCaWbq1B+Qpo2n6a=yqnw@mail.gmail.com>
 <8df686c5-f1cd-4298-97de-14c2c4638496@app.fastmail.com> <33ba1c27-27cf-4b83-9c69-1ec40023a5d2@app.fastmail.com>
In-Reply-To: <33ba1c27-27cf-4b83-9c69-1ec40023a5d2@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:24:06 -0400
X-Gm-Features: AUfX_mwMO6Jjth8dKZRaqKSi6vQy__VpnKWqSL55ru0Ew4-Pu1uuDWVesrbZjVE
Message-ID: <CAHC9VhQh5D_Py4c0JCzRWrcHbE5QSnencD7-mzzaZNyZGGE_NA@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:28=E2=80=AFPM Anna Schumaker <anna@kernel.org> wr=
ote:
>
> Looks like I did have it in a branch with other commits for testing, but =
I
> never pushed it out. I've moved it over to my public linux-next and will
> pass it along to Linus in the next few days.

Perfect, thanks Anna!

--=20
paul-moore.com
