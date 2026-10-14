Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EE53ED04
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986874; cv=pass; b=l60C6dxf+KIwebrjXxYAzdrsiagkbbjrAPtxpB5pKJKLMhNDOL7ZoSa7tCNOH1QSPVm16USHAdQycwnRbAiBAe+8Kln+X/lhsQl2/tZQk7+xo7Wb/2IEaYTwhxZ3OgxpMuOQccCOoq+zkv/scdPvx7Xu1qeUS9/SuOfZgRIr5J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986874; c=relaxed/simple;
	bh=Ju4TCHvUQjzrivVHreXOsbIFDljzoatZ5Da/lDsSQWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBQyhhAjmJqegjX/OjIE8kz346QgBVeD4ThRHJMtuxbtZDdCS0h1F9a07AJFdv1CIB26vxlYT3HEPu2jQ5JkxV8cmsbLd35NncnZCFGyt3biSlLg86VkPCwXReM9WTviUVLQodL9spomizbz613Jpi1YfiqWewpXlFMmDZZLhQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUkN7mB8; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUkN7mB8"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so2576227a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 07:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791986871; cv=none;
        d=google.com; s=arc-20260327;
        b=L1lUTIZPgxpiXh5TmLpVNUKJlcYaKVoxGu8FDQ/DndO2oh+W05FYfHgToAOXVfwgCV
         DfJnu6GmGvCuHFBkxKaDru1E18at4majvZsYZiv7AMx39sFIMgPMmOpCnraqgoawxOE0
         PvkHhzrJSK+dkiXbEGeyhaw4Jr2z+5ZX2Il4BC19sKEUmB42Qqi6A+xZNk6GBOLXxyN9
         PX3FIgJD4ZiE1Blk7ObI7gaYpQ3gCxNcKilEoJINGjmWTww/qIGzJOWVVVQCqKXZYb9G
         GpbbW2USfPudriAHyVSnt6u0TnrjlMPLByehYD1Z0RaJTUTm/M7y19VI/Ke+6hkXMKuN
         ZF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UhgBX9GqYPCtzCE/DAmHkc/tMFE83OUWkvy12Au6Y9I=;
        fh=5fVM6tVLGWKoQvT5dKGU7lQYHtysI2ozQ2NOGSMgNtk=;
        b=ruObmNzNN4maptjbL6swyaxdPrpvkbEIoLiOd+d+X0w6SENBac9hl3Lu92Q4/tBDUb
         4d1KjdG0icoVyQ0A3Bq16I5TE8akXlpdfsGvZq+HC3CyBGxHUZPiCxu6WT35SXMun+rK
         imESKGtBqKfuoFvvQK957HKCDlEvc+lgUlXkNTgtZaf7dDrbaOpOSD6o1UYBzpR3W/RB
         ge+uCaL75t5mWFLkfjjHwyQjCqW7Y5VFcfvo93CnomKslh/Rp0Wf/jMS88BMFKVgwmRE
         HIXtRuTZRDMqtTTPK7JHmifWT/4QIRdlJXIo34F7177ySxM004/NvUpmkX6AziFiZiaS
         nUKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791986870; x=1792591670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UhgBX9GqYPCtzCE/DAmHkc/tMFE83OUWkvy12Au6Y9I=;
        b=dUkN7mB856aMWYzk2mAv2Y2m4zG1a4xeSRddZTuYhgZKusDDQonY235dIoG5o8JKJl
         QKfySKcXwVicI9gch5/dxIFvAJojQzL6662wKcXuu4woKgZMLRJ/qad1Qy12hIJJJF92
         ap0aW58U+bM5nXGVO7L3/S2o3U/Kyi3cgwfBeiJYRSMjA7/GK7XHQF2hovcQ9r30LjhF
         MtBjPUVNrnPtQXrBrGRKYpEqg9QVg5bej6nn+jqbr00k7bX60FRo/nenuMwc00AjgrKz
         Y5DeP6fJxqbzggFanRCjH84Dbmygd562npSp9dszqhZnUGifPCTVTeXchMJlw+YQwKXj
         AlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986870; x=1792591670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhgBX9GqYPCtzCE/DAmHkc/tMFE83OUWkvy12Au6Y9I=;
        b=BUCbnrpC9o5byQQP6HjIVw7mx/SVHc454SU0ibmSGmGACsRVU/KxQQVlj2DXSSI7IG
         HnVR8+5DS+Nia2gZY8ToyF1JNhYilegotL4KLDkK77V/xAFVuhze/TZoUYmGabIKSvsB
         pMPq0S4dNwEHcgzurYU4UGaaFDPawhUU118M+sRlYka0l91Ov03bKj50pwBzkirn2W9j
         U6pyWQxYHlTKWRzQAA0yi8+RbB2+bT+zkktIyoJqgqFSjEowA8rifxbsrhJGd2w0u5Om
         rB+DnIhLOhJ9e5Tvxkya/MDGOTDchabrWCIVD5xlbuDoBO2N3Q+r7vJ4Kg/CMlp5mEKR
         QA+g==
X-Forwarded-Encrypted: i=1; AKwUvBwVSWQRejDFQY5gbG4+7qwGkwtLprMuPM6l7sEF2Ij1/2iHVM8vASiAgz7eEAkLRjnigvbVGuVVBX8+JvGK/tcWljyjusM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqMwAHKEI6I2s9dfJ/9kc70PljSw6L/T8sTGI5SpAYTGa/N+H7
	JFSqFTT5snrX7Z36tY7N9DgRr+CaI5Mb3SIE7St/fwkXXOI40E8Md5QC7SZtT5vd3YB80tT7wv6
	3ZbCs66I4P09x5eydhlnoJJ9c52DMKZJDBMxBg82W
X-Gm-Gg: AYBFou1LWD+GMcjZiWQkfObQPFR6zUMy5lTCHsgrgNfXmnsR+fzg/uk88uwjbbb4eeg
	+suZX9Tk0/tUCy9nVu0XiQYbbyIKUgOLtLMf92A1b/TM9UiEfPdmvPh4UqWliSupqZFpUtRQU8G
	ynpKdH/mumbnOdLUazj4TDoll8xzbmnQ0j57CqP4h7WwNEaq3i4a1pJri5FzIVrH6HgGz51OiJ1
	yK/HZbUOnDlv/tDGHgtsFLSsKTXy2eCCLfUh60/vzOkCA3bLmZmfGzp5lTNxsFrKMBznIySNXM6
	7cm4q/65VyNlwEzFCulIpS8UqXmDyhxnxCoxN1yxAVRes9z7nfCI3ZmjgAABCFh1o4UH5zzvpw4
	YXuQrpAmAtpc=
X-Received: by 2002:a05:6a21:a0c:b0:3dd:a196:308f with SMTP id
 adf61e73a8af0-3e16beeee7cmr12019509637.63.1791986870601; Wed, 14 Oct 2026
 07:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179156155963.36253.400481753322266658@gmail.com> <20261010090534.317149-1-wang.zhan@smartx.com>
In-Reply-To: <20261010090534.317149-1-wang.zhan@smartx.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Oct 2026 10:07:39 -0400
X-Gm-Features: AclHuK-Uxd2Qc-uVsvOHuNpvBEQj9YyXbEeOa-oEAPBD6eBDFm2MCHFuD_v1aJU
Message-ID: <CAHC9VhTMjeruUxobNKyE=4qmtgcQfd66MdbQY+X346Vn4Yz5ew@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, Joas Antonio dos Santos <joasantonio108@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-security-module@vger.kernel.org, 
	Alice Mikityanska <alice.kernel@fastmail.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 5:06=E2=80=AFAM Wang Zhan <wang.zhan@smartx.com> wr=
ote:
> On Fri, 09 Oct 2026 12:59:19 -0300 Joas Antonio dos Santos wrote:
> > calipso_skbuff_setattr() adjusts payload_len by the length of the
> > option it inserts or resizes:
> >
> >       payload =3D ntohs(ip6_hdr->payload_len);
> >       ip6_hdr->payload_len =3D htons(payload + len_delta);
> >
> > GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
> > payload_len =3D=3D 0 for them; ipv6_payload_len() then falls back to
> > skb->len.  For such a packet forwarded to a destination mapped to
> > CALIPSO, the code above writes len_delta (or 65536 + len_delta when
> > shrinking) into payload_len, and ipv6_payload_len() no longer falls
> > back to skb->len.  nf_tables, conntrack and sch_cake rely on it.
> >
> > The same arithmetic also wraps when a packet grows past IPV6_MAXPLEN,
> > and a BIG TCP packet that shrinks below IPV6_MAXPLEN should get its
> > real length back.
> >
> > Set payload_len from the skb length with ipv6_set_payload_len(), which
> > stores 0 above IPV6_MAXPLEN and the real length otherwise, as
> > ipv6_gro_complete() does.  The network header was just reset to
> > skb->data, so skb->len - sizeof(*ip6_hdr) is the payload length.
> >
> > Tested on one kernel (arm64, QEMU) with SELinux permissive, a minimal
> > mdp-generated policy (network_peer_controls=3D1), "netlabelctl calipso
> > add pass doi:16" and a NetLabel mapping of fd00:2::/64 to CALIPSO
> > DOI 16.  calipso_skbuff_setattr() was called through
> > netlbl_skbuff_setattr() from a test-only debugfs hook (not part of
> > this patch) adding a level-only label; payload_len after the call:
> >
> >   case                         before fix   after fix   real length
> >   1000, unlabeled                    1016        1016          1016
> >   70000 GSO, payload_len 0             16           0         70016
> >   65530 GSO, grows past MAXPLEN        10           0         65546
> >   65540 GSO with a 24 byte hop
> >   header, shrinks below MAXPLEN     65528       65532         65532
> >   1000 with a 24 byte hop header      992         992           992
> >
> > (0 means ipv6_payload_len() returns the real length.)  On the forward
> > path, with a client injecting unlabeled UDP through a router to a
> > server, the router adds the CALIPSO option and the server delivers all
> > datagrams (Udp6InDatagrams 5, Ip6InTruncatedPkts 0) with this patch.
> >
> > Fixes: 81fbc812132c ("ipv6/gro: insert temporary HBH/jumbo header")
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Suggested-by: Wang Zhan <wang.zhan@smartx.com>
> > Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> > Assisted-by: Claude:claude-opus-5-5
>
> Reviewed-by: Wang Zhan <wang.zhan@smartx.com>
>
> > @@ -1357,8 +1357,8 @@ static int calipso_skbuff_setattr(struct sk_buff =
*skb,
> >                       sizeof(*ip6_hdr) + start);
> >               skb_reset_network_header(skb);
> >               ip6_hdr =3D ipv6_hdr(skb);
> > -             payload =3D ntohs(ip6_hdr->payload_len);
> > -             ip6_hdr->payload_len =3D htons(payload + len_delta);
> > +             /* 0 above IPV6_MAXPLEN (BIG TCP), the real length otherw=
ise */
>
> nit: consider dropping the comment, it just repeats what
> ipv6_set_payload_len() does.

Agree with the nit, but otherwise this looks good to me.  Thanks to
Joas Antonio dos Santos for identifying the problem and working on the
fix as well as everyone else who took the time to review and comment;
the help is always appreciated!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
