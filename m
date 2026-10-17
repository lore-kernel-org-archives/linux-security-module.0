Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB44503B
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223269; cv=pass; b=MYjOquwXtXw/3kl+r7eZ/vFcMlMLTrL7zGSXFMHOi6/ihoIFDki2gxU+ajbtrrCnbRxcHZMTeyT8MGS6GK6eOyGgcXRdyGRerJJh7g3uFIci0/WlqC1PaS+RAPOYuSW9M5rpx+NDDyJ9VAg2hlAv8wrW0AqYQCz1lkIS5SbolKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223269; c=relaxed/simple;
	bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGCjp4NdOnAmezJIIJPUPQDsegOR7ulz6br+HbAeiEXLyL2zhzW85W/VKtLImYd0gG4nXO8h0N8z70054c0/CfrIPf5QZdEvfr4EbOV/7qLllbbCeHK59Gt92KoL4x4esGzpHQYLYrOe3cZAyO+H4oDQKTI7mCKemK1oeJOoBXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehNE3iKR; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehNE3iKR"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8871ada1a26so3974607b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 00:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792223267; cv=none;
        d=google.com; s=arc-20260327;
        b=qU+pJOrWadtsKZKY0u8BQCyPHHjGV+4SdobE7QVHrrtCt6jBqxmi7qczZv0EaSQzbA
         GuNclnq446iphjw08gKIGh5nLHfHlHGx9f+T0U5iOUREMox34qIc0d7RBdsidAXRQWgc
         3D9s3jqNx/EhapryGMhWVuT7O8KsYr3Ly7KWnRra3s0IIxtwJJnhdtkiE6axdC8cfU4z
         Uyfo2NpsBYcLS8ZTaZuToHRpQ5v0qc6nD9SXGaq5yfMWca7nfdO6V/OhwPNUPtK08/n6
         lN4SQMY9xXPa65MK0CCru0Pv9f52+ydNwWreEYYv1X+CkJIClxsnIU80AkGvnUXXyIit
         ExTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
        fh=toE3tq9a9L4UQTXxu33ZZCcFgjWgdFZpmzhpyokIAu4=;
        b=Ct5KcrlDZDBBcadeRrT31yYirAcPDz/H0gBKw/Dqel6ZtBTMVh/2mxh48sxolQHJn1
         L5Cn+Rqsv6F7DZ2sR4cETWGO95zBCZ5r102jRLIsbVQx386zQp0Sv8BBrmxpOgRGOMgj
         VRO+Nq/Ohvc0ddscuCE1si7x/rnDtE2OE2TBdOh4xkkZmiur57mmBXuWwWInq8NopMff
         8+rpZbz3qQu+HKM5fAMDN8c3kZv6vd9jlbWYXU7CHP7bzIVCL8+CaCJ6GHe4iMAHwY2y
         EipfJvrqFfteDnINVhTCvxPt8OLJQs99z1ZbcWHjDE4xs0MV9g9p/xbQnB3nkdMxNJLc
         gOTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792223267; x=1792828067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
        b=ehNE3iKR1FMemamaIhf7rKzmpTd6aUjpZVRlTnXw2rT2KeZFGpgrwgod4rnjB0KvfO
         O2RP9TFeydIiUuOuRXr9PVaK9SLUsxZ5ioS8yddVbtOZ1jBsLkR7RSGBiIhFZD+R1lxz
         aoUmGubuN1e70vklWPW3ERDyQC+I8z6DaR2t0h1fWqcxrEgGL1MUZVa0sYhUFA2YP5hk
         FXUI6VrPBFi3snLVMYVXR4j5vDaGH/n+L1GjQ95+H7A3Kp+du7aa3JLdrUjhyLkzG4H1
         Pmvy2oL1DK79enzif+W4ZD3rz/3YWvSQSSvDiEVwLJK4Er6SmlVw5AXwvLzSC3DD6mvD
         y26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792223267; x=1792828067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
        b=2KtUURDe9rNoHuqDmxzeHS1PU40JhKzByGqCxFxzlSsmDCJy0n9pF5P3IL6EO7r+ry
         fZ2WqzdaXysCXE/ypTVfMrmwCxADVLCVy1hMQPpLuXhq0YA+sxx2jOUw1mx0kTcOKrXI
         7hP0XTZv+9oAraebYcvWeBbR0aFvqlIMPRK76lfTq1i1+H1FEkPSVvWgyzFGhOHHCvdN
         AT0ZAK/+VT7KybH/YBASXEwZk2rFJ5pO+hvj0tWRcXb3wGZ/CkcFfdhyW6Onp3uxQmn0
         5fGMKwmFy53gytLUb1hgIA6NJiOAZprxLVBaLGHAbPc1OPsgSnzEU5JeUD4BHPdqKhuf
         jbOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoCfIEci1iSdjrvs5/VL6q2zEPxc2LCn3yw/5UKW6zGM9kvQTjgu7eEvlm3Hx38d8gGKGOz/XuTWSAlDKcybQmhZVgses=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ80kVSXBqV6edaH9VXitNJVWz8tYNwGsS+utVNS0ZyZKSEzgUh
	ahq17Gwu5/A3LkHZMisdpMjuiowGmuBrQpQJVZ1TFjiV5QEk4+xgh297dL/WkBZ9Sf1q/cidifi
	EUEs5brYOYeZnwfrPotV3HrYp8ZDTlbCqezEDThBR5DymKqk=
X-Gm-Gg: AYBFou2wR4C3R6M0QWk1gUbI+uX+H9oi9alyPX4YSxrflcZDageE65j6e8DEtGKG2Cf
	y9YLmNi46dumgvGZFtoPnzGcRgdKlWb+5XhaCj2rGDCQjIsmxV0bgT2R5rnUFmk8BVhgEbtNp8u
	qkMTTkNq945DiQ/NbRcpngwoM0AgpVxoswzSGuwAw4AjDatgUFihQ0S+t36uh3P69ZqgDtLKtXa
	Zaq4dsss3EY6enNNHiVHe5PxbOk5LAGIhDoLoliLZ6o49y/8+kzeoTkUOWdG0msn4lZCmk+6D1m
	LQuiYXyiFkhPKMPzSxBcdWwswDZMZmqPRKHwE0Wq7QI54IBY+s4FH6Q4653kYRk4CmxS3KuAlMa
	hiLTNLqWLmQ==
X-Received: by 2002:a05:690c:f:b0:8b0:ac9e:14f7 with SMTP id
 00721157ae682-8b0f2164c94mr7719657b3.28.1792223266956; Sat, 17 Oct 2026
 00:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
 <20261017035156.GA29318@sol>
In-Reply-To: <20261017035156.GA29318@sol>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 17 Oct 2026 15:47:32 +0800
X-Gm-Features: AclHuK-HpdMP-grbZn8KpuFXmo2CHX60pojXLGdBgVLSQqCwngEWAu1uK5ALbG8
Message-ID: <CAFRLqsWcV=0MKituMQqALy_2rS3kOPPFpMHxn7yRxoyxOHp6hg@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, sergeh@kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8817=E6=
=97=A5=E5=91=A8=E5=85=AD 11:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Don't key_serial_next() and find_ge_key() (used when reading from
> /proc/keys) have the same bug?
>
> - Eric

Thansk a lot for the reivew. You're right =E2=80=94 key_serial_next() and
find_ge_key() have
the same issue.

I'll send a follow-up patch to fix those as well.

Thanks for the catch again.

Best regards,
Cen Zhang
