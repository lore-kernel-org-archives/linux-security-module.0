Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E73AAF7B
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522371; cv=pass; b=kWZgmBgCBtD8o+4FvfUuDniOtIxx86ZPerL4q7feQN6LcD0O3oeiPZ3crIlu0VP4TTj6jsFMHqbDxy6sDXxjXgbouqSrN5adrkE/AU2P2//9SoXciTLBWUaJSt0xUPBIXdREs/j6jkxrItR3hMOYqT0M5wo1WUtpcWQoiI9I3iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522371; c=relaxed/simple;
	bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+VaTJipgIRYnQ/VOg05uwgV2N2U+Mw7+vpP4t5Au/g4w3HUCYegf0glKiCXGxdXevzWf7acewU7souquKWqZEJWL2+sNI/UNFgp522vkFWYq/MMc9SQnKxw18nDwgTzwfm8xNYqMEN028JgChhuiCU++bs5YerHgjwodu3X/uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X68XKz3G; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X68XKz3G"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-888cbacf70eso55649307b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 22:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791522368; cv=none;
        d=google.com; s=arc-20260327;
        b=itkw/11rTAvAbGLAYUs3e13EU3V2ZWXar+aQACXXM2IN8GHfgLP9/I+CHgsBPPIxyS
         DmkC3yQch5mD1YFHRfGIJSV1lRd5ucioqxSecImngPq3kwiWwY/c7QOdVn9WNmC9vq81
         W6fNUvum6htd2N/ScZLJ3ADDEliWljcqMPmxLtQ3bUpQtVUH1itmIzVHHJ2Cw4Zpyzrn
         lTN0euZgHg0ZM7B4D0zfFpctK1SX5Sc9UY/hTDCw6iLdOyJvnaYOh9puhgaEt/lWIQCx
         o9i0mNs5weMs51HdlFHs4rKPerSHmMYAwTSh/+95yW6sHKbg/WjOewSrowfznHn8/PfV
         FPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
        fh=mOgyCg597UE83HV6RITRZW2P+28MEvk4S0aQFN9yyys=;
        b=DwdRua2L0MfSbh7uOnZvHmLx9uV/HP57az3xehbP2mjafpROi2bADm3o/1+9zaXu60
         JVjOhDlWtDo7FKeItNM6TiFX7D06c+VGF9r3XPQTPOzvhqNY3NQdbgq2agcO1ZW3Q20z
         U1QyN+R9OZHp94+Sma2K00YGl1Q5XYCM0i5bEQ3pf48CHu4apVLO7uSHldMcQjv/bVd+
         ZPwEkic74XPbzEAkao/q9TmzeJA+Ob1cmk2BKTjI9nzU91wZjDe4OcGEgLuMX3qzFVQY
         bNfKhZ+mUMVlrkOHqsVUF+HFJP2sRnV2gduUCe8czua0ZaOL2v7Jua62+un10ontgqDe
         XbNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522368; x=1792127168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
        b=X68XKz3GK/g1wVOTb+wV0jy/KUia5G9SXxhqc4OITBUK6CooVak0aOnYFqKVu65zeU
         6JbTSoBA9TQmKfVJGOGi3pdSj+U9+HhkGl0/7KUZD0Znefy9hIQkdiWSeMQ1HUSOhZkF
         cSlC/hYALPmWAH6mjQQ8KpO29CfbxWJU6uHzNN/QvlzVTbA9IPJUQoRFk8SulgyDa+Er
         1tc0iy3Wh01uG5aIACIqQKwNjeqr6D9o4jmKPbQfsFk+wef5DJsnXl2JWK+e2zaTqFHl
         SqEfNjXPsdC2KGS2vMQj2ajTnvnpiECiRwQ6Y7kn42MBU2aN1avmhrzTuxl/cPAIgrt/
         ixYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522368; x=1792127168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
        b=UiiEx9A+k9WRBE2CXPi1/YO+p09LSkMO0iPBCKAXRc1A8WDh6yuu1BOWg4O12TauBo
         Yx+Ian90auWhElk+7MnxJtrOkZDCXlQHIeXGfV5UE4goI7JIFYAbPmE/JFaxrwJ3U/pO
         N5qY3jw9ZoKMwVTWZrZtD7cjN94ldLNPzDUCKXh9zXu5QGWJ+cUb+NT2jf+yIedtgcpG
         rhzuADchhRj2hEPerM4ZEVGrueqR1/MTQ6+YZyqNt8scYMyNenepw0NXIo8tZhM5lzA4
         dR7BMPfmZwMy59DQVTfIwjVEQ1ewm27srnuMoltQQHFeFrU7ecC6LCq4+X8O+OSlc9vS
         4BzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNhZ8YevKXlQLRYiL72bq5FDQAr0G96uA2vUbKFW6OKPMBZvyQYu9TA0dXjc1G5iXF82F9TDT2/zrRtDCow4Y1yaUZAgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFucX//KOUPDIzd2OqW+I+YeWVySSkXliGQOke9ST2363WLLtr
	3ARs9uYp+QCYWYIVeKDeStcMW9JYADxsEd5Dm/NncN+E55NXpQml7m+3c6gAPOkfxlGiy4qsszc
	2/vqdg+uz+JZOZFgd5tb9Wf0+cOXE32M=
X-Gm-Gg: AYBFou0EuDrcaWY4QKgASCrkfu+mpb3jhQxP9OsqgrbN9eWFEbP06e3daFX1oB67nZ4
	BcdWWT8qAHNAuSG2xUoR2FnHUvkgFQPe1dqq5i8PmzxmbZbi4XSfp1xqLWCjrT89abouYzrHTlh
	Jg3kgcBU99/ARET9QJ7H7Bw2kNmH1rcS1sOHXNrNxpVJaM3xyVYCr8CPUkDPHTH7QuoH08Gnb6p
	z2yJ9C4XaeqKpw2xkd+rf8+8Xl8I/u8qrdyyDzOIHiFeCRSqzdTVc8KdHitFm90XdXf4D3ob2AF
	3ul8iFfnnfmRAlOcsyFPT3c8v0nw30BepISkrkGQgk8rjDflGG9v9rVBBQ==
X-Received: by 2002:a05:690e:4403:b0:66e:5d40:6dab with SMTP id
 956f58d0204a3-679362825damr160377d50.23.1791522368308; Thu, 08 Oct 2026
 22:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com>
 <asfZfZcusHMRiUYY@kernel.org>
In-Reply-To: <asfZfZcusHMRiUYY@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 9 Oct 2026 13:05:55 +0800
X-Gm-Features: AclHuK92MCPHMkbThkXyJZrzV_KAbzt10KrIGn0E5G2gyILDquLox3Gbjywre7Y
Message-ID: <CAFRLqsVwB3s4OQRkBzZb3O7ZmvPuiOYti8xjK72pL4HqnvGKHQ@mail.gmail.com>
Subject: Re: [PATCH] keys: Avoid the owner account dereference in named
 keyring lookup
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, sergeh@kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 01:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Similar nit. Not sure but I think even just having these two lines would
> be sufficient or is there something that follows that would be
> meaningful?
>

Thanks for the review. I've shortened the Oops report for v2.

Best regards,
Cen Zhang
