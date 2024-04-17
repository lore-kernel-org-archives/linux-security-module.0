Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C513D8B6
	for <linux-security-module@vger.kernel.org>; Wed, 17 Apr 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359009; cv=none; b=D4Ll04/eMDPETasJfIosPGb+VgF2JnwEgi9pm+gRRxdbNbyfiEBZP3Wvo8dBRQX2NLXfQpr29HNx6iSQ+y2ZVWBKJj2IcslYkx4es9SehTy0zaWCTcPki3uCz1gwhGZAzWSBlqyDxL4oPPOL8UD91Y3l/kW3VwChOZxK6sxZ6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359009; c=relaxed/simple;
	bh=NkB+Msn3F3zi2yVXTxIQuIRxdXhjhJ0HH6ftv8g5tSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVXnOECJAAEctILD4pSZT/O1TLXuX8l3nuguMdHMvriBeFXkngf47kU/H2bN/qpLwQNjEsBuGiFzYp0cM8AuculZ8NI37fisjIhr9aOzlbtWr0M3O9J7m6rTWI4WJZ/aNAm9ajnJChXVayxeH3Gg7bqjQrTja3IK469m2Sf15oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKClmWNa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKClmWNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713359004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26G1YIXu3nnaHY4GSrbN+LZ7zFk+MZj6wrzZJR4DxTU=;
	b=UKClmWNaNV+mbv0XhvTvEmPPkfiNhl1N6YdPP1pcsGNTmf/Yu+Q1eU/Ims4tgvFGwyCoRS
	ug1RPnlM/ouALe2RPsVJZWHXO9vyXb7O1dvXlx6jAdj95NUpjZgVvXMJbvwhgHADOHCRWY
	ECxw/SoroO0QJ/1t+AiAhxZIIzIVA6E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-MW91_cUrMOOHX_zE36A8Fg-1; Wed, 17 Apr 2024 09:03:22 -0400
X-MC-Unique: MW91_cUrMOOHX_zE36A8Fg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a2e0a51adfso5650341a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Apr 2024 06:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713359001; x=1713963801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26G1YIXu3nnaHY4GSrbN+LZ7zFk+MZj6wrzZJR4DxTU=;
        b=CSeCBQcjtHuNHRJZ4psSiLwM51UeNGt/YBsvx82LKERB82FcoAV22gjb+J7pRnUFkp
         VPhxFAXpE2Ak6CMeb3ZBMlnVFpBQn4YcDayNT2leE1xRcNANSuXQEVsG+y5M8HKbTl6G
         J+AUap2FbgU1eEJ538nLQkZOumI9n4r+WVau0WmJu/JrzOjAm5CDTtiteWW6wtfpbJJm
         P8r3/LHbfWl2whvlUJwWrVJUDyU08lJMeG17V85PEw4xW2VISW4XIdAy6XEytA8d1FN+
         J19A/Mi77kErNFaE6bEQbT0hwUuR87EuTqNrGn3MQU+kyWIpHuudX9MZCMtTpvkaZHJ0
         oM8g==
X-Forwarded-Encrypted: i=1; AJvYcCWGp5Ai+Wj4rmv3K470JPVQApLCkiOXyteGC6eQuwfb6bc0sUr/qtcA/iVmLit6wErabNMdpRkOfT8xfloKeuaRgbcKJFm6F2n4h1IZkntLZh2x0jPQ
X-Gm-Message-State: AOJu0Yw9zlmQhWTQGtuYv5BPhFKxOcjceXhY2+nOZmbo+u9b6QutvaHF
	knblZDLS1Nbh1iu2rygSDYJjehK99xZU4/8XHP/3h3qeUe8LEFcayuFgs5r2nH9ksFvoht7PIvM
	ltOXUGq7BSkGbHWRpqcWLcKrHtzgqL4gpk/xkh+VokqTHkiSXcfvB+K0eY+CEIPZ1Mhedkm4rw3
	h+Z6XzOkMtBbm7Dom6L46zbcTXM5z97PMN5ezSqaA1h97ZB1e/
X-Received: by 2002:a17:90a:5986:b0:2a7:cd5:faa6 with SMTP id l6-20020a17090a598600b002a70cd5faa6mr12729311pji.44.1713359000798;
        Wed, 17 Apr 2024 06:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY3kh+348CK9g4KdKxhbpqEYFu+AOjI48v9vv/dqKsw3pGfGOb0lYsqb/V5xSBL4VIU8p51yq7fBdeJgzQpkw=
X-Received: by 2002:a17:90a:5986:b0:2a7:cd5:faa6 with SMTP id
 l6-20020a17090a598600b002a70cd5faa6mr12729288pji.44.1713359000415; Wed, 17
 Apr 2024 06:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-3-omosnace@redhat.com> <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
In-Reply-To: <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 17 Apr 2024 15:03:09 +0200
Message-ID: <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > As the comment in this function says, the code currently just clears th=
e
> > CIPSO part with IPOPT_NOP, rather than removing it completely and
> > trimming the packet. This is inconsistent with the other
> > cipso_v4_*_delattr() functions and with CALIPSO (IPv6).
>
> This sentence above implies an equality in handling between those three
> cases that doesn't exist.  IPv6 has a radically different approach to
> IP options, comparisions between the two aren't really valid.

I don't think it's that radically different. Look at
calipso_skbuff_delattr() and you will see that it already does
something very similar as cipso_v4_skbuff_delattr() after this patch.
If the CALIPSO options are the only thing in the hopopt header, it
removes it altogether. If there are other options, it removes the part
with the CALIPSO options - here it is less pedantic and replaces it
with up to 7-byte padding if the length of the CALIPSO part is not
8-byte aligned, presumably to avoid having to move the subsequent
options (if any) and adjust the padding at the end.

> Similarly,
> how we manage IPv4 options on sockets (req or otherwise) is pretty
> different from how we manage them on packets, and that is intentional.

Perhaps, but that is an implementation detail to the user. The
resulting packet content should ideally be the same regardless of
which method of injecting the options is used, when possible.

> Drop the above sentence, or provide a more detailed explanation of the
> three aproaches explaining when they can be compared and when they
> shouldn't be compared.

I'm not sure why you think they shouldn't be compared, but I can
surely be more detailed in making my case there.

> > Implement the proper option removal to make it consistent and producing
> > more optimal IP packets when there are CIPSO options set.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  net/ipv4/cipso_ipv4.c | 89 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 59 insertions(+), 30 deletions(-)
>
> Outside of the SELinux test suite, what testing have you done when you
> have a Linux box forwarding between a CIPSO network segment and an
> unlabeled segment?  I'm specifically interested in stream based protocols
> such as TCP.  Also, do the rest of the netfilter callbacks handle it okay
> if the skb changes size in one of the callbacks?  Granted it has been
> *years* since this code was written (decades?), but if I recall
> correctly, at the time it was a big no-no to change the skb size in a
> netfilter callback.

I didn't test that, TBH. But all of cipso_v4_skbuff_setattr(),
calipso_skbuff_setattr(), and calipso_skbuff_delattr() already do
skb_push()/skb_pull(), so they would all be broken if that is (still?)
true. And this new cipso_v4_skbuff_delattr() doesn't do anything
w.r.t. the skb and the IP header that those wouldn't do already.

[...]
> > @@ -2246,7 +2253,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
> >   */
> >  int cipso_v4_skbuff_delattr(struct sk_buff *skb)
> >  {
> > -     int ret_val;
> > +     int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_h=
dr_len,
> > +         hdr_len_delta;
>
> Please keep line lengths under 80-chars whenever possible.  I know Linus
> relaxed that requirement a while ago, but I still find the 80-char limit
> to be a positive thing.

I believe the line is exactly 80 characters, so still within the
limit. Or is it < 80 instead of <=3D 80? Does it really matter?

>
> >       struct iphdr *iph;
> >       struct ip_options *opt =3D &IPCB(skb)->opt;
> >       unsigned char *cipso_ptr;
> > @@ -2259,16 +2267,37 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb=
)
> >       if (ret_val < 0)
> >               return ret_val;
> >
> > -     /* the easiest thing to do is just replace the cipso option with =
noop
> > -      * options since we don't change the size of the packet, although=
 we
> > -      * still need to recalculate the checksum */
>
> Unless you can guarantee that the length change isn't going to have
> any adverse effects (even then I would want to know why you are so
> confident), I'd feel a lot more comfortable sticking with a
> preserve-the-size-and-fill approach.  If you want to change that from
> _NOP to _END, I'd be okay with that.
>
> (and if you are talking to who I think you are talking to, I'm guessing
> the _NOP to _END swap would likely solve their problem)

So, to reveal all the cards, the issue that has prompted me to send
this patch is that a user may have a router configured to drop packets
containing any IP options [1][2] and may expect a Linux host with
NetLabel configured as unlabeled for a target IP address to
output/forward packets without IP options if CIPSO was the only option
present before NetLabel processing (such that it can then pass through
the strict router(s)).

Padding with IPOPT_END *might* solve this particular case, but I'm not
sure if the routers would really interpret such padding as "no
options"... I'll try to ask the reporter to test such a patch and
we'll see. But still, I don't yet see a convincing reason to not go
all the way and make sure we send optimally-sized packets here.

Side note: We could only clear CIPSO with IPOPT_END if it's the last
option in the header, but that limitation doesn't really matter for
the use case described above.

[1] https://www.stigviewer.com/stig/juniper_router_rtr/2019-09-27/finding/V=
-90937
[2] https://www.stigviewer.com/stig/cisco_ios_xe_router_rtr/2021-03-26/find=
ing/V-217001

>
> >       iph =3D ip_hdr(skb);
> >       cipso_ptr =3D (unsigned char *)iph + opt->cipso;
> > -     memset(cipso_ptr, IPOPT_NOOP, cipso_ptr[1]);
> > +     cipso_len =3D cipso_ptr[1];
> > +
> > +     hdr_len_actual =3D sizeof(struct iphdr) +
> > +                      cipso_v4_get_actual_opt_len((unsigned char *)(ip=
h + 1),
> > +                                                  opt->optlen);
> > +     new_hdr_len_actual =3D hdr_len_actual - cipso_len;
> > +     new_hdr_len =3D (new_hdr_len_actual + 3) & ~3;
> > +     hdr_len_delta =3D (iph->ihl << 2) - new_hdr_len;
> > +
> > +     /* 1. shift any options after CIPSO to the left */
> > +     memmove(cipso_ptr, cipso_ptr + cipso_len,
> > +             new_hdr_len_actual - opt->cipso);
> > +     /* 2. move the whole IP header to its new place */
> > +     memmove((unsigned char *)iph + hdr_len_delta, iph, new_hdr_len_ac=
tual);
> > +     /* 3. adjust the skb layout */
> > +     skb_pull(skb, hdr_len_delta);
> > +     skb_reset_network_header(skb);
> > +     iph =3D ip_hdr(skb);
> > +     /* 4. re-fill new padding with IPOPT_END (may now be longer) */
> > +     memset((unsigned char *)iph + new_hdr_len_actual, IPOPT_END,
> > +            new_hdr_len - new_hdr_len_actual);
> > +     opt->optlen -=3D hdr_len_delta;
> >       opt->cipso =3D 0;
> >       opt->is_changed =3D 1;
> > -
> > +     if (hdr_len_delta !=3D 0) {
> > +             iph->ihl =3D new_hdr_len >> 2;
> > +             iph_set_totlen(iph, skb->len);
> > +     }
> >       ip_send_check(iph);
> >
> >       return 0;
> > --
> > 2.44.0
>
> --
> paul-moore.com
>

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

