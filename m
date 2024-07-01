Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E87126F1E
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jul 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848841; cv=none; b=UORk1qc1/jZZ4LrfeM2SvJLH+4nTG9AE704TQBeY+RGwX9VplEDiGQMFgTvljC0n4LdNj0PAOsWCcgjSmwCwbF7R5l4gSi2OqPvKzC5zgYc8p6aPp64HsdZq+Ji8DvvJ28bsMgKhduGZJipe4pn/HvXlUYpHQ2XuJDXm6/b+JlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848841; c=relaxed/simple;
	bh=FPo8D/Kk1dOyR5uT4VxPnhtcwddp+vWKSHFQqxpjbjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JtdlOnvPUW2msiIkWx5TeJ3CXtzsOBg+pkeKqD0pFPeXzf+ZBKAoy3stYUohdZGPGkbiljULxeQShJW9Ab3L+tDuhTexTdSpZMFjCDCZyRw03R0f6lWmKjwN8mqBFLdvKm+YDE/njTKg/kcJL+dx4MZcbzP7qEwqT6lUSlqU4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOaubwWF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOaubwWF"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe71fc2ab1so5768914276.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jul 2024 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719848839; x=1720453639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU1tUU/5ppJ9JQGB+epgGM7MVZKaRXGO2Nbxk9/VZsc=;
        b=aOaubwWFuqJdoKFt27fXTt1PngjO6tfxXkDmMjW49iIRHc1baBBKO3iYLOOsvTfFQn
         zwjMnQtBXLog0o687dMRKc3Y8HQK+Nb4N34Loaw3wlyzqWiIAhALW+nYguiugcEL3jFK
         jPXYOkXqjVahWMhIzskZecGMD8P7hqf1WxsoDOhMvhD369CNH1NvjxD2qqsWPuroVUO6
         hzf+g01BFqlDZsDFGD2DcFLtVL7/AxEOWuusTKiNBlUL3mmloS+9Qny0OreSm8judjtQ
         EwgmvicbKdTI9/FHK3C2pc6jOpY3k1pkkRlIdWEMdltdaRHGp8MlA6K4eq9d7Jv+ydE6
         k6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848839; x=1720453639;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WU1tUU/5ppJ9JQGB+epgGM7MVZKaRXGO2Nbxk9/VZsc=;
        b=mL1n2HZ12VWR+7Hi+5GU8I7i4QNICRu63ZczObdi/3PlZSx6IN39mEULTwKM9gzKyd
         fNA0rlP6oA/7ekUhbAsZeIJKfwb80zSm6KwUtp7mzXepvZrlpz27vGxiCZ8xRGsn2QLu
         hIZiunq+SC4sfFXlF/n4Qk+KAb88vvSwjdFAc4zE/1LR54RxNN4R7mzuMk2QogVwTJvr
         TQECPsqfcW7BDxRJdkYaKZmVo9TEJNX9thgVs0wLmgbGpfTKIwKvctDA28778Pu5y0S5
         UUNfYL0v2ZLDIQBqM6RML25Ws57hmfv6TbI14BPviPDm9RMCCJV46LYXrEiJ/QYSJW7m
         90ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOBw6SGRRlsDpypUUJj7F7kla9GM95xC1OES14Rua1N/MipWp8+SE6RS9+tF9iH/phkEw9VqneZYlRP0g/5fAkS1E/G1TzMWfSc7QMoQN0h+KQgRCr
X-Gm-Message-State: AOJu0YygqfrJ6xw9VyF3BrZ8Ybu0jsyUCyELgQP1SQMMIATIe49Ko86g
	a+LS/FU6h1f0tVxWUx8+H6THOiExDWpnrqBiZkGB8SmNeRoMGegMLFhevGHq2FM53UW1yoSmG+Q
	8uw==
X-Google-Smtp-Source: AGHT+IErBJMV/zWn0JWp3w5OGm+ClIlLy1G7Ira79YbfIC8FfYGvfByDwDiqd2kOIkaWE4wAf39lUKmODns=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:2b84:b0:e03:6556:9fa1 with SMTP id
 3f1490d57ef6-e036ec44f66mr275869276.8.1719848839432; Mon, 01 Jul 2024
 08:47:19 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:47:17 +0200
In-Reply-To: <bd2622cf-27e2-dbb6-735a-0adf6c79b339@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408094747.1761850-1-ivanov.mikhail1@huawei-partners.com>
 <20240408094747.1761850-2-ivanov.mikhail1@huawei-partners.com>
 <20240425.Soot5eNeexol@digikod.net> <a18333c0-4efc-dcf4-a219-ec46480352b1@huawei-partners.com>
 <ZnMr30kSCGME16rO@google.com> <b2d1a152-0241-6a3a-1f31-4a1045fff856@huawei-partners.com>
 <ZoKB7bl41ZOiiXmF@google.com> <bd2622cf-27e2-dbb6-735a-0adf6c79b339@huawei-partners.com>
Message-ID: <ZoLPhQ4eyl0H_oSQ@google.com>
Subject: Re: [PATCH 1/2] landlock: Add hook on socket_listen()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 04:10:27PM +0300, Ivanov Mikhail wrote:
> Thanks for the great explanation! We're on the same page.
>=20
> Considering that binding to ephemeral ports can be done not only with
> bind() or listen(), I think your approach is more correct.
> Restricting any possible binding to ephemeral ports just using
> LANDLOCK_ACCESS_NET_BIND_TCP wouldn't allow sandboxed processes
> to deny listen() without pre-binding (which is quite unsafe) and
> use connect() in the usuall way (without pre-binding).
>=20
> Controlling ephemeral ports allocation for listen() can be done in the
> same way as for LANDLOCK_ACCESS_NET_BIND_TCP in the patch with
> LANDLOCK_ACCESS_NET_LISTEN_TCP access right implementation.

That sounds good, yes! =F0=9F=91=8D


> I'm only concerned about controlling the auto-binding for other
> operations (such as connect() and sendto() for UDP). As I said, I think
> this can also be useful: users will be able to control which processes
> are allowed to use ephemeral ports from ip_local_port_range and which
> are not, and they must assign ports for each operation explicitly. If
> you agree that such control is reasonable, we'll probably  have to
> consider some API changes, since such control is currently not possible.
>=20
> We should clarify this before I send a patch with the
> LANDLOCK_ACCESS_NET_LISTEN_TCP implementation. WDYT?

LANDLOCK_ACCESS_NET_LISTEN_TCP seems like the most important to me.

For connect() and sendto(), I think the access rights are less urgent:

connect(): We already have LANDLOCK_ACCESS_NET_CONNECT_TCP, but that one is
getting restricted for the *remote* port number.

 (a) I think it would be possible to do the same for the *local* port numbe=
r, by
     introducing a separate LANDLOCK_ACCESS_NET_CONNECT_TCP_LOCALPORT right=
.
     (Yes, the name is absolutely horrible, this is just for the example :)=
)
     hook_socket_connect() would then need to do both a check for the remot=
e
     port using LANDLOCK_ACCESS_NET_CONNECT_TCP, as it already does today, =
as
     well as a check for the (previously bound?) local port using
     LANDLOCK_ACCESS_NET_CONNECT_TCP_LOCALPORT.
    =20
     So I think it is extensible in that direction, in principle, even thou=
gh I
     don't currently have a good name for that access right. :)
    =20
 (b) Compared to what LANDLOCK_ACCESS_NET_BIND_TCP already restricts, a
     hypothetical LANDLOCK_ACCESS_NET_CONNECT_TCP_LOCALPORT right would onl=
y
     additionally restrict the use of ephemeral ports.  I'm currently havin=
g a
     hard time seeing what an attacker could do with that (use up all ephem=
eral
     ports?).

sendto(): I think this is not relevant yet, because as the documentation sa=
id,
ephemeral ports are only handed out when sendto() is used with datagram (UD=
P)
sockets.

Once Landlock starts having UDP support, this would become relevant, but fo=
r
this patch set, I think that the TCP server use case as discussed further a=
bove
in this thread is very compelling.

Thanks,
=E2=80=94G=C3=BCnther
