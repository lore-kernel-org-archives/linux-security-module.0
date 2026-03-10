Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3A2D8DCA
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159436; cv=pass; b=hQrJq020rejjH9xasCoVnrnrNQRapAQmQ2WKbSS11rnUvngBOXMg5b8cTYCd8K3W5zWnh0QMOdyqKImNjcCqWbYCZtx3zyTDsElT+Ed9TBVA2A92n1aZazGNpZZFWuxoXrQS5PaRsU4j+odQ+XMhtXNebK9WUW+IAYSIGPUIkuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159436; c=relaxed/simple;
	bh=jA6rZpVYq5bMHBbyJsUtaFneg2H8srjFU0y02ik2O58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Thm/kNbpctXQ78YETj+PKPIvwKiuSytx7e79S1NdKF1vhgyIwU4KqbXZa315CcpCBIykIrlnGn7oTo6Jc+xLiKKUPTop/VT3p0bZEbxqagdMnDHYUwc3aIoNQky6ltGJKPWTg71ovTkWwFXDjb3acjz8zwlSreRw5UqsHpAT3xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nt6MuXzr; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nt6MuXzr"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12732e6a123so158693c88.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 09:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773159433; cv=none;
        d=google.com; s=arc-20240605;
        b=NfTtYP9s0AMrlWE5X3/Jz+ukk0qqzoZMiNoIyP0AhajY2iT4Ff2OF74L+9YAbkxTat
         A7Vb39o2yGP9y4P/+olWYgjcZiwk73fWzgBfX6M7zyr+pxEIXZ1AQa9pM3IzlhvAZnK6
         dv6T8e5eU0cVxOKWh2YZHmL7wxyHURYbEch7cqIrs+/KoIUZQ/0ScZvi9OdaRFfmsVvt
         nSVP9+FYgLD66ciN/TEUtUe5U1RtnJxHkXlt2+7Doc6UgC6Y0lUsWcH/H75KSIuAtCD0
         gTimkUbDSJZ9YhnBzWyTZg7LpEJy39lcY97gI+5LSKaWqq1JjB0qpdkYtW5EZ7xUZV72
         W1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xBoK0ILVDset3KJAMLm9VclkZQJwqYX+/JNYcMjkA+0=;
        fh=fiuxtQBy5PuGhShyegWd0As8aZF0Lmdi1gtkWPSFplk=;
        b=LikvD3NhkJwxI3W5btQdwVpoYxPCbGpwWfm3VsJTKtnUu6zeypPB4VVx80kHJh6y8R
         kdNwAd8JlAhHD3K6mPWB1qgAnhqmyu7pB/ThHx2ZbgTVJyThpaWxVZDpG3pyNDbXQTjR
         H1EqY5fCERlQjcawdCGDbIEX30SYMnRdC7YXd78jyxoAL7zlLI+JnatULheZKVSU1l2x
         2k575dsL7oO5/BHZIIoAmzdHD29gTdMg6oCMJ/HsEB6/BdMJtpoy5CJitKQ2ny2YhkEm
         3/XNJexF81+km/RUMkgVFyszGWhlCcQrBncJo0L5NWf+rEDHdbo+l2VwznZ3/Dx3VPGI
         NNZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773159433; x=1773764233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBoK0ILVDset3KJAMLm9VclkZQJwqYX+/JNYcMjkA+0=;
        b=nt6MuXzr286FIiSrIMGxLGbt7guPQk7TSxPDrNJksGZ6CeCoBowNH63Ns1pxmVr0T0
         F5dp3EqsapITnuZlj6wycFDGBOD/NCIDFrKuLxU6UStdvVH43+k7tGsqr2ci57508Xid
         qNhd/sqcAhAgbr+rzJ7n3yjiiIvqi0LBDhTeJZPXj/gVMdYP+KgrHc9Giq9M9JwTeBRT
         FgdNWHnXIME7KmgGCafArEdd7Nw27JVaUstvMoUgJhbulMtdS2EC5LSMtsd3s+73GG51
         DAsHTega9VjVSs086SNzot86R5VLg8QXy6fWoQ7vmP7StoUB2JrKD7/ly8vbdIzP9EyU
         nfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773159433; x=1773764233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBoK0ILVDset3KJAMLm9VclkZQJwqYX+/JNYcMjkA+0=;
        b=HYVnky3B4L8KUS9DC3ZlEPDaVGebqjahyKPRYb/LXEV0UcFrn8cXbl/v+GTKLnXue3
         ivZJV5WwuLxEBxZPLZ2urDdKZrwXv0numGd+le8JbTcyR6yTvEFvkn3xg0ReCjDFp1ee
         4Tagcr8gkcZIaQj+iuXq89d5SNn+RrPyYdVHDR/NxKvOK3ih9L2M3kMdcqYgn9XMAuTp
         6sY+QsBuJndT5Z6ITvQ7XTdcQ04Tl1B0V1uZwj6Iw6tT8iupE6r6r4RB3kaLZQ6nr1WS
         A3ZnlJRCMvPnjhG5Pk8CxVJi6bp8HVtX9Xd+MnIBB5htfzYrQyy9t6jBh0PTWZrxYGo4
         kCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg8YBRMV/ep1R3P/MAk7D/fJVQvD2E1a2AYse0tUWMyqBtrWEQnyC8vcdxN4L5lr2b187TC+o0MjyoN11m1P1ktYvuJkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzaMTsw5zCmcKRRlisIESah0FJEmQmXU2gLyovR7TCWI6qZaw4
	qrSWyQakvuTqx+7apllCJUS62/j8YVCSioarczKeF6Ixfox51DuK5aQi70rbDEXZt2ubBo38Dw2
	BVns237O6zls1TafOydzMJPW+Vp3b0O5d/Nu/TlK1
X-Gm-Gg: ATEYQzxRq9eLj/BqM7AHQH/n7nOojAu2QCTqvB9C9gvLRwZvXLxEPZjdRa5uDsiES9K
	K7TZPw70iKvMel4nLudF9L6Xym8EV2uNzwyPeq6PetABPAhCxc+CaNmipaMFpoRJyynXs+EQlTH
	DoMRTgZxgbZmU6Ac/x0xUb6fkEzsnHmKlf1gvcOGwdlwXoA+l7yuBl8i35ZRHnMnQc+t4MljJ5d
	/XbrKN+EeOZEOf0ba13RIQW7TEhrYjBM5j8vItZQT9eYMZA2EiZ/yAknD5Iim0R/x2Vuow1PyqU
	ev7nlnwVjfIDjXXQ3TlPkY2kt649RbCj4KKuwsJzZR22HB2s6fjlQpPut6Aij8G3+c2b44E=
X-Received: by 2002:a05:7022:217:b0:119:e569:fbb4 with SMTP id
 a92af1059eb24-128c2ec2f69mr7177147c88.35.1773159432496; Tue, 10 Mar 2026
 09:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305215013.2984628-8-kuniyu@google.com> <20260310102555.147680-1-pabeni@redhat.com>
In-Reply-To: <20260310102555.147680-1-pabeni@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 09:17:01 -0700
X-Gm-Features: AaiRm52tVbsRFsnhdR1wCpfFj-wF1scdUVu4b0pjKpsyTNEAQqRKS-aRJ3EETZM
Message-ID: <CAAVpQUB-pC_LLJhMR2iNevZtkhf1V3xFD9ycthW2bqKQ0TF9fw@mail.gmail.com>
Subject: Re: [v2,net-next,07/15] udp: Remove partial csum code in RX.
To: Paolo Abeni <pabeni@redhat.com>
Cc: willemb@google.com, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	jmorris@namei.org, casey@schaufler-ca.com, paul@paul-moore.com, 
	kuni1840@gmail.com, fw@strlen.de, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> udp: Remove partial csum code in RX.
>
> This commit removes UDP-Lite specific partial checksum handling from UDP
> receive paths, including removal of UDP_SKB_CB fields, simplification of
> checksum initialization functions, and elimination of UDP-Lite guards.
>
> Link: https://lore.kernel.org/netdev/20260305215013.2984628-8-kuniyu@goog=
le.com/
>
> > diff --git a/include/net/udp.h b/include/net/udp.h
> > --- a/include/net/udp.h
> > +++ b/include/net/udp.h
>
> [ ... ]
>
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
>
> [ ... ]
>
> > @@ -2703,14 +2647,15 @@ static int __udp4_lib_rcv(struct sk_buff *skb, =
struct udp_table *udptable,
> >       if (ulen > skb->len)
> >               goto short_packet;
> >
> > -     if (proto =3D=3D IPPROTO_UDP) {
> > -             /* UDP validates ulen. */
> > -             if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
> > +     /* UDP validates ulen. */
> > +     if (ulen < sizeof(*uh)) {
> > +             if (pskb_trim_rcsum(skb, ulen))
> >                       goto short_packet;
> > +
> >               uh =3D udp_hdr(skb);
> >       }
> >
> > -     if (udp4_csum_init(skb, uh, proto))
> > +     if (udp4_csum_init(skb, uh))
> >               goto csum_error;
> >
>
> Does this refactoring introduce two bugs?
>
> The old code checked both conditions with short-circuit OR:
>   if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
>       goto short_packet;
>
> This correctly (1) rejected packets where ulen < 8, and (2) trimmed the
> SKB to the declared UDP length when ulen < skb->len.
>
> The new code changes the logic structure:
>   if (ulen < sizeof(*uh)) {
>       if (pskb_trim_rcsum(skb, ulen))
>           goto short_packet;
>       uh =3D udp_hdr(skb);
>   }
>
> First potential bug: When sizeof(*uh) <=3D ulen < skb->len, the entire bl=
ock
> is skipped. This means pskb_trim_rcsum() is never called, so the SKB
> retains trailing data beyond the declared UDP length. Won't this cause
> checksum calculations to include extraneous bytes, leading to valid packe=
ts
> being incorrectly rejected?
>
> This scenario occurs when UDP length < IP payload length, which can happe=
n
> with malformed or crafted packets.
>
> Second potential bug: When ulen < sizeof(*uh), the old code would
> immediately goto short_packet via the || short-circuit. The new code ente=
rs
> the block and tries to trim the SKB to a sub-header-size length. If
> pskb_trim_rcsum() succeeds, processing continues with skb->len <
> sizeof(struct udphdr). Is this safe?
>
> Looking at the IPv6 counterpart __udp6_lib_rcv(), it handles this
> differently:
>
>   if (ulen < sizeof(*uh))
>       goto short_packet;
>
>   if (ulen < skb->len) {
>       if (pskb_trim_rcsum(skb, ulen))
>           goto short_packet;
>       saddr =3D &ipv6_hdr(skb)->saddr;
>       daddr =3D &ipv6_hdr(skb)->daddr;
>       uh =3D udp_hdr(skb);
>   }
>
> Should the IPv4 code follow the same pattern, or should it preserve the
> original short-circuit logic:

Indeed, I'll follow the IPv6 pattern there.

Thanks !
