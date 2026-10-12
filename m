Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC13E49DA
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813562; cv=pass; b=MAiWMVxTcPeXqA+zHjHJcV8QsXfRJ/cCAqNB4CUN2VZtWHQP2wgT5dxABJIQR8mNSzPlzRAw7wi48/ulzB9FSSykolBtk2iBMrjwWUbKZXsvXNvOAdy56ZcDubbc9dqJeWXqxgUBuVQvSjSyJ95rJfmEif5uatGz9dToVrfhVsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813562; c=relaxed/simple;
	bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWUiFS/ElE11AVrjX0dQjwzo+v1epY2GkDXPz9BFSeaTsq3DJmdPxL7Y764HrE7FEEdXvaS91YjzpP9OyG+JfQ1aYP2ErS6R1kXIe4Mcjcda2wBsfrdTb/NlxJ5TKeOb7qStWh7Mql97Ushjq4e0OrMK5JPkDSwz5Y5MyYW5P5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l59ictqP; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l59ictqP"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6776efd4ff1so1397482d50.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 06:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813560; cv=none;
        d=google.com; s=arc-20260327;
        b=Tp/ifQIe5EVZjxND3LjG7JOTMgH3SuaIH8jl8Dt+2R+S51Glum061B6MiewpwZae6X
         sVBIsqfDEWxemQdAlmqohjRJxhyAqdCxmA529MhatwvT5yqF7hD6nLmTHq6cYwD0r2Y4
         IfapIa5AE7R5fLC6dS8nhGKGjZW5hweYRyQpuKW0XyxoRgYaAdte3mtp9JvjPTNuVCbT
         5B5yEZTp1Jw8ohLWn3APtlt+j0MIDnwSuuYv5UD6qv7ZsVEncZ36ZI30SbQqT8Z6LfO7
         b7zAsbCBDHvszRVcWUaAQT9vk6U8Zq6WSPXMxheSDNin3LM5vJLRpo4/kCaCwime6ONg
         XZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
        fh=QOcf1wEOcOKsEPUqf7lEZ/q4rE/vpoa1f3NzTl00zKA=;
        b=Ig4cEIkjREprDsDded2TPHeTVHQoBNtfz4zVgtFXbL/TUohsXaphXugit1/RxnmWB0
         9agCpnFjvhs3Mj8noCnZQU/5NSV/5l9a8bKk7539N+G7hLApS/6kxBd1l3PNdvgwKPWb
         i39UqG0J0mAeamrokflZ4aDxZ9pcYnEHCmQxzaKRWqtcOKWimw8UdwdUpdTwy7w+YPwf
         9Yu+szuBQNEbnapavV1OxhM3S53bgAormx5VxEK8cKaiPmEufHJDfG8b/bkmoAKRKsRc
         vokx+5BK1i5aD7TROo3lMjEXqiSWTb8TYHkvWaYZA8tWKA+XMlv1EQmiKghudpHn0cJN
         D4EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813560; x=1792418360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
        b=l59ictqPvgtSdXxtxQityvioB3NKtTTy1otYtzB3WjkLh3dOWALB1x5GdqX4it6MNl
         4+Oi9gs7LgfRIBPGHP1kg/D2HSW1OfPsQ5jR8arpqYn2rpTptOPR4UuHhYycFFF8ICTX
         opUk0g0/pCRuHzS3atuvN8UWp5X9/7VD9OtSUc9VtqdBlujlncAaY2SHRMkH3Q5LXpkZ
         dpGrKeABWrefOeZs7Z16WBcfapLnlh4LTGAcAICSOjsMENWO5a+uFhJfsKnUGAse20D1
         RGOx5qHzOH+fDHDquWyESnHWVy9R7s4BUm9iFhh7Hkm1ep1Mo4tQVldW3IC9W1FI3J/4
         I1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813560; x=1792418360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
        b=FYk78oLCyZlqK8TuDg6vgxTgLY2QuwKIFLWq3Neg0YyaiPhoZ04OAXWIc7PVhgLcwc
         Gz4XMMscWUP6Oz7N44nieiizgTsMQXJjjbOad3rRNlBoyY4jJShoa3JoBXsOa6ledPLO
         +uSfred9nrRqnt8gzY6MjJQs3JyI5tlqAmSBRoPV1mfa0uq0rtSrOLt75AMF0NVWn61E
         otF6dYBX7RrCtAQOWWyEen65mEtjKsJQ5wRpzmBR8Hxciv6g3+nOu1zMnDQKSxI7sHa7
         S9oCaUuK4GI7WAQRIWw8hzE1smu3GNYfNyHm/eaSlRtzWFuBcfoXzQ58WnGzeyohOn4X
         icrw==
X-Forwarded-Encrypted: i=1; AKwUvBw9ZPx1tt/wXwZ8iPQ7amxxdBVc9TvChN2S7LNDhqxp4PpCKWTHqz7fa8Xi55nHoCQOaqQGWl+kFOQjyCVGrIr05/l4hEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPODmT+iy0QvpcEOzXgQl0kvtgfK59jveB4NDsU+YZMTpIGJ3j
	YCFyz9gndYbCkCSD9XzbIq3amZNtSNdfz8K5AI9yL7QNx9FlmOJsJe1S/Mf4/bBbrI6YI64FEpv
	FBZyy4+YBWKanYCaPLD8xESDjzDZt7Mo=
X-Gm-Gg: AYBFou1c4mYDJAOCFDrernqblbL+dc7roCsq/nwkj6cnHZH6SBo7mhOe/xlhDycOOwF
	mZqH14Na1p8VC6TXgfIEAa7VgXk77cz7FUfREaHsjfwPvgY9O269ZjwyP1kNqXaTEUa4v3IMXBL
	XLJXWtmLbViB4DwmG/x5wZbD0RpPZEOCUqD0m61OxESd00PBCSCiMqwO0xhzpd8RXiJE7uIkVxw
	Ic3dP/HnJ302GWZueIPm2snOdGPazgrnjOO9bP4m4nPQor9gB+3lysS637kkuxJi4GrSeNSP5S6
	u9AnYB/GOQxJn1cjwkViUA4LGHoExcd1+yvSnwHT8SZrDcnORFKk9B5lwQ==
X-Received: by 2002:a53:ac90:0:b0:675:3c10:28a7 with SMTP id
 956f58d0204a3-67936acfd88mr2947207d50.94.1791813559834; Mon, 12 Oct 2026
 06:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org>
 <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com> <aszlg2R3E7zqR75r@kernel.org>
In-Reply-To: <aszlg2R3E7zqR75r@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 12 Oct 2026 21:59:09 +0800
X-Gm-Features: AclHuK_Z8o-xqZg0jqZI76nVd64T9lr82nl3wJ3vcrRD5bolIQP_kt4ypa7iRSI
Message-ID: <CAFRLqsW7HEn1=BjHsVNpvqT+Uf8hnxaY=ktsx+5S151KM7mKsw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 21:49=E5=86=99=E9=81=93=EF=BC=9A
>
> While AI assistance is allowed, if this happens as a pattern, it is
> misuse and eager way to credit without due. I.e., you've done 50%
> of the work but ignored the human part.
>
> I.e., you also must understand without AI assistance what
> the patch does. If you do, it should not a problem to write
> a commit message tht simply describes what it does.
>
> To summarize:
>
> 1. Actual mistakes are fine and then patch just needs to be iterated.
> 2. Skipping work is not mistake and it is not cool.
>
> Hope this clears things up.
>

Thanks for the guidance. I=E2=80=99ll keep it in mind.

Best regards,
Cen
