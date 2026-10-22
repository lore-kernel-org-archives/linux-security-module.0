Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792637632;
	b=uNoa7SWf0veekyxJxOWYWPnv7I75nDWSOxrmiAhNtvsPcD2w0PuHY4p9+rgzQOYE+X8p
	 qvzWILwdWubLVPPz6o1FquOIp0/cgc6mFPq6F2/7qHwXaTc9+SNtSSbCFcMR5ymDMmAJ5
	 EWVlbSYSTcZpinhBOFXHoVu0k9B58dSr7Pfc8fCdTP6AqmoBb/riQQNfFLhOJv0BETDPg
	 zdoQoiP+29c1sPoDtuf6jppoSgWDM04YuC6uVEeKq8cNdgcf9IfdZuMCHRvjQG4sZOLbv
	 8ECdDkIGoTP8pnEL4qhRiFKMRLIaTL5RZD7mc9bctIBtiaj4iIsRH7Tfih7Hp6RW23w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
	b=qfOmZCINgYV+WrxtRWQ/nFnQcs2oVXjeLd6dPQOgfADC+acDIpqTOB0dhlNMXc0WXm1n
	 yvL+V2ypA3ysRq379S8M29SFvntBwCc1PZsHALCWLKNB02wBuK1fdK4WeOAn8RJYNGYUE
	 Y7eoJJYwcIks15yXFeRjTY8iLAKOLADwnQUr7/At9fuH2Jtlhqx3F/npnmRj1msrczpYS
	 B3tdd9yx1XIjRfcwcRneNnLvGxRNpYxLRn/mGBUWUGjOqvGqjVSR7lLj7JfOj56pgoZgU
	 PMzlu2Y35nGuttlOvFAeoyMLM2oghg3HYSI6CrlbV/J+OBq0w1PykRMiDDR1/IjxW+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DTOI/Pek";
	arc=fail smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE6606A31F
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77CE6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTOI/Pek
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c43fbcb4393so173532166b.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 19:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792637631; cv=none;
        d=google.com; s=arc-20260327;
        b=OrHAGOClNg4STpgup6A3FuNLBqg20prsGSOLQ7bH4CKpjOMgJc5Lyunoq2CNGsNh+A
         1YnN37wEIyC3GVLInbLxNpcYr8pcN00wBhSSzp4TSB1aGk4L0MFzitG1H9RLRYb12xV7
         w+6qILlxOVB/9XHrrWWbT5ekLVyWp/+6Dwygfw2KhmlJn5iwMMiST/UqpNHQ4djtntOl
         B4rJTZLIkae3QlY692L3gssYaew8i5wsUlbTrRuidkDK+RJg+NyjnlLCnMy6zwBSYKHY
         ApEN/J3KJwYVbq/XEbvDV+pqG7cmFUpo38TEso7hLhSJNEiAE1+TkBR/nCivofb9FUfE
         Ucbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        fh=AOzrC5ei7XNJKAtVV+GXX/Awt67siqxtdzyrtue4rDs=;
        b=O8v2lwQRxwTNXkQEzIzxrPwHpcvUVxQvDhdGb3+iTSbBD2MTB0/YZpL36hh0fe7muf
         oYi1KN3EuaY6u3UZ/nakOwtnDueHbUJoHISwnw5vvSVwIq202opae/UzhAb34b4FiTby
         XI3Z6OFiRXBklENBDZRQHPvbp7bkjK6QdOV1q7aYwldbGnS4SOw2jntuJIgwl47t/bar
         YoYhLEwpjGOVgxnOmiAnsHyEwb3CMR52Z0AeDbzXMVlo+KTjsDCglCqLd0coD2pA2Bgy
         4uaOooOKubxmHdn2CZnlDmxGXgMWlgzAd+2hG4Li0iBkXdxnrpYgETfRB9KUnDqimmhk
         WI7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637631; x=1793242431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=DTOI/PekpHCFwbCxS6btLnjWQNCiYVc9jJXCEYwAmPekEK8t/PxBNEKZNgCm5yMo5O
         ZHRqWqq6Sa4prnp5961iu97eKvO2fCe1P/oDhQUuXQyhe3en4gFePLH+ndAycKrOkdLY
         ZBtVPzCtW837QZIUsvIlXqXaajHAOKuqlnaym36x90uyaZGBsQGk0lDoH47TKDdTDSv/
         +bNghojo2jLNQuKI4CGPrg7pLnnWdQfj43K8C91aQyr5qb1zEo8L/J/KSRypGRSRs42E
         gu3hUif099K3NIyvd05k0+GuTWcbFOAPWaSRNh9N1gfC8G9MuampVJBqQHApn7d+PZp0
         CiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637631; x=1793242431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=xR4ZDP72FRh6eoph25bg5AZ0agTY1prYiiXKpywJNSp4rdKsjOuH5W+1xw8Kd1nEPz
         4fvGfGacy8cWZhms81SrEEXKE2iewtJtzqY7eHuqZvJrITFk7ssoYxyqD4Hn1/MRD5Md
         rwG4BVlXlp6XBwEhC8papdlIqXZ8VyMFJQJ/85fofyxLyRnPDrnqgeU8vZeu6iWoooAf
         vtdh6fe9tSoZrRZNFQfkCoSmwnNDU2SNIQYWAdfsNmM7YFrLBwiSYds+H4009DH6XK08
         olRLxdG6NmMpc7iRd1aACwvR2KTexRkz76NaTcHpUmtUlaCQd60I3wJvB/8D6N+X8Wuj
         yB+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzOw3BQHTkigmpLX1oJEDXJesCfj9GFPbtfblxqZ1C1xgI2hnI4FIhGro6RegUk8Dirt8iZdF9mVUwb8+/2KM/gaCIZhL0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFmC+vOhbge0Kx0HpR1z5/g/NacOiUAQx5+lieuUBJWyXEN4b0
	4cM8YpVAGH2WRTtmRjK0Be94sJ2MGrlBoypZMah4/PculA3Ld0Yh3gwcBFQ7SbGZFxqMSx7uC7T
	NcBPDxNylCnm6bKRbcmrUqd0xW4DhI6E=
X-Gm-Gg: AYBFou0vx3hktv3vTv5n9fmwvnxB22odkAiEq/j2Y0rdW0QUgJ164pFX0PsCxwXAcU0
	d2dVdkDTyuZnTgWGsThNYmwzejhOFdG3rrGK2JDiCHVlngrzc1q31Bfuy0Fqg999S4PZzUQty3E
	cOgvxfUqVszCkRp/whZoVvRC4KoYZM0fSepop0BTPV/jSoH7jdAYxs3tGF0hoqJkgU5xzpLNODq
	sY/nlnPf5fVkufFD9S5ZDIDtbBqBc0crF8SC7E/lEC8MBFnKFtgLoToz+LilQ6U68Ml9o4Vocb2
	xDF8y+nF+IuoYpA4T9b5VadNsZptQDp/PdRt8Ik1wHPFouqG58buS/z3MQSU1yD5UNmFIoqPniQ
	5ZvbEW37NQsOsJy0ekNca+TSsPk/FKtPOYm3rm+05tsyHHxqUCAnWFL7w9w==
X-Received: by 2002:a17:906:ba84:b0:c41:8e21:4d60 with SMTP id
 a640c23a62f3a-c46791326c1mr341731966b.1.1792637630664; Wed, 21 Oct 2026
 19:53:50 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de> <f444dffc8e6bf98bf44c02456adc2de40e4ecd95.1792552161.git.jan.koester@tuxist.de>
 <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
In-Reply-To: <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Thu, 22 Oct 2026 04:52:00 +0200
X-Gm-Features: AclHuK8zMCY_XzKvgZWVeEW29rK2WIKSmZA1a7YbTdfyZ3EtSnPZJ1CNUxd7pQ8
Message-ID: <CALWcw=FYKcDNXeArpsabHiQOAL+cWkF=L3stL6MB0OvVaHei1g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 40/41] nfsd, nfs: carry UUID and GUID owners as
 their text form
To: Chuck Lever <cel@kernel.org>
Cc: Jan Koester <jan.koester@tuxist.de>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:44=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 10/20/26 11:16 PM, Jan Koester wrote:
> > Encode such an id as its text form -- "xxxxxxxx-xxxx-xxxx-xxxx-
> > xxxxxxxxxxxx" for a UUID, the same in braces for a GUID -- in both
> > directions on the server and the client, and take such a string (it
> > has no '@', so it can't be a user@domain name) as that id again.
>
> A bare UUID in an owner, owner_group, or ACE 'who' string is a new
> owner-string syntax for NFSv4, one that only Linux would recognize.
> Thus it isn't interoperable with other NFSv4 stacks as proposed
> here.
>
> RFC 8881 Section 5.9 says a string without an '@' that is not a
> decimal number means no translation was available and the receiver
> "should not use that string as a basis for translation into its
> own internal format." RFC 8000 Section 6.1 forbids bare numeric
> ids in multi-domain deployments because they collide; the same
> applies to bare UUIDs, and more so to GUIDs.
>
> If you are serious about pursuing this, you'll have to start by
> raising the proposed wire format on nfsv4@ietf.org before the
> Linux kernel's NFS stack commits to it.

I recall rumors of MS wanting to stick Windows SID in text form into
the NFSv4 protocol.

THIS proposal is even worse, in every imaginable way:
Stuff an unreadable 128bit blob everywhere. I am sure people having to
debug that in the kernel will LOVE the idea (compare blob a with blob
b as human,YAY!), and admins facing the 128bit hexdump will send
marriage proposals to the author, for making their lives even more
heartless and miserable.

NAK, -1, for the whole patch series.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
